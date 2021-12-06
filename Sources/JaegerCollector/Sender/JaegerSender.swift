
@available(iOS 15, *)
public final class JaegerSender: TraceSender {

    // MARK: Stored Properties

    public let serviceName: String
    public let tags: Tags
    public let channel: GRPCChannel

    // MARK: Computed Properties

    private var process: JaegerProcess {
        .with { process in
            process.serviceName = serviceName
            process.tags = tags.array.map(jaegerTag)
        }
    }

    // MARK: Initialization

    public init(serviceName: String, tags: Tags, channel: GRPCChannel) {
        self.serviceName = serviceName
        self.tags = tags
        self.channel = channel
    }

    // MARK: Methods

    public func send(_ spans: [Span]) async throws -> Void {
        let client = JaegerClient(channel: channel)
        let call = client.postSpans(request(for: spans))

        return try await withCheckedThrowingContinuation { continuation in
            call.response.whenComplete { result in
                continuation.resume(with: result.map { _ in })
            }
        }
    }

    // MARK: Helpers

    private func request(for spans: [Span]) -> JaegerPostSpansRequest {
        .with { request in
            request.batch = .with { batch in
                batch.process = process
                batch.spans = spans.map(jaegerSpan)
            }
        }
    }

    private func jaegerSpan(for span: Span) -> JaegerSpan {
        .with { newSpan in
            newSpan.traceID = span.context.traceID.data
            newSpan.spanID = span.context.spanID.data.suffix(8)
            newSpan.operationName = span.name
            newSpan.references = references(for: span)
            newSpan.startTime = .init(date: span.startTime)
            newSpan.duration = .init(timeInterval: (span.endTime ?? Date()).timeIntervalSince(span.startTime))
            newSpan.tags = span.tags.map { jaegerTag(for: .init(key: $0, value: $1)) }
            newSpan.process = process
            newSpan.logs = span.logs.map(jaegerLog)
        }
    }

    private func references(for span: Span) -> [JaegerSpanReference] {
        guard let parent = span.parent else { return [] }
        return [
            .with { reference in
                reference.traceID = parent.context.traceID.data
                reference.spanID = parent.context.spanID.data.suffix(8)
            }
        ]
    }

    private func jaegerLog(for log: Log) -> JaegerLog {
        .with { newLog in
            newLog.timestamp = .init(date: log.date)
            newLog.fields = log.tags.array.map(jaegerTag)
        }
    }

    private func jaegerTag(for tag: Tag) -> JaegerTag {
        .with { newTag in
            newTag.key = tag.key
            switch tag.value {
            case let .string(value):
                newTag.vType = .string
                newTag.vStr = value
            case let .boolean(value):
                newTag.vType = .bool
                newTag.vBool = value
            case let .double(value):
                newTag.vType = .float64
                newTag.vFloat64 = value
            case let .integer(value):
                newTag.vType = .int64
                newTag.vInt64 = Int64(value)
            case let .data(value):
                newTag.vType = .binary
                newTag.vBinary = value
            }
        }
    }

}

extension UUID {

    var data: Data {
        withUnsafePointer(to: uuid) {
            Data(bytes: $0, count: MemoryLayout.size(ofValue: uuid))
        }
    }

}

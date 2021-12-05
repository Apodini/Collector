
@available(iOS 15, *)
public final class BasicAgent: Agent {

    // MARK: Stored Properties

    public let sender: TraceSender
    public let interval: TimeInterval

    private var lastSendDate: Date
    private var spans = [Span]()

    // MARK: Initialization

    public init(interval: TimeInterval, sender: TraceSender) {
        self.interval = interval
        self.sender = sender
        self.lastSendDate = Date()
    }

    // MARK: Methods

    public func record(_ span: Span) {
        guard span.isSampled else { return }
        spans.append(span)

        if -lastSendDate.timeIntervalSinceNow >= interval {
            lastSendDate = Date()
            send()
        }
    }

    public func send() {
        let spansToSend = spans
        spans.removeAll(keepingCapacity: true)

        guard !spansToSend.isEmpty else { return }

        Task { [sender] in
            do {
                try await sender.send(spansToSend)
                print(Self.self, #function, "success")
            } catch {
                print(Self.self, #function, "failure:", error)
            }
        }
    }

}

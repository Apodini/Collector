
public final class BasicAgent: Agent {

    // MARK: Stored Properties

    public let sender: TraceSender
    public let interval: TimeInterval

    private var lastSendDate: Date
    private var spans = [Span]()

    private let queue = DispatchQueue(label: String(describing: BasicAgent.self))

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

        queue.async { [sender] in
            do {
                try sender.send(spansToSend).wait()
                print(Self.self, #function, "success")
            } catch {
                print(Self.self, #function, "failure:", error)
            }
        }
    }

}


public protocol TraceSender {
    func send(_ spans: [Span]) -> EventLoopFuture<Void>
}

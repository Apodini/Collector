
@available(iOS 15, *)
public protocol TraceSender {
    func send(_ spans: [Span]) async throws
}

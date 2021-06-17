
public final class BasicTracer: Tracer {

    // MARK: Stored Properties

    public let agent: Agent
    public let sampling: Sampling

    private var openSpanIDs = [UUID]()

    // MARK: Initialization

    public init(
        agent: Agent,
        sampling: Sampling = .constant(true)
    ) {
        self.agent = agent
        self.sampling = sampling
    }

    // MARK: Methods

    public func span(name: String,
                     reference: Span.Reference?,
                     startTime: Date,
                     isSampled: Bool?) -> Span {

        let id = UUID()
        openSpanIDs.append(id)

        return Span(
            tracer: self,
            id: id,
            parent: reference,
            name: name,
            isSampled: isSampled ?? sampling.strategy.isSampled(open: openSpanIDs),
            startTime: startTime
        )
    }

    public func report(_ span: Span) {
        openSpanIDs.removeAll { $0 == span.context.spanID }
        agent.record(span)
    }

}

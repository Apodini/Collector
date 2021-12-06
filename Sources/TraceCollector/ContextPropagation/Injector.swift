
public protocol Injector {
    associatedtype Carrier
    func inject(_ value: String, forKey key: String, into carrier: inout Carrier)
}

extension Span {

    public func propagate<I: Injector>(
        in carrier: inout I.Carrier,
        using injector: I
    ) {
        injector.inject(context.spanID.uuidString,
                        forKey: ContextPropagation.Key.spanID,
                        into: &carrier)
        injector.inject(context.traceID.uuidString,
                        forKey: ContextPropagation.Key.traceID,
                        into: &carrier)
        let isSampledValue = isSampled
            ? ContextPropagation.Value.true
            : ContextPropagation.Value.false
        injector.inject(isSampledValue,
                        forKey: ContextPropagation.Key.isSampled,
                        into: &carrier)
    }

}


public protocol Extractor {
    associatedtype Carrier
    func extract(key: String, from carrier: Carrier) -> String?
}

extension Extractor {

    public func isSampled(from carrier: Carrier) -> Bool {
        guard let stringValue = extract(key: ContextPropagation.Key.isSampled, from: carrier) else {
            return true
        }
        switch stringValue {
        case ContextPropagation.Value.true:
            return true
        case ContextPropagation.Value.false:
            return false
        default:
            return true
        }
    }

    public func spanReference(from carrier: Carrier) -> Span.Reference? {
        guard let traceID = traceID(from: carrier),
            let spanID = spanID(from: carrier) else {
                return nil
        }
        return .child(of: .init(traceID: traceID, spanID: spanID))
    }

    private func traceID(from carrier: Carrier) -> UUID? {
        extract(key: ContextPropagation.Key.traceID, from: carrier)
            .flatMap(UUID.init)
    }

    private func spanID(from carrier: Carrier) -> UUID? {
        extract(key: ContextPropagation.Key.spanID, from: carrier)
            .flatMap(UUID.init)
    }

}

extension Tracer {

    public func span<E: Extractor>(
        name: String,
        startTime: Date = .init(),
        from carrier: E.Carrier,
        using extractor: E
    ) -> Span {
        span(name: name,
             reference: extractor.spanReference(from: carrier),
             startTime: startTime,
             isSampled: extractor.isSampled(from: carrier))
    }

}


public protocol Tracer: AnyObject {

    // MARK: Methods

    func span(name: String,
              reference: Span.Reference?,
              startTime: Date,
              isSampled: Bool?) -> Span

    func report(_ span: Span)

}

extension Tracer {

    public func span(name: String,
                     reference: Span.Reference? = nil,
                     startTime: Date = Date()) -> Span {

        span(name: name,
             reference: reference,
             startTime: startTime,
             isSampled: nil)
    }

}

//
//  URLRequest+Context.swift
//  
//
//  Created by Paul Kraft on 05.12.21.
//

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

private struct URLRequestModifier: Extractor, Injector {

    func extract(key: String, from carrier: URLRequest) -> String? {
        carrier.value(forHTTPHeaderField: key)
    }

    func inject(_ value: String, forKey key: String, into carrier: inout URLRequest) {
        carrier.setValue(value, forHTTPHeaderField: key)
    }

}

extension Tracer {

    public func span(
        name: String,
        startTime: Date = .init(),
        from request: URLRequest
    ) -> Span {

        span(
            name: name,
            startTime: startTime,
            from: request,
            using: URLRequestModifier()
        )
    }

}

extension Span {

    public func propagate(in request: inout URLRequest) {
        propagate(in: &request, using: URLRequestModifier())
    }

}

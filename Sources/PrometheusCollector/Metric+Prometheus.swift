
import Metrics
import Prometheus

extension Metric {

    public static func setup() {
        do {
            _ = try MetricsSystem.prometheus()
        } catch {
            let client = PrometheusClient()
            MetricsSystem.bootstrap(PrometheusMetricsFactory(client: client))
        }
    }

    public static func string(on eventLoop: EventLoop) -> EventLoopFuture<String> {
        do {
            let promise = eventLoop.makePromise(of: String.self)
            try MetricsSystem.prometheus().collect(into: promise)
            return promise.futureResult
        } catch {
            return eventLoop.makeFailedFuture(error)
        }
    }

    public static func buffer(on eventLoop: EventLoop) -> EventLoopFuture<ByteBuffer> {
        do {
            let promise = eventLoop.makePromise(of: ByteBuffer.self)
            try MetricsSystem.prometheus().collect(into: promise)
            return promise.futureResult
        } catch {
            return eventLoop.makeFailedFuture(error)
        }
    }

}

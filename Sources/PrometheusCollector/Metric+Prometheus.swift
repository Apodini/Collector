
import NIO

extension Metric {

    public static func setup() {
        do {
            _ = try MetricsSystem.prometheus()
        } catch {
            let client = PrometheusClient()
            MetricsSystem.bootstrap(PrometheusMetricsFactory(client: client))
        }
    }

    @available(iOS 15, *)
    public static func string() async throws -> String {
        let prometheus = try MetricsSystem.prometheus()
        return await withCheckedContinuation { continuation in
            prometheus.collect {
                continuation.resume(returning: $0)
            }
        }
    }

    @available(iOS 15, *)
    public static func buffer() async throws -> ByteBuffer {
        let prometheus = try MetricsSystem.prometheus()
        return await withCheckedContinuation { continuation in
            prometheus.collect {
                continuation.resume(returning: $0)
            }
        }
    }

}

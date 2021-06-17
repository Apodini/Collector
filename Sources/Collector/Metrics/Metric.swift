
import Metrics

public enum Metric {

    public static func counter(
        label: String,
        dimensions: [String: String] = [:]
    ) -> Counter {
        Counter(label: label,
                dimensions: Array(dimensions))
    }

    public static func recorder(
        label: String,
        dimensions: [String: String] = [:]
    ) -> Recorder {
        Recorder(label: label,
                 dimensions: Array(dimensions))
    }

    public static func gauge(
        label: String,
        dimensions: [String: String] = [:]
    ) -> Gauge {
        Gauge(label: label,
              dimensions: Array(dimensions))
    }

    public static func timer(
        label: String,
        dimensions: [String: String] = [:]
    ) -> Timer {
        Timer(label: label,
              dimensions: Array(dimensions))
    }

}

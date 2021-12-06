
public protocol SamplingStrategy {
    func isSampled(open: [UUID]) -> Bool
}

public struct Sampling {

    // MARK: Stored Properties

    public var strategy: SamplingStrategy

    // MARK: Initialization

    public init(strategy: SamplingStrategy) {
        self.strategy = strategy
    }

}

// MARK: - Constant

extension Sampling {

    private struct ConstantSamplingStrategy: SamplingStrategy {

        let value: Bool

        func isSampled(open: [UUID]) -> Bool {
            value
        }

    }

    public static func constant(_ value: Bool) -> Sampling {
        .init(strategy: ConstantSamplingStrategy(value: value))
    }

}

// MARK: - Probability

extension Sampling {

    private struct ProbabilitySamplingStrategy: SamplingStrategy {

        let value: Double

        func isSampled(open: [UUID]) -> Bool {
            Double.random(in: 0...1) <= value
        }

    }

    public static func probability(_ value: Double) -> Sampling {
        assert(0...1 ~= value)
        return .init(strategy: ProbabilitySamplingStrategy(value: value))
    }

}

// MARK: - Limit

extension Sampling {

    private struct LimitSamplingStrategy: SamplingStrategy {

        let value: Int

        func isSampled(open: [UUID]) -> Bool {
            open.count < value
        }

    }

    public static func limit(_ value: Int) -> Sampling {
        assert(value > 0)
        return .init(strategy: LimitSamplingStrategy(value: value))
    }

}

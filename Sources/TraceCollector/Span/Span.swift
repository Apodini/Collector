
public final class Span {

    // MARK: Stored Properties

    private let tracer: Tracer
    public let context: Span.Context
    public let parent: Span.Reference?
    public let name: String
    public let isSampled: Bool
    public let startTime: Date
    public private(set) var endTime: Date?

    public var tags = Tags()
    public var logs = [Log]()

    // MARK: Computed Properties

    public var isCompleted: Bool {
        endTime != nil
    }

    // MARK: Initialization

    init(
        tracer: Tracer,
        id: UUID,
        parent: Span.Reference?,
        name: String,
        isSampled: Bool,
        startTime: Date
    ) {
        self.tracer = tracer
        self.context = .init(traceID: parent?.context.traceID ?? UUID(), spanID: id)
        self.parent = parent
        self.name = name
        self.isSampled = isSampled
        self.startTime = startTime
    }

    deinit {
        finish()
    }

    // MARK: Methods - Tags

    public func set(_ value: String, forKey key: Tag.Key) {
        set(tag: Tag(key: key, value: .string(value)))
    }

    public func set(_ value: Double, forKey key: Tag.Key) {
        set(tag: Tag(key: key, value: .double(value)))
    }

    public func set(_ value: Bool, forKey key: Tag.Key) {
        set(tag: Tag(key: key, value: .boolean(value)))
    }

    public func set(_ value: Int, forKey key: Tag.Key) {
        set(tag: Tag(key: key, value: .integer(value)))
    }

    public func set(_ value: Data, forKey key: Tag.Key) {
        set(tag: Tag(key: key, value: .data(value)))
    }

    private func set(tag: Tag) {
        guard !isCompleted else {return}
        tags[tag.key] = tag.value
    }

    // MARK: Methods - Log

    public func log(_ tags: Tags, at time: Date = .init()) {
        guard !isCompleted else { return }
        logs.append(.init(date: time, tags: tags))
    }

    // MARK: Methods - Lifecycle

    public func finish(at time: Date = Date()) {
        guard !isCompleted else { return }
        endTime = time
        tracer.report(self)
    }

    public func child(name: String, startTime: Date = Date()) -> Span {
        tracer.span(name: name, reference: .child(of: context), startTime: startTime)
    }

}

// MARK: - Nested Types

extension Span {

    public struct Context: Hashable {
        public let traceID: UUID
        public let spanID: UUID
    }

    public struct Reference: Hashable {

        // MARK: Nested Types

        public enum Kind: String {
            case childOf
            case followsFrom
        }

        // MARK: Stored Properties

        public let kind: Reference.Kind
        public let context: Span.Context

        // MARK: Factory Functions

        public static func child(of parent: Span.Context) -> Reference {
            Reference(kind: .childOf, context: parent)
        }

        public static func follows(from parent: Span.Context) -> Reference {
            Reference(kind: .followsFrom, context: parent)
        }

    }

}

// MARK: - Hashable

extension Span: Hashable {

    public static func == (lhs: Span, rhs: Span) -> Bool {
        lhs.context == rhs.context
    }

    public func hash(into hasher: inout Hasher) {
        context.hash(into: &hasher)
    }

}

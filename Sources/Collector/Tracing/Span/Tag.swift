
public typealias Tags = [Tag.Key: Tag.Value]

extension Tags {

    public var array: [Tag] {
        map { .init(key: $0, value: $1) }
    }

}

public struct Tag: Equatable {

    // MARK: Stored Properties

    public let key: Tag.Key
    public let value: Tag.Value

    // MARK: Initialization

    public init(key: Tag.Key, value: Tag.Value) {
        self.key = key
        self.value = value
    }

}

// MARK: - Nested Types

extension Tag {

    public typealias Key = String

    public enum Value: Equatable {
        case string(String)
        case double(Double)
        case boolean(Bool)
        case integer(Int)
        case data(Data)
    }

}

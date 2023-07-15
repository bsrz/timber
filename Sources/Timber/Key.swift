/// Represents a unique idenifier; currently being used by the configuration to hold uniquely identified attributes
public struct Key: Codable, Hashable, RawRepresentable {

    public var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

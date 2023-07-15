extension Value: ExpressibleByStringInterpolation {

    public init(stringLiteral value: String) {
        self.init(segments: [.init(internal: value, external: value)])
    }

    public init(stringInterpolation: StringInterpolation) {
        self.init(segments: stringInterpolation.segments)
    }

    public struct StringInterpolation: StringInterpolationProtocol {

        public var segments: [Segment] = []

        public init(literalCapacity: Int, interpolationCount: Int) {
            segments.reserveCapacity(interpolationCount * 2)
        }

        public mutating func appendLiteral(_ literal: StringLiteralType) {
            segments.append(.init(internal: literal, external: literal))
        }

        public mutating func appendInterpolation(_ value: (any LosslessStringConvertible)?, _ modifier: Modifier = .private) {
            let value = value?.description ?? "<nil>"
            segments.append(.init(internal: value, external: modifier.modify(value)))
        }

        public mutating func appendInterpolation<T>(_ value: T.Type, _ modifier: Modifier = .public) {
            appendInterpolation("\(value)", modifier)
        }

        public mutating func appendInterpolation(verbatim value: Any, _ modifier: Modifier = .private) {
            appendInterpolation("\(value)", modifier)
        }
    }
}

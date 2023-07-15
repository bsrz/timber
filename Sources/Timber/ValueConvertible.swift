/// A protocol allowing any value to be converted to a `Value`; this allows interpolation of any confofrming types
public protocol ValueConvertible {
    var logValue: Value { get }
}

extension Value.StringInterpolation {
    public mutating func appendInterpolation<T: ValueConvertible>(_ value: T) {
        segments.append(contentsOf: value.logValue.segments)
    }
}

extension Value: ValueConvertible {
    public var logValue: Value { self }
}

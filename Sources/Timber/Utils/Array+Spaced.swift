extension Array where Element == String {

    /// A string representation containing all elements separated with a space
    var spaced: String { joined(separator: " ") }
}

extension Modifier {

    /// A modifier that redacts the input string
    public static var `private`: Modifier { .init { _ in "<REDACTED>" } }

    /// A modifier that does not modify the input string
    public static var `public`: Modifier { .init { $0 } }
}

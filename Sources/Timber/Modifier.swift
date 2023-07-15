/// A modifier is used to modify a log message in any way necessary; this type is used for private and public modifiers
public struct Modifier {

    /// A function that takes the input string and returns a modified version of that string
    public let modify: (String) -> String
}

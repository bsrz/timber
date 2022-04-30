/// An that that receives log messages from the logger
///
/// Supports the ability to receive a call for each and every log message as well as
/// a call if and when the destionation should consider flushing its cache, if any.
public struct Destination {

    public typealias Send = (Message, Configuration, Execution) -> Void
    public typealias Flush = () -> Void

    /// A function for receiving every log message
    public var send: Send

    /// An optional function for when the destination should flush its cache, if any
    ///
    /// This function is particularly useful when the logger is about to lose network connectivity
    /// or when the application is about to be backgrounded
    public var flush: Flush?

    /// Initializes a new destination
    /// - Parameters:
    ///   - send: A function for receiving every log message
    ///   - flush: An optional function for when the destination should flush its cache, if any
    public init(send: @escaping Send, flush: Flush? = nil) {
        self.send = send
        self.flush = flush
    }
}

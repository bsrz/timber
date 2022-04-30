import os.log

extension OSLog {

    /// A preset OSLog using timber substystem and category
    static let timber = OSLog(
        subsystem: "io.srz.timber",
        category: "io.srz.timber"
    )
}

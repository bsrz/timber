import Foundation
import os.log

extension Destination {

    /// A preset timber destination for getting up and running quickly
    /// - Parameters:
    ///   - send: Formats and forwards the log messages to timber's OSLog preset
    static let timber: Destination = .init(
        send: { message, config, execution in
            let msg = MessageFormatter.format(
                message: message,
                config: config,
                execution: execution
            )

            os_log("%s", log: .timber, msg)
        }
    )
}

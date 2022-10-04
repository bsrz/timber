![](.img/header.png)

# Overview

Timber is a light weight abstraction for adding logs in your applications. It allows you to send logs to multiple places.

You use an instance of the Logger class throughout your code and you provide a configuration at instantiation time with one or more destinations.

1. Start by creating a destination
```swift
let simplePrint = Destination(
    send: { message, config, exec in
        // message: the message to log; contains a string, file, and line

        // config: the logger config; contains unique and session id

        // exec: either .continue or .halt; allowing you to enforce preconditions

        // you can use the predefined message formatter
        let msg = MessageFormatter.format(
            message: message,
            config: config,
            execution: exec
        )

        print(Date().description, msg)
    },
    flush:  {
        // use this when the app is backgrounded to save/upload logs as needed
    }
)
```

2. Create a configuration
```swift
let config = Configuration(
    destinations: [simplePrint],
    sessionId: {
        // use this to provide a session id to the logger; this can change on every app launch
        // this is a closure because you may not know the value when the config is instantiated
        return "session id"
    },
    uniqueId: {
        // use this to provide a unique id to the logger; this should remain the same on every app launch
        // this is a closure because you may not know the value when the config is instantiated
        return "unique id"
    }
)
```

3. Create the logger
```swift
import SwiftUI

struct App: SwiftUI.App {

    let logger = Logger(config: config)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(logger)
        }
    }
}

// or

@MainActor
class ViewModel: ObservableObject {

    private let logger: Logger

    init(logger: Logger) {
        self.logger = logger
    }

    func doSomething() {
        // logger.log(_:execution:)
        // use different preset categories, or create some new ones specific to your app
        logger.log(.audio(.error, "error"))
        logger.log(.default(.error, "error; halt execution"), execution: .halt)
        logger.log(.metrics(.info, "info"))
        logger.log(.network(.warning, "warning"))
        logger.log(.persistence(.debug, "debug; halt execution"), execution: .halt)
        logger.log(.ui(.verbose, "verbose"))
    }
}
```

# Presets

Timber ships with a default logger for production:

```swift
import SwiftUI

struct App: SwiftUI.App {

    let logger = Logger.timber // preset logger

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(logger)
        }
    }
}
```

And it ships with a default logger for testing:

```swift
@testable import MyCoolProject
import XCTest

final class ViewModelTests: XCTestCase {
    func testViewModel() throws {
        let sut = ViewModel(logger: .noop) // won't log anyting
    }
}
```

# Custom Destination

If you prefer to not use the logger that Timber ships with but want to have the same functionality, you can use this template and replace the values and names:

```swift
import Timber
import os.log

extension OSLog {
    static let custom = OSLog(
        subsystem: "<custom subsystem>",
        category: "<custom cateogry>"
    )
}

extension Destination {
    static let custom: Destination = .init(
        send: { message, config, execution in
            let msg = MessageFormatter.format(
                message: message,
                config: config,
                execution: execution
            )

            os_log("%s", log: .custom, msg)
        }
    )
}

extension Timber.Logger {
    public static let custom: Timber.Logger = .init(config: .init(destinations: [.custom]))
}
```

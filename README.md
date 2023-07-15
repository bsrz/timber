![](.img/header.png)

# Overview

Timber is a light weight abstraction for adding logs in your applications. It allows you to send logs to multiple destinations. It also supports redaction of sensitive information.

You use an instance of the Logger class throughout your code and you provide a configuration at instantiation time with one or more destinations.

1. Start by creating a destination
```swift
let simplePrint = Destination(
    send: { message, config, exec in
        // message: the message to log; contains a string, file, and line

        // config: the logger config; contains unique and session id and other attributes

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

You could decide to add a custom destination to save logs to files:

```swift
class FileLogger {

    private var messages: [String] = []
    private let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    func send(_ message: Message, _ config: Configuration, _ execution: Execution) {
        let msg = MessageFormatter.format(
            message: message,
            config: config,
            execution: execution
        )

        messages.append(msg)

        if messages.count >= 100 {
            try? save()
            messages = []
        }
    }

    func flush() {
        try? save()
        messages = []
    }

    private func save() throws {
        let content = messages
            .map { $0 + "\n" }
            .reduce(into: "") { result, element in
                result += element
            }
        let data = content.data(using: .utf8)

        try data?.write(to: url.appendingPathComponent(Date().description))
    }
}
```

and add it to your config:

```swift
let file = FileLogger()

let config = Configuration(
    destinations: [
        simplePrint,
        .init(
            send:  file.send(_:_:_:),
            flush: file.flush
        )
    ]
)
```

Now the logs will be sent to the console _and_ saved on disk and you didnt' have to change any of your code consuming the logger.

# Testing

Timber ships with a default logger for testing:

```swift
@testable import MyCoolProject
import XCTest

final class ViewModelTests: XCTestCase {
    func testViewModel() throws {
        let sut = ViewModel(logger: .noop) // won't log anyting
    }
}
```

If you want to be explicit about testing logger output (for example, for PII compliance), you can provide an inline test logger and destination and test its output. [See LoggerTests.swift](https://github.com/bsrz/timber/blob/main/Tests/TimberTests/LoggerTests.swift) for an example.

# License

Timber is released under the MIT license. [See LICENSE](https://github.com/bsrz/timber/blob/main/LICENSE) for details.

# Credit

This is a version of a micro library friends and I have been using for quite a while in private projects. Credit goes to [Ian Keen](https://github.com/IanKeen), [Mat Cartmill](https://github.com/matcartmill) and [Rebecca Duhard](https://github.com/rduhard) for contributing to this in one way or another over the years.

@testable import Timber
import XCTest

class ValueStringInterpolationTests: XCTestCase {

    func testValue_whenInitializedUsingStringLiteral_hasSwiftLikeTextRepresentation() {
        let result = "\(Value(stringLiteral: "foo"))"
        XCTAssertEqual(result, #"Value(segments: [Timber.Value.Segment(internal: "foo", external: "foo")])"#)
    }

    func testValue_whenInterpolatingStringValue_withPublicModifier_exposesValue() {
        let value: Value = "\(name, .public)"
        XCTAssertEqual(value.segments.count, 3)
        XCTAssertEqual(value.segments[0].external, "")
        XCTAssertEqual(value.segments[0].internal, "")
        XCTAssertEqual(value.segments[1].external, name)
        XCTAssertEqual(value.segments[1].internal, name)
        XCTAssertEqual(value.segments[2].external, "")
        XCTAssertEqual(value.segments[2].internal, "")
    }

    func testValue_whenInterpolatingStringValue_withPrivateModifier_redactsValue() {
        let value: Value = "\(name, .private)"
        XCTAssertEqual(value.segments.count, 3)
        XCTAssertEqual(value.segments[0].external, "")
        XCTAssertEqual(value.segments[0].internal, "")
        XCTAssertEqual(value.segments[1].external, "<REDACTED>")
        XCTAssertEqual(value.segments[1].internal, name)
        XCTAssertEqual(value.segments[2].external, "")
        XCTAssertEqual(value.segments[2].internal, "")
    }

    func testValue_whenInterpolatingNilValue_withPublicModifier_usesDefaultNilRepresentation() {
        let value: Value = "\(nil, .public)"
        XCTAssertEqual(value.segments.count, 3)
        XCTAssertEqual(value.segments[0].external, "")
        XCTAssertEqual(value.segments[0].internal, "")
        XCTAssertEqual(value.segments[1].external, "<nil>")
        XCTAssertEqual(value.segments[1].internal, "<nil>")
        XCTAssertEqual(value.segments[2].external, "")
        XCTAssertEqual(value.segments[2].internal, "")
    }

    func testValue_whenInterpolatingNilValue_withPrivateModifier_usesDefaultNilRepresentation() {
        let value: Value = "\(nil, .private)"
        XCTAssertEqual(value.segments.count, 3)
        XCTAssertEqual(value.segments[0].external, "")
        XCTAssertEqual(value.segments[0].internal, "")
        XCTAssertEqual(value.segments[1].external, "<REDACTED>")
        XCTAssertEqual(value.segments[1].internal, "<nil>")
        XCTAssertEqual(value.segments[2].external, "")
        XCTAssertEqual(value.segments[2].internal, "")
    }

    func testValue_whenInterpolatingMetatype_withPublicModifier_usesMetatypeStringRepresentation() {
        let value: Value = "\(String.self, .public)"
        XCTAssertEqual(value.segments.count, 3)
        XCTAssertEqual(value.segments[0].external, "")
        XCTAssertEqual(value.segments[0].internal, "")
        XCTAssertEqual(value.segments[1].external, "String")
        XCTAssertEqual(value.segments[1].internal, "String")
        XCTAssertEqual(value.segments[2].external, "")
        XCTAssertEqual(value.segments[2].internal, "")
    }

    func testValue_whenInterpolatingMetatype_withPrivateModifier_usesMetatypeStringRepresentation() {
        let value: Value = "\(String.self, .private)"
        XCTAssertEqual(value.segments.count, 3)
        XCTAssertEqual(value.segments[0].external, "")
        XCTAssertEqual(value.segments[0].internal, "")
        XCTAssertEqual(value.segments[1].external, "<REDACTED>")
        XCTAssertEqual(value.segments[1].internal, "String")
        XCTAssertEqual(value.segments[2].external, "")
        XCTAssertEqual(value.segments[2].internal, "")
    }

    func testValue_whenInterpolatingVerbatimString_withPublicModifier_exposesVerbatimString() {
        let value: Value = "\(verbatim: "foo", .public)"
        XCTAssertEqual(value.segments.count, 3)
        XCTAssertEqual(value.segments[0].external, "")
        XCTAssertEqual(value.segments[0].internal, "")
        XCTAssertEqual(value.segments[1].external, "foo")
        XCTAssertEqual(value.segments[1].internal, "foo")
        XCTAssertEqual(value.segments[2].external, "")
        XCTAssertEqual(value.segments[2].internal, "")
    }

    func testValue_whenInterpolatingVerbatimString_withPrivateModifier_redactsVerbatimString() {
        let value: Value = "\(verbatim: "foo", .private)"
        XCTAssertEqual(value.segments.count, 3)
        XCTAssertEqual(value.segments[0].external, "")
        XCTAssertEqual(value.segments[0].internal, "")
        XCTAssertEqual(value.segments[1].external, "<REDACTED>")
        XCTAssertEqual(value.segments[1].internal, "foo")
        XCTAssertEqual(value.segments[2].external, "")
        XCTAssertEqual(value.segments[2].internal, "")
    }

    func testValue_whenInterpolatingVerbatimString_withNoModifier_redactsVerbatimString() {
        let value: Value = "\(verbatim: "foo")"
        XCTAssertEqual(value.segments.count, 3)
        XCTAssertEqual(value.segments[0].external, "")
        XCTAssertEqual(value.segments[0].internal, "")
        XCTAssertEqual(value.segments[1].external, "<REDACTED>")
        XCTAssertEqual(value.segments[1].internal, "foo")
        XCTAssertEqual(value.segments[2].external, "")
        XCTAssertEqual(value.segments[2].internal, "")
    }
}

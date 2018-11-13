import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ibm_cloudant_testTests.allTests),
    ]
}
#endif
//
// NotAGif.
//

import XCTest

@testable import NotAGif

class FramesProviderTests: XCTestCase {
    
    func testMockedUrlsAreProperlyFormatted() {
        let resources = MockResourcesLocator(count: 1)
        let url = resources.url(forResource: "x-0", withExtension: .png)
        XCTAssertEqual(url?.absoluteString, "file:///mock/x-0.png")
        let nilUrl = resources.url(forResource: "x-1", withExtension: .png)
        XCTAssertNil(nilUrl)
    }
    
    func testAllPossibleUrlsAreGenerated() {
        let resources = MockResourcesLocator(count: 10)
        let framesProvider = FramesProvider(format: "%@-%d", fileExtension: .png, in: resources)
        let urls = framesProvider.urls(baseName: "x")
        XCTAssertEqual(urls.count, 10)
    }
}

private struct MockResourcesLocator: ResourcesLocator {
    
    let count: Int
    
    func url(forResource name: String, withExtension ext: ImageFileExtension) -> URL? {
        guard let id = Int(name.components(separatedBy: "-").last ?? "") else { return nil }
        guard id < count else { return nil }
        return URL(string: "file:///mock/\(name).\(ext)")
    }
}

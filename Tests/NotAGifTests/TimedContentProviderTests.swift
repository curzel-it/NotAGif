//
// NotAGif.
//

import XCTest

@testable import NotAGif

class TimedContentProviderTests: XCTestCase {
    
    func testLoopDuracyIsProperlyCalculated() {
        let frames = [Int](repeating: 0, count: 12)
        let animation = TimedContentProvider(frames: frames, fps: 12)
        XCTAssertEqual(animation.loopDuracy, 1)
    }
    
    func testZeroFpsLeadsToZeroLoopDuracyAndFrameTime() {
        let animation = TimedContentProvider(frames: [1, 2, 3], fps: 0)
        XCTAssertEqual(animation.loopDuracy, 0)
        XCTAssertEqual(animation.frameTime, 0)
    }
    
    func testZeroFramesLeadsToZeroLoopDuracy() {
        let animation = TimedContentProvider(frames: [], fps: 1)
        XCTAssertEqual(animation.loopDuracy, 0)
    }
    
    func testFramesUpdateWhenNeeded() {
        let frames = [Int](repeating: 0, count: 10)
        let animation = TimedContentProvider(frames: frames, fps: 10)
        XCTAssertEqual(animation.currentFrameIndex, 0)
        _ = animation.nextFrame(after: 0.05)
        XCTAssertEqual(animation.currentFrameIndex, 0)
        _ = animation.nextFrame(after: 0.05)
        XCTAssertEqual(animation.currentFrameIndex, 1)
        _ = animation.nextFrame(after: 0.05)
        XCTAssertEqual(animation.currentFrameIndex, 1)
        _ = animation.nextFrame(after: 0.05)
        XCTAssertEqual(animation.currentFrameIndex, 2)
        _ = animation.nextFrame(after: 0.75)
        XCTAssertEqual(animation.currentFrameIndex, 9)
        _ = animation.nextFrame(after: 0.08)
        XCTAssertEqual(animation.currentFrameIndex, 0)
    }
}

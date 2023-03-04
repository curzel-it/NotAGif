import Foundation

open class TimedContentProvider<Content> {    
    public let frames: [Content]
    public let frameTime: TimeInterval
    public let loopDuracy: TimeInterval
    
    var onFirstFrameOfLoopLoaded: ((Int) -> Void)?
    var onLoopCompleted: ((Int) -> Void)?
    var currentFrameIndex: Int = 0
    var completedLoops: Int = 0
    
    private var leftoverTime: TimeInterval = 0
    
    public init(
        frames: [Content],
        fps: TimeInterval,
        onFirstFrameOfLoopLoaded: ((Int) -> Void)? = nil,
        onLoopCompleted: ((Int) -> Void)? = nil
    ) {
        self.frames = frames
        self.frameTime = fps > 0 ? 1/fps : 0
        self.loopDuracy = TimeInterval(frames.count) * frameTime
        self.onFirstFrameOfLoopLoaded = onFirstFrameOfLoopLoaded
        self.onLoopCompleted = onLoopCompleted
    }
    
    public func currentFrame() -> Content? {
        guard currentFrameIndex < frames.count else { return nil }
        return frames[currentFrameIndex]
    }
    
    open func nextFrame(after time: TimeInterval) -> Content? {
        guard frameTime > 0 && frames.count > 0 else { return nil }
        
        handleFirstFrameOfFirstLoopIfNeeded()
        
        let timeSinceLastFrameChange = time + leftoverTime
        guard timeSinceLastFrameChange >= frameTime else {
            leftoverTime = timeSinceLastFrameChange
            return nil
        }
        
        let framesSkipped = Int(floor(timeSinceLastFrameChange / frameTime))
        let usedTime = TimeInterval(framesSkipped) * frameTime
        leftoverTime = timeSinceLastFrameChange - usedTime
        
        let nextIndex = (currentFrameIndex + framesSkipped) % frames.count
        if currentFrameIndex != nextIndex {
            checkLoopCompletion(nextIndex: nextIndex)
            return frames[nextIndex]
        }
        return nil
    }
    
    private func handleFirstFrameOfFirstLoopIfNeeded() {
        if completedLoops == 0 && currentFrameIndex == 0 && leftoverTime == 0 {
            onFirstFrameOfLoopLoaded?(0)
        }
    }
    
    private func checkLoopCompletion(nextIndex: Int) {
        if nextIndex < currentFrameIndex {
            completedLoops += 1
            onLoopCompleted?(completedLoops)
            onFirstFrameOfLoopLoaded?(completedLoops)
        }
        currentFrameIndex = nextIndex
    }
    
    public func clearHooks() {
        self.onFirstFrameOfLoopLoaded = nil
        self.onLoopCompleted = nil
    }
}

import SwiftUI

public struct AnimatedImage: View {
    let frames: [ImageFrame]
    let fps: TimeInterval
    
    public init(frames: [ImageFrame], fps: TimeInterval = 10) {
        self.frames = frames
        self.fps = fps
    }
    
    public var body: some View {
        AnimatedContent(frames: frames, fps: fps) {
            Image(frame: $0)
        }
    }
}

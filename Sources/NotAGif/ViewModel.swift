//
// NotAGif.
//

import SwiftUI

class ViewModel: ObservableObject {
    
    @Published var currentFrame: ImageFrame?
    
    private let animator: TimedContentProvider<ImageFrame>
    private let fps: TimeInterval
    private var lastUpdate: Date = Date()
    private var timer: Timer!
    
    init(frames: [ImageFrame], fps: TimeInterval) {
        self.animator = TimedContentProvider(frames: frames)
        self.fps = fps
        scheduleUpdates()
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    func resume() {
        timer?.invalidate()
        timer = nil
    }
    
    private func scheduleUpdates() {
        stop()
        timer = Timer(timeInterval: 1/fps, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            self.update()
        }
        RunLoop.current.add(timer, forMode: .common)
    }
    
    private func update() {
        let elapsedTime = -lastUpdate.timeIntervalSinceNow
        lastUpdate = Date()
        currentFrame = animator.nextFrame(after: elapsedTime)
    }
}

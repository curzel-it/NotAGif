//
// NotAGif.
//

import SwiftUI

public struct AnimatedContent<Content: View>: View {
    
    @StateObject private var viewModel: ViewModel
    
    let content: (ImageFrame) -> Content
    
    public init(
        frames: [ImageFrame],
        fps: TimeInterval = 10,
        @ViewBuilder content: @escaping (ImageFrame) -> Content
    ) {
        self._viewModel = StateObject(wrappedValue: ViewModel(frames: frames, fps: fps))
        self.content = content
    }
    
    public var body: some View {
        if let image = viewModel.currentFrame {
            content(image)
        }
    }
}

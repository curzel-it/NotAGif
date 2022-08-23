//
// NotAGif.
//

import SwiftUI
import NotAGif

struct ContentView: View {

    let climbFrames = FramesProvider(format: "%@-%d", fileExtension: .png, in: Bundle.main)
        .frames(baseName: "sloth_climb")
    
    var body: some View {
        HStack {
            AnimatedImage(frames: climbFrames, fps: 10)
            
            AnimatedContent(frames: climbFrames, fps: 10) { image in
                Image(frame: image)
                    .interpolation(.none)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .frame(width: 100, height: 100)
            
            AnimatedContent(frames: climbFrames, fps: 10) { image in
                Image(frame: image)
                    .interpolation(.none)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .frame(width: 150, height: 150)
        }
        .padding(50)
    }
}

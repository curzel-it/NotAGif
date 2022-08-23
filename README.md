# NotAGif

Package to render Gif-like animated images.

If you have animation frames stored as images, you can use this package to display them with fps control.

Works with both iOS and macOS and supports custom filename formattings.

![Demo](demo.gif)

## Usage 

### Basics

Say you have a set of images named that compose an animation:
* sloth_climb-0.png
* sloth_climb-1.png
* sloth_climb-2.png
* sloth_climb-3.png
* ...

``` swift
import SwiftUI
import NotAGif

struct ContentView: View {

    let animationFrames = FramesProvider(format: "%@-%d", fileExtension: .png, in: Bundle.main)
        .frames(baseName: "sloth_climb")

    var body: some View {
        AnimatedImage(frames: animationFrames, fps: 10)
    }
} 
```

### Using custom views 

Let's say the images you want to render are in pixel art style, this requires disabling image interpolation:

``` swift
import SwiftUI
import NotAGif

struct ContentView: View {

    let animationFrames = FramesProvider(format: "%@-%d", fileExtension: .png, in: Bundle.main)
        .frames(baseName: "sloth_climb")

    var body: some View {
        AnimatedContent(frames: animationFrames, fps: 10) { image in
            Image(image, scale: 1, label: Text(""))
                .interpolation(.none)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }    
    }
} 
```

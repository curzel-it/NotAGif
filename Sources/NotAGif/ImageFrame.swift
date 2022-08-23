//
// NotAGif.
//

import SwiftUI

#if os(macOS)
import AppKit
public typealias ImageFrame = NSImage
#else
import UIKit
public typealias ImageFrame = UIImage
#endif

extension Image {
    
    public init(frame: ImageFrame) {
#if os(macOS)
        self.init(nsImage: frame)
#else
        self.init(uiImage: frame)
#endif
    }
}

import SwiftUI

#if os(macOS)
import AppKit

public typealias ImageFrame = NSImage

public extension Image {
    init(frame: ImageFrame) {
        self.init(nsImage: frame)
    }
}

public extension NSImage {
    var cgImage: CGImage? {
        var rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        return cgImage(forProposedRect: &rect, context: nil, hints: nil)
    }
}

#else

import UIKit

public typealias ImageFrame = UIImage

public extension UIImage {
    convenience init?(contentsOf url: URL) {
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }
}

public extension Image {
    init(frame: ImageFrame) {
        self.init(uiImage: frame)
    }
}
#endif

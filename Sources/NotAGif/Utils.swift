//
// NotAGif.
//

#if os(macOS)
import AppKit

extension NSImage {
    
    public var cgImage: CGImage? {
        var rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        return cgImage(forProposedRect: &rect, context: nil, hints: nil)
    }
}
#endif

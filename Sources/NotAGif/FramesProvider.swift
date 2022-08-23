//
// NotAGif.
//

import SwiftUI

public struct FramesProvider<T: ResourcesLocator> {
    
    let format: String
    let resources: T
    let fileExtension: ImageFileExtension
    
    public init(format: String, fileExtension: ImageFileExtension, in resources: T) {
        self.format = format
        self.fileExtension = fileExtension
        self.resources = resources
    }
    
    public func frames(baseName: String) -> [ImageFrame] {
        urls(baseName: baseName).compactMap {
#if os(macOS)
            return NSImage(contentsOf: $0)
#else
            guard let data = try? Data(contentsOf: $0) else { return nil }
            return UIImage(data: data)
#endif
        }
    }
    
    func urls(baseName: String) -> [URL] {
        var urls: [URL] = []
        var index = 0
        
        while true {
            let name = String(format: format, baseName, index)
            
            if let url = resources.url(forResource: name, withExtension: fileExtension) {
                urls.append(url)
            } else {
                if index > 0 { break }
            }
            index += 1
        }
        return urls
    }
}

public protocol ResourcesLocator {
    func url(forResource: String, withExtension: ImageFileExtension) -> URL?
}

extension Bundle: ResourcesLocator {
    
    public func url(forResource name: String, withExtension ext: ImageFileExtension) -> URL? {
        url(forResource: name, withExtension: ext.rawValue)
    }
}

public enum ImageFileExtension: String {
    case png
    case jpg
    case jpeg
}

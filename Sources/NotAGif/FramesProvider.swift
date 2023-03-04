import SwiftUI

open class FramesProvider<T: ResourcesLocator> {
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
            ImageFrame(contentsOf: $0)
        }
    }
    
    func urls(baseName: String) -> [URL] {
        var urls: [URL] = []
        var index = 0
        
        while true {
            if let url = url(baseName: baseName, index: index) {
                urls.append(url)
            } else {
                if index > 0 { break }
            }
            index += 1
        }
        return urls
    }
    
    open func url(baseName: String, index: Int) -> URL? {
        let name = formatted(baseName: baseName, index: index)
        return resources.url(forResource: name, withExtension: fileExtension)
    }
    
    func formatted(baseName: String, index: Int) -> String {
        String(format: format, baseName, index)
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

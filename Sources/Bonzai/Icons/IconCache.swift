import Cocoa
import Foundation

enum IconCacheError: Error {
  case unableToObtainTiffRepresentation
  case unableToCreateImageRepresentation
  case unableToCreateDataFromImageRepresentation
}

actor IconCache {
  private var cache = [String: NSImage]()

  public static var shared = IconCache()

  private init() {}

  public func image(for icon: Icon, size: CGSize) -> NSImage? {
    let identifier: String = "\(icon.bundleIdentifier)_\(size.suffix).tiff"
      .replacingOccurrences(of: "/", with: "_")
      .replacingOccurrences(of: " ", with: "-")

    // Load from in-memory cache
    if let inMemoryImage = cache[identifier] {
      return inMemoryImage
    }

    // Load from disk
    var image: NSImage
    if icon.path.hasSuffix("icns") {
      image = NSImage(byReferencing: URL(filePath: icon.path))
    } else {
      image = NSWorkspace.shared.icon(forFile: icon.path)
    }

    image.size = size

    cache[identifier] = image

    return image
  }

  // MARK: Private methods

  private static var rootDirectory: URL {
    try! FileManager.default.url(for: .cachesDirectory,
                                 in: .userDomainMask,
                                 appropriateFor: nil,
                                 create: true)
    .appendingPathComponent(Bundle.main.bundleIdentifier!)
  }

  static func domain(_ name: String) throws -> URL {
    let url = Self
      .rootDirectory
      .appendingPathComponent(name)

    if !FileManager.default.fileExists(atPath: url.path) {
      try FileManager.default.createDirectory(
        at: url,
        withIntermediateDirectories: true,
        attributes: nil)
    }

    return url
  }
}

private extension CGSize {
  var suffix: String { "\(Int(width))x\(Int(height))" }
}

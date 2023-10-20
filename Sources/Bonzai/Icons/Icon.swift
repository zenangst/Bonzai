public struct Icon: Identifiable, Codable, Hashable, Equatable, Sendable {
  public var id: String { path }
  public let bundleIdentifier: String
  public let path: String

  public init(bundleIdentifier: String, path: String) {
    self.bundleIdentifier = bundleIdentifier
    self.path = path
  }
}

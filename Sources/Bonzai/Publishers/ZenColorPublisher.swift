import SwiftUI

public final class ZenColorPublisher: ObservableObject, @unchecked Sendable {
  @Published public private(set) var color: ZenColor
  public static let shared: ZenColorPublisher = .init()

  public init(color: ZenColor = .accentColor) {
    self.color = color
  }

  @MainActor
  public func publish(_ color: ZenColor) {
    self.color = color
  }
}

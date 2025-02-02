import SwiftUI

@MainActor
public final class ColorPublisher: ObservableObject, @unchecked Sendable {
  @Published public private(set) var color: Color
  public static let shared: ColorPublisher = .init()

  public init(color: Color = .accentColor) {
    self.color = color
  }

  public func publish(_ color: Color) {
    self.color = color
  }
}

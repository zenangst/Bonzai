import SwiftUI

public struct FillBackgroundView: View {
  @Environment(\.isFocused) private var isFocused
  @EnvironmentObject private var publisher: ZenColorPublisher
  @Binding private var isSelected: Bool
  private let globalPublisher: Bool

  public init(isSelected: Binding<Bool>, globalPublisher: Bool = true) {
    _isSelected = isSelected
    self.globalPublisher = globalPublisher
  }

  public var body: some View {
    let color = globalPublisher ? ZenColorPublisher.shared.color : publisher.color
    Color(nsColor: color.nsColor)
      .opacity(isFocused
               ? 0.5
               : isSelected
               ? 0.2
               : 0)
      .cornerRadius(4.0)
      .drawingGroup()
  }
}

import SwiftUI

public struct FillBackgroundView: View {
  @Environment(\.isFocused) private var isFocused
  @EnvironmentObject private var publisher: ColorPublisher
  @Binding private var isSelected: Bool
  private let globalPublisher: Bool

  public init(isSelected: Binding<Bool>, globalPublisher: Bool = true) {
    _isSelected = isSelected
    self.globalPublisher = globalPublisher
  }

  public var body: some View {
    let color = globalPublisher ? ColorPublisher.shared.color : publisher.color
    color
      .opacity(isFocused
               ? 0.5
               : isSelected
               ? 0.2
               : 0)
      .cornerRadius(4.0)
      .contentShape(Rectangle())
  }
}

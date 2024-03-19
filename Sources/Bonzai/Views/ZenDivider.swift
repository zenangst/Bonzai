import SwiftUI

public struct ZenDivider: View {
  @Environment(\.colorScheme) var colorScheme
  private let axis: Axis

  public init(_ axis: Axis = .horizontal) {
    self.axis = axis
  }

  public var body: some View {
    switch axis {
    case .horizontal:
      VStack(spacing: 0, content: { content(firstColor: darkerColor(), secondColor: lighterColor()) })
        .drawingGroup()
    case .vertical:
      HStack(spacing: 0, content: { content(firstColor: lighterColor(),
                                            secondColor: darkerColor()) })
        .drawingGroup()
    }
  }

  private func darkerColor() -> Color {
    colorScheme == .dark
    ? .black
    : Color(nsColor: .systemGray)
  }

  private func lighterColor() -> Color {
    colorScheme == .dark
    ? .gray
    : Color(nsColor: .systemGray.withSystemEffect(.disabled))
  }

  private func opacity() -> CGFloat {
    colorScheme == .dark
    ? 0.5
    : 1.0
  }

  @ViewBuilder
  private func content(firstColor: Color, secondColor: Color) -> some View {
    Divider()
      .foregroundColor(firstColor)
      .opacity(opacity())
    Divider()
      .foregroundColor(secondColor)
      .opacity(opacity())
  }
}

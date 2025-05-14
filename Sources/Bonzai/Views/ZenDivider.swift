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
      VStack(spacing: 0) {
        ColoredDivider(color: darkerColor())
        ColoredDivider(color: lighterColor())
      }
    case .vertical:
      HStack(spacing: 0, content: {
        ColoredDivider(color: lighterColor())
        ColoredDivider(color: darkerColor())
      })
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
}

private struct ColoredDivider: View {
  @Environment(\.colorScheme) var colorScheme
  let color: Color

  var body: some View {
    Divider()
      .foregroundColor(color)
      .opacity(opacity())
  }

  private func opacity() -> CGFloat {
    colorScheme == .dark
    ? 0.5
    : 1.0
  }
}


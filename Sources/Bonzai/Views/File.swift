import SwiftUI

public struct ZenDivider: View {
  private let axis: Axis

  public init(_ axis: Axis = .horizontal) {
    self.axis = axis
  }

  public var body: some View {
    switch axis {
    case .horizontal:
      VStack(spacing: 0, content: { content(firstColor: .black, secondColor: .gray) })
        .drawingGroup()
    case .vertical:
      HStack(spacing: 0, content: { content(firstColor: .gray, secondColor: .black) })
        .drawingGroup()
    }
  }

  @ViewBuilder
  private func content(firstColor: Color, secondColor: Color) -> some View {
    Divider()
      .foregroundColor(firstColor)
      .opacity(0.5)
    Divider()
      .foregroundColor(secondColor)
      .opacity(0.5)
  }

}

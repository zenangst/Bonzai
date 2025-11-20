import AppKit
import SwiftUI

struct ZenStyleBackgroundView: View {
  @Environment(\.colorScheme) var colorScheme
  let cornerRadius: CGFloat
  let calm: Bool
  let unfocusedOpacity: CGFloat
  @Binding var isHovered: Bool
  let color: Color

  var body: some View {
    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
      .fill(LinearGradient(
        stops: Gradient.Stop.zen(colorScheme, isHovered: isHovered, color: color),
        startPoint: .top, endPoint: .bottom))
      .glassShims(color)
      .opacity(fillOpacity())
  }

  private func fillOpacity() -> CGFloat {
    if calm && isHovered == false {
      return 0
    }

    return isHovered ? 1.0
                     : colorScheme == .light ? 0.7 : 0.4
  }
}

extension View {
  func glassShims(_ color: Color) -> some View {
    if #available(macOS 26.0, *) {
      return self
        .glassEffect(.clear.tint(color))
    } else {
      return self
    }
  }
}

private struct BackgroundView: View {
  @Environment(\.colorScheme) var colorScheme
  let cornerRadius: CGFloat
  let calm: Bool
  let unfocusedOpacity: CGFloat
  @Binding var isHovered: Bool

  var body: some View {
    LinearGradient(stops: [
      .init(color: strokeColor().blended(withFraction: 0.75, of: .systemGray), location: 0),
      .init(color: strokeColor().blended(withFraction: 0.4, of: .systemGray), location: 0.5)
    ], startPoint: .top, endPoint: .bottom)
    .mask {
      RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        .stroke(strokeColor(), lineWidth: 1)
        .padding(1)
        .opacity(strokeOpacity())
    }
  }

  private func strokeOpacity() -> CGFloat {
    if calm && isHovered == false {
      return unfocusedOpacity
    }

    return isHovered ? 1.0
    : colorScheme == .light ? 0.7 : unfocusedOpacity
  }

  private func strokeColor() -> Color {
    if calm && isHovered == false {
      return Color(colorScheme == .dark ? .black : .textColor)
    }

    if colorScheme == .dark {
      return Color.black.opacity(unfocusedOpacity)
    } else {
      return Color(nsColor: .shadowColor).opacity(unfocusedOpacity)
    }
  }
}

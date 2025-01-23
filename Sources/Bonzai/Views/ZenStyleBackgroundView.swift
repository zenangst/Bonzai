import SwiftUI

struct ZenStyleBackgroundView: View {
  @Environment(\.colorScheme) var colorScheme
  let cornerRadius: CGFloat
  let calm: Bool
  @Binding var isHovered: Bool
  let nsColor: NSColor

  var body: some View {
    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
      .fill(LinearGradient(
        stops: Gradient.Stop.zen(colorScheme,
                                 isHovered: isHovered,
                                 nsColor: nsColor),
        startPoint: .top, endPoint: .bottom))
      .opacity(fillOpacity())
      .background(
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
          .stroke(strokeColor(), lineWidth: 1)
          .offset(y: 0.25)
          .opacity(strokeOpacity())
      )
  }

  private func fillOpacity() -> CGFloat {
    if calm && isHovered == false {
      return 0
    }

    return isHovered ? 1.0
                     : colorScheme == .light ? 0.7 : 0.3
  }

  private func strokeOpacity() -> CGFloat {
    if calm && isHovered == false {
      return 0.4
    }

    return isHovered ? 1.0
    : colorScheme == .light ? 0.7 : 0.3
  }

  private func strokeColor() -> Color {
    if calm && isHovered == false {
      return Color(colorScheme == .dark ? .textColor : .textColor)
        .opacity(0.1)
    }

    if colorScheme == .dark {
      return Color(nsColor: .shadowColor).opacity(0.2)
    } else {
      return Color(nsColor: .shadowColor).opacity(0.2)
    }
  }
}

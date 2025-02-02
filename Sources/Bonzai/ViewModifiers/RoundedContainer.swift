import SwiftUI

struct RoundedContainer: ViewModifier {
  @Environment(\.colorScheme) var colorScheme
  private let cornerRadius: CGFloat
  private let padding: EdgeInsets

  init(cornerRadius: CGFloat, padding: CGFloat) {
    self.cornerRadius = cornerRadius
    self.padding = EdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
  }

  init(cornerRadius: CGFloat, padding: EdgeInsets) {
    self.cornerRadius = cornerRadius
    self.padding = padding
  }

  func body(content: Content) -> some View {
    content
      .padding(padding)
      .background(
          LinearGradient(stops: [
            .init(color: background(fraction: 0.015, of: .white), location: 0),
            .init(color: background(fraction: 0.015, of: .black), location: 1)
          ], startPoint: .top, endPoint: .bottom)
      )
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
      .overlay(
        RoundedRectangle(cornerRadius: cornerRadius - 1)
          .stroke(Color(nsColor: .controlColor).opacity(0.2), lineWidth: 2)
          .padding(1)
          .allowsHitTesting(false)
      )
      .overlay(
        RoundedRectangle(cornerRadius: cornerRadius - 1)
          .stroke(borderColor(), lineWidth: 1)
          .padding(1.5)
          .allowsHitTesting(false)
      )
      .compositingGroup()
      .shadow(color: shadowColor(), radius: 2, y: 2)
      .padding(.horizontal, 2)
  }

  private func borderColor() -> Color {
    colorScheme == .dark
    ? Color(nsColor: .controlColor).opacity(0.4)
    : Color(nsColor: .systemGray).opacity(0.2)
  }

  private func background(fraction: CGFloat = 0.0, of color: NSColor = .clear) -> Color {
    colorScheme == .dark
    ? Color(nsColor: .underPageBackgroundColor.blended(withFraction: fraction, of: color)!)
    : Color(nsColor: .alternateSelectedControlTextColor.blended(withFraction: fraction, of: color)!)
  }

  private func shadowColor() -> Color {
    colorScheme == .dark
      ? Color(.sRGBLinear, white: 0, opacity: 0.3)
      : Color(.sRGBLinear, white: 0, opacity: 0.1)
  }
}

public extension View {
  func roundedStyle(_ cornerRadius: CGFloat = 8, padding: CGFloat = 8) -> some View {
    self
      .modifier(RoundedContainer(cornerRadius: cornerRadius, padding: padding))
  }

  func roundedStyle(_ cornerRadius: CGFloat = 8, padding: EdgeInsets) -> some View {
    self
      .modifier(RoundedContainer(cornerRadius: cornerRadius, padding: padding))
  }
}

#Preview {
    VStack {
       Text("Light Mode")
            .roundedStyle()
            .environment(\.colorScheme, .light)

        Text("Dark Mode")
            .roundedStyle()
            .environment(\.colorScheme, .dark)
    }
}

import SwiftUI

struct RoundedSubContainer: ViewModifier {
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
        LinearGradient(stops: [
          .init(color: borderColor().blended(withFraction: 0.5, of: .black), location: 0),
          .init(color: borderColor().blended(withFraction: 0.75, of: .black), location: 0.5)
        ], startPoint: .top, endPoint: .bottom)
        .mask {
          RoundedRectangle(cornerRadius: cornerRadius - 1)
            .stroke(.black, lineWidth: 1.5)
            .padding(1.5)
        }
          .allowsHitTesting(false)
      )
      .overlay(
        RoundedRectangle(cornerRadius: cornerRadius - 1)
          .stroke(borderColor().opacity(0.2), lineWidth: 1)
          .allowsHitTesting(false)
          .padding(1)
      )
      .compositingGroup()
      .shadow(color: shadowColor(), radius: 1, y: 2)
  }

  private func borderColor() -> Color {
    colorScheme == .dark
    ? Color.systemGray
    : Color(nsColor: .systemGray).opacity(0.2)
  }

  private func background(fraction: CGFloat = 0.0, of color: Color = .clear) -> Color {
    colorScheme == .dark
    ? Color(nsColor: .underPageBackgroundColor).blended(withFraction: fraction, of: color)
    : Color(nsColor: .alternateSelectedControlTextColor).blended(withFraction: fraction, of: color)
  }

  private func shadowColor() -> Color {
    colorScheme == .dark
    ? Color(.sRGBLinear, white: 0, opacity: 0.1)
    : Color(.sRGBLinear, white: 0, opacity: 0.1)
  }
}

public extension View {
  func roundedSubStyle(_ cornerRadius: CGFloat = 6, padding: CGFloat = 6) -> some View {
    self
      .modifier(RoundedSubContainer(cornerRadius: cornerRadius, padding: padding))
  }

  func roundedSubStyle(_ cornerRadius: CGFloat = 6, padding: EdgeInsets) -> some View {
    self
      .modifier(RoundedSubContainer(cornerRadius: cornerRadius, padding: padding))
  }
}

#Preview {
  VStack {
    Text("Light Mode")
      .roundedSubStyle()
      .environment(\.colorScheme, .light)

    Text("Dark Mode")
      .roundedSubStyle()
      .environment(\.colorScheme, .dark)
  }
}

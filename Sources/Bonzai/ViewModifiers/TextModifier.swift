import SwiftUI

struct TextModifier: ViewModifier {
  @Environment(\.textColor) private var textColor
  @Environment(\.textFont) private var textFont

  private let overrideTextColor: Color?
  private let overrideTextFont: Font?

  init(textColor: Color? = nil,
       font: Font? = nil) {
    self.overrideTextColor = textColor
    self.overrideTextFont = font
  }

  func body(content: Content) -> some View {
    content
      .font(overrideTextFont ?? textFont)
      .foregroundStyle(overrideTextColor ?? textColor)
  }
}

public extension View {
  func textStyle() -> some View {
    self.modifier(TextModifier())
  }

  func textStyle(_ manipulate: (_ text: inout TextDefaults) -> Void) -> some View {
    var config = TextDefaults()
    manipulate(&config)
    return self.modifier(TextModifier(
      textColor: config.color,
      font: config.font))
  }
}

#Preview {
  VStack {
    Text("Styled Text")
      .textStyle {
        $0.color = Color(.systemYellow)
        $0.font = .title
      }
    Text("Standard Text")
  }
  .textStyle()
  .padding()
}

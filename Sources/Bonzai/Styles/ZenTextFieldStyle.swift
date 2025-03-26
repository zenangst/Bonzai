import SwiftUI

struct ZenTextFieldStyle: TextFieldStyle {
  @Environment(\.controlActiveState) var controlActiveState
  @FocusState var isFocused: Bool
  @State var isHovered: Bool = false

  @Environment(\.textFieldBackgroundColor) var backgroundColor
  @Environment(\.textFieldCalm) var calm
  @Environment(\.textFieldCornerRadius) var cornerRadius
  @Environment(\.textFieldDecorationColor) var decorationColor
  @Environment(\.textFieldFocusEffect) var focusEffect
  @Environment(\.textFieldFont) var font
  @Environment(\.textFieldForegroundColor) var foregroundColor
  @Environment(\.textFieldGlow) var glow
  @Environment(\.textFieldGrayscaleEffect) var grayscaleEffect
  @Environment(\.textFieldHoverEffect) var hoverEffect
  @Environment(\.textFieldPadding) var padding
  @Environment(\.textFieldStyle) var style
  @Environment(\.textFieldUnfocusedOpacity) var unfocusedOpacity

  func _body(configuration: TextField<_Label>) -> some View {
    applyTextfieldStyle(configuration)
  }

  @ViewBuilder
  private func applyTextfieldStyle(_ configuration: TextField<_Label>) -> some View {
    switch style {
    case .automatic:
      applyStyle(configuration, padding: padding.edgeInsets)
        .textFieldStyle(.automatic)
    case .plain:
      applyStyle(configuration, padding: padding.edgeInsets)
        .textFieldStyle(.plain)
    case .roundedBorder:
      applyStyle(configuration)
        .textFieldStyle(.roundedBorder)
    case .squareBorder:
      applyStyle(configuration)
        .textFieldStyle(.squareBorder)
    }
  }

  @ViewBuilder
  private func applyStyle(_ content: TextField<ZenTextFieldStyle._Label>, padding: EdgeInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)) -> some View {
    content
      .padding(padding)
      .background(backgroundColor)
      .font(font)
      .background(
        RoundedRectangle(cornerRadius: 7)
          .stroke(Color(isFocused ? decorationColor.nsForegroundColor : .windowFrameTextColor), lineWidth: 2)
          .padding(-2)
          .opacity(isFocused ? 0.5 : unfocusedOpacity)
      )
      .background(
        RoundedRectangle(cornerRadius: 6)
          .strokeBorder(decorationColor.opacity(0.5), lineWidth: 2)
          .padding(-1)
          .opacity(isFocused ? 0.5 : unfocusedOpacity)
      )
      .overlay(
        RoundedRectangle(cornerRadius: 4)
          .stroke(Color(isFocused ? decorationColor.nsForegroundColor : .windowFrameTextColor), lineWidth: 2)
          .animation(.easeInOut(duration: 0.25), value: isFocused)
          .compositingGroup()
          .shadow(color: isFocused ? decorationColor : .clear, radius: 2)
          .padding(-2)
          .opacity(
            glow ? (isFocused ? 0.75 : isHovered ? 0.25 : 0) : 0)
      )
      .compositingGroup()
      .grayscale(grayscale())
      .animation(.easeInOut(duration: 0.25), value: isHovered)
      .animation(.easeInOut(duration: 0.25), value: isFocused)
      .compositingGroup()
      .onHover(perform: { newValue in
        isHovered = newValue
      })
      .focused($isFocused)
  }

  private func grayscale() -> CGFloat {
    isFocused
    ? controlActiveState == .key ? 0 : 0.2
    : isHovered ? 0 : 0.2
  }
}

struct ZenTextFieldStyle_Preview: PreviewProvider {
  static var previews: some View {
    HStack {
      VStack {
        TextField("Regular TextField", text: .constant(""))

        TextField("Large TextField", text: .constant(""))

        TextField("Zen TextField", text: .constant(""))

        TextField("Zen TextField colored", text: .constant(""))
      }
      .environment(\.colorScheme, .light)

      VStack {
        TextField("Regular TextField", text: .constant(""))

        TextField("Large TextField", text: .constant(""))
          .environment(\.textFieldFont, .largeTitle)

        TextField("Zen TextField", text: .constant(""))
          .textFieldStyle()

        TextField("Zen TextField colored", text: .constant(""))
          .environment(\.textFieldDecorationColor, .systemPurple)
      }
      .environment(\.colorScheme, .dark)
    }
    .padding()
  }
}

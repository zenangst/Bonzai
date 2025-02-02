import SwiftUI

struct ZenTextFieldStyle: TextFieldStyle {
  @Environment(\.controlActiveState) var controlActiveState
  @FocusState var isFocused: Bool
  @State var isHovered: Bool = false
  private let config: TextFieldDefaults

  init(_ defaults: TextFieldDefaults) {
    self.config = defaults
  }

  func _body(configuration: TextField<_Label>) -> some View {
    HStack {
      applyTextfieldStyle(configuration)
        .background(config.backgroundColor)
        .font(config.font)
        .background(
          RoundedRectangle(cornerRadius: 7)
            .stroke(Color(isFocused ? config.decorationColor.nsForegroundColor : .windowFrameTextColor), lineWidth: 2)
            .padding(-2)
            .opacity(isFocused ? 0.5 : config.unfocusedOpacity)
        )
        .background(
          RoundedRectangle(cornerRadius: 6)
            .strokeBorder(config.decorationColor.opacity(0.5), lineWidth: 2)
            .padding(-1)
            .opacity(isFocused ? 0.5 : config.unfocusedOpacity)
        )
        .overlay(
          RoundedRectangle(cornerRadius: 4)
            .stroke(Color(isFocused ? config.decorationColor.nsForegroundColor : .windowFrameTextColor), lineWidth: 2)
            .animation(.easeInOut(duration: 0.25), value: isFocused)
            .compositingGroup()
            .shadow(color: isFocused ? config.decorationColor : .clear, radius: 2)
            .padding(-2)
            .opacity(
              config.glow ? (isFocused ? 0.75
                             : isHovered
                             ? 0.25 : 0) : 0)
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
  }

  @ViewBuilder
  private func applyTextfieldStyle(_ configuration: TextField<_Label>) -> some View {
    switch config.style {
    case .automatic:
      configuration
        .textFieldStyle(.automatic)
    case .plain:
      configuration
        .textFieldStyle(.plain)
        .padding(config.padding.edgeInsets)
    case .roundedBorder:
      configuration
        .textFieldStyle(.roundedBorder)
    case .squareBorder:
      configuration
        .textFieldStyle(.squareBorder)
    }
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
          .textFieldStyle {
            $0.font = .largeTitle
          }

        TextField("Zen TextField", text: .constant(""))
          .textFieldStyle()

        TextField("Zen TextField colored", text: .constant(""))
          .textFieldStyle {
            $0.decorationColor = .systemPurple
          }
      }
      .environment(\.colorScheme, .dark)
    }
    .padding()
  }
}

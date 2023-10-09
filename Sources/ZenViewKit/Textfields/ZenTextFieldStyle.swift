import SwiftUI

struct ZenTextFieldStyle: TextFieldStyle {
  @FocusState var isFocused: Bool
  @State var isHovered: Bool = false
  private let color: ZenColor
  private let font: Font
  private let unfocusedOpacity: CGFloat

  init(_ font: Font = .body, unfocusedOpacity: CGFloat = 0.1, color: ZenColor = .accentColor) {
    self.color = color
    self.unfocusedOpacity = unfocusedOpacity
    self.font = font
  }

  func _body(configuration: TextField<_Label>) -> some View {
    HStack {
      configuration
        .textFieldStyle(.plain)
        .modifier(ZenTextViewModifier(font))
        .background(
          RoundedRectangle(cornerRadius: 4 + 1.5)
            .strokeBorder(Color(nsColor: color.nsColor), lineWidth: 1.5)
            .padding(-1.5)
            .opacity(isFocused ? 1 : isHovered ? 0.5 : unfocusedOpacity)
            .background()
            .clipShape(
              RoundedRectangle(cornerRadius: 4)
            )
            .background(
              RoundedRectangle(cornerRadius: 4 + 2.5)
                .strokeBorder(Color(nsColor: color.nsColor).opacity(0.5), lineWidth: 1.5)
                .padding(-2.5)
                .opacity(isFocused ? 1 : isHovered ? 0.5 : unfocusedOpacity)
            )
            .compositingGroup()
            .grayscale(isFocused ? 0 : 0.5)
            .animation(.easeInOut(duration: 0.25), value: isHovered)
            .animation(.easeInOut(duration: 0.25), value: isFocused)
        )
        .padding(2.5)
        .compositingGroup()
        .onHover(perform: { newValue in
          isHovered = newValue
        })
        .focused($isFocused)
    }
  }
}

struct ZenTextFieldStyle_Preview: PreviewProvider {
  static var previews: some View {
    HStack {
      VStack {
        TextField("Regular TextField", text: .constant(""))

        TextField("Zen TextField", text: .constant(""))
          .textFieldStyle(.regular)

        TextField("Zen TextField colored", text: .constant(""))
          .textFieldStyle(.zen(.title, 0.1, .systemPurple))
      }
      .environment(\.colorScheme, .light)

      VStack {
        TextField("Regular TextField", text: .constant(""))

        TextField("Zen TextField", text: .constant(""))
          .textFieldStyle(.regular)

        TextField("Zen TextField colored", text: .constant(""))
          .textFieldStyle(.zen(.title, 0.1, .systemPurple))
      }
      .environment(\.colorScheme, .dark)
    }
    .padding()
  }
}

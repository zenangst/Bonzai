import SwiftUI

struct ZenButtonStyle: ButtonStyle {
  @Environment(\.buttonBackgroundColor) var backgroundColor
  @Environment(\.buttonCalm) var calm
  @Environment(\.buttonCornerRadius) var cornerRadius
  @Environment(\.buttonFocusEffect) var focusEffect
  @Environment(\.buttonFont) var font
  @Environment(\.buttonForegroundColor) var envForegroundColor
  @Environment(\.buttonGlow) var glow
  @Environment(\.buttonGrayscaleEffect) var grayscaleEffect
  @Environment(\.buttonHoverEffect) var hoverEffect
  @Environment(\.buttonPadding) var padding
  @Environment(\.buttonUnfocusedOpacity) var unfocusedOpacity

  @State private var isHovered: Bool
  @Environment(\.isFocused) private var isFocused
  @Environment(\.colorScheme) private var colorScheme
  @Environment(\.controlActiveState) private var controlActiveState

  init(hoverEffect: Bool?) {
    if hoverEffect == false {
      _isHovered = .init(initialValue: true)
    } else {
      _isHovered = .init(initialValue: false)
    }
  }

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(font)
      .frame(minHeight: 15)
      .padding(padding.edgeInsets)
      .foregroundColor(foregroundColor())
      .background(
        ZenStyleBackgroundView(
          cornerRadius: cornerRadius,
          calm: calm,
          unfocusedOpacity: unfocusedOpacity,
          isHovered: $isHovered,
          color: backgroundColor
        )
        .opacity(backgroundColor == .clear ? 0 : 1)
      )
      .overlay {
        Group {
          RoundedRectangle(cornerRadius: cornerRadius + 1.5, style: .continuous)
            .strokeBorder(envForegroundColor, lineWidth: 1.5)
          RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .strokeBorder(envForegroundColor.opacity(0.5), lineWidth: 1.5)
            .padding(1.5)
        }
        .opacity(focusOverlayOpacity())
        .animation(.bouncy, value: isFocused)
      }
      .background(
        RoundedRectangle(cornerRadius: cornerRadius)
          .fill(envForegroundColor)
          .blur(radius: 2)
          .scaleEffect(0.9)
          .opacity(focusBackgroundOpacity())
          .animation(.bouncy, value: isFocused)
      )
      .grayscale(grayscale())
      .compositingGroup()
      .shadow(color: Color.black.opacity(
        isHovered 
        ? colorScheme == .dark ? 0.5 : 0.2
        : 0
      ),
              radius: configuration.isPressed 
              ? 0
              : isHovered
              ? colorScheme == .light ? 0.25 : 1
                                             : 1.25,
              y: configuration.isPressed ? 0 : isHovered ? 2 : 3)
      .opacity(opacity())
      .offset(y: configuration.isPressed ? 0.5 : 0.0)
      .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
      .animation(.easeOut(duration: 0.1), value: isHovered)
      .onAppear {
        if hoverEffect == false {
          isHovered = true
        }
      }
      .onHover(perform: { value in
        guard hoverEffect else {
          isHovered = true
          return
        }
        guard self.isHovered != value else { return }
        self.isHovered = value
      })
  }

  // MARK: - Private methods

  private func foregroundColor() -> Color {
    envForegroundColor
      .opacity(hoverEffect ? isHovered ? 1 : 0.5 : 1)
  }

  private func focusOverlayOpacity() -> CGFloat {
    (isFocused && focusEffect && controlActiveState == .key)
    ? 1 : 0.0
  }

  private func focusBackgroundOpacity() -> CGFloat {
    (hoverEffect == false
     && isFocused && focusEffect)
    ? 1 : 0.0
  }

  private func grayscale() -> CGFloat {
    grayscaleEffect ? isHovered ? 0
    : isHovered ? 0.5 : 1
    : controlActiveState == .key ? 0 : 0.4
  }

  private func opacity() -> CGFloat {
    isHovered
    ? 1.0
      : colorScheme == .light ? (calm ? 0.8 : 1) : (calm ? 0.4 : 0.8)
  }
}

struct ZenButtonStyle_Previews: PreviewProvider {
  static var colors: [Color] = [
    Color(.systemRed),
    Color(.systemOrange),
    Color(.systemYellow),
    Color(.systemGreen),
    Color(.systemBlue),
    Color(.systemPurple),
    Color(.systemGray),
    Color(.systemCyan),
    Color(.systemMint),
  ]

  static var previews: some View {
    HStack(alignment: .top) {
      VStack {
        Button(action: {}, label: {
          Image(systemName: "person")
        })
        Button("Primary", action: {})
        Button("Positive", action: {})
        Button("Destructive", action: {})
      }

      VStack {
        ForEach(colors, id: \.self) { color in
          Button(action: {}, label: { Text("Light button") })
            .environment(\.colorScheme, .light)
            .environment(\.buttonBackgroundColor, color)
          Button(action: {}, label: { Text("Dark button") })
            .environment(\.colorScheme, .dark)
            .environment(\.buttonBackgroundColor, color)
        }
      }
    }
    .previewLayout(.sizeThatFits)
    .padding()
  }
}

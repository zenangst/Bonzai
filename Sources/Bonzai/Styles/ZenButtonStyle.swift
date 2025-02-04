import SwiftUI

struct ZenButtonStyle: ButtonStyle {
  @State private var isHovered: Bool
  @Environment(\.isFocused) private var isFocused
  @Environment(\.colorScheme) private var colorScheme
  @Environment(\.controlActiveState) private var controlActiveState

  private let config: ButtonDefaults

  init(_ config: ButtonDefaults) {
    self.config = config
    _isHovered = .init(initialValue: config.hoverEffect ? false : true)
  }

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .textStyle {
        $0.font = config.font
      }
      .padding(config.padding.edgeInsets)
      .foregroundColor(foregroundColor())
      .background(
        ZenStyleBackgroundView(
          cornerRadius: config.cornerRadius,
          calm: config.calm,
          unfocusedOpacity: config.unfocusedOpacity,
          isHovered: $isHovered,
          color: config.backgroundColor
        )
        .opacity(config.backgroundColor == .clear ? 0 : 1)
      )
      .overlay {
        Group {
          RoundedRectangle(cornerRadius: config.cornerRadius + 1.5, style: .continuous)
            .strokeBorder(config.foregroundColor, lineWidth: 1.5)
          RoundedRectangle(cornerRadius: config.cornerRadius, style: .continuous)
            .strokeBorder(config.foregroundColor.opacity(0.5), lineWidth: 1.5)
            .padding(1.5)
        }
        .opacity(focusOverlayOpacity())
        .animation(.bouncy, value: isFocused)
      }
      .background(
        RoundedRectangle(cornerRadius: config.cornerRadius)
          .fill(config.foregroundColor)
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
      .onHover(perform: { value in
        guard config.hoverEffect else { return }
        guard self.isHovered != value else { return }
        self.isHovered = value
      })
  }

  // MARK: - Private methods

  private func foregroundColor() -> Color {
    config.foregroundColor
      .opacity(config.hoverEffect ? isHovered ? 1 : 0.5 : 1)
  }

  private func focusOverlayOpacity() -> CGFloat {
    (isFocused && config.focusEffect && controlActiveState == .key)
    ? 1 : 0.0
  }

  private func focusBackgroundOpacity() -> CGFloat {
    (config.hoverEffect == false
     && isFocused && config.focusEffect)
    ? 1 : 0.0
  }

  private func grayscale() -> CGFloat {
    config.grayscaleEffect ? isHovered ? 0
    : isHovered ? 0.5 : 1
    : controlActiveState == .key ? 0 : 0.4
  }

  private func opacity() -> CGFloat {
    isHovered
    ? 1.0
      : colorScheme == .light ? (config.calm ? 0.8 : 1) : (config.calm ? 0.4 : 0.8)
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
            .buttonStyle { $0.backgroundColor = color }
          Button(action: {}, label: { Text("Dark button") })
            .environment(\.colorScheme, .dark)
            .buttonStyle { $0.backgroundColor = color }
        }
      }
    }
    .previewLayout(.sizeThatFits)
    .padding()
  }
}

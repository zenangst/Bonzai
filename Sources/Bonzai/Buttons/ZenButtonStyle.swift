import SwiftUI

struct ZenButtonStyle: ButtonStyle {
  @State private var isHovered: Bool
  @Binding private var hoverEffect: Bool
  @Environment(\.isFocused) private var isFocused
  @Environment(\.colorScheme) private var colorScheme
  @Environment(\.controlActiveState) private var controlActiveState

  private let config: ZenStyleConfiguration

  init(_ config: ZenStyleConfiguration) {
    self.config = config
    _isHovered = .init(initialValue: config.hoverEffect.wrappedValue ? false : true)
    _hoverEffect = config.hoverEffect
  }

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.vertical, config.padding.vertical?.padding)
      .padding(.horizontal, config.padding.horizontal.padding * 1.5)
      .foregroundColor(foregroundColor())
      .background(
        ZenStyleBackgroundView(
          cornerRadius: config.cornerRadius,
          calm: config.calm,
          isHovered: $isHovered,
          nsColor: config.color.nsColor
        )
      )
      .overlay {
        Group {
          RoundedRectangle(cornerRadius: config.cornerRadius + 1.5, style: .continuous)
            .strokeBorder(Color(nsColor: config.color.nsColor), lineWidth: 1.5)
          RoundedRectangle(cornerRadius: config.cornerRadius, style: .continuous)
            .strokeBorder(Color(nsColor: config.color.nsColor).opacity(0.5), lineWidth: 1.5)
            .padding(1.5)
        }
        .opacity(focusOverlayOpacity())
        .animation(.bouncy, value: isFocused)
      }
      .background(
        RoundedRectangle(cornerRadius: config.cornerRadius)
          .fill(Color(nsColor: config.color.nsColor))
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
        guard config.hoverEffect.wrappedValue else { return }
        guard self.isHovered != value else { return }
        self.isHovered = value
      })
      .onChange(of: hoverEffect, perform: { newValue in
        self.isHovered = !newValue
      })
  }

  // MARK: - Private methods

  private func foregroundColor() -> Color {
    isHovered 
    ? Color(.white)
    : Color(colorScheme == .dark ? .textColor : .textColor)
  }

  private func focusOverlayOpacity() -> CGFloat {
    (isFocused && config.focusEffect.wrappedValue && controlActiveState == .key)
    ? 1 : 0.0
  }

  private func focusBackgroundOpacity() -> CGFloat {
    (config.hoverEffect.wrappedValue == false
     && isFocused && config.focusEffect.wrappedValue)
    ? 1 : 0.0
  }

  private func grayscale() -> CGFloat {
    config.grayscaleEffect.wrappedValue ? isHovered ? 0
    : isHovered ? 0.5 : 1
    : controlActiveState == .key ? 0 : 0.4
  }

  private func opacity() -> CGFloat {
    isHovered
    ? 1.0
    : colorScheme == .light ? 1 : 0.8
  }
}

struct ZenButtonStyle_Previews: PreviewProvider {
  static var colors: [ZenColor] = [
    .systemRed,
    .systemOrange,
    .systemYellow,
    .systemGreen,
    .systemBlue,
    .systemPurple,
    .systemGray,
    .systemCyan,
    .systemMint,
  ]

  static var previews: some View {
    HStack(alignment: .top) {
      VStack {
        Button(action: {}, label: {
          Image(systemName: "person")
        })
        .buttonStyle(.calm(color: .systemGreen, padding: .medium))

        Button("Primary", action: {})
          .buttonStyle(.primary)
        Button("Positive", action: {})
          .buttonStyle(.positive)
        Button("Destructive", action: {})
          .buttonStyle(.destructive)
      }

      VStack {
        ForEach(colors, id: \.self) {
          Button(action: {}, label: { Text("Light button") })
            .environment(\.colorScheme, .light)
            .buttonStyle(.zen(ZenStyleConfiguration(color: $0)))
          Button(action: {}, label: { Text("Dark button") })
            .environment(\.colorScheme, .dark)
            .buttonStyle(.zen(ZenStyleConfiguration(color: $0)))
        }
      }
    }
    .previewLayout(.sizeThatFits)
    .padding()
  }
}

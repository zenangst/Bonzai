import SwiftUI

struct ZenButtonStyle: ButtonStyle {
  @State private var isHovered: Bool
  @Environment(\.colorScheme) var colorScheme
  @Environment(\.controlActiveState) var controlActiveState

  private let config: ZenStyleConfiguration

  init(_ config: ZenStyleConfiguration) {
    self.config = config
    _isHovered = .init(initialValue: config.hoverEffect ? false : true)
  }

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.vertical, config.padding.vertical?.padding)
      .padding(.horizontal, config.padding.horizontal.padding * 1.5)
      .foregroundColor(Color(.textColor))
      .background(
        ZenStyleBackgroundView(
          cornerRadius: config.cornerRadius,
          calm: config.calm,
          isHovered: $isHovered,
          nsColor: config.color.nsColor
        )
      )
      .grayscale(grayscale())
      .compositingGroup()
      .shadow(color: Color.black.opacity(isHovered ? 0.5 : 0),
              radius: configuration.isPressed ? 0 : isHovered ? 1 : 1.25,
              y: configuration.isPressed ? 0 : isHovered ? 2 : 3)
      .opacity(opacity())
      .offset(y: configuration.isPressed ? 0.25 : 0.0)
      .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
      .animation(.easeOut(duration: 0.2), value: isHovered)
      .onHover(perform: { value in
        guard config.hoverEffect else { return }
        self.isHovered = value
      })
  }

  private func grayscale() -> CGFloat {
    config.grayscaleEffect ? isHovered ? 0
    : isHovered ? 0.5 : 1
    : 0
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

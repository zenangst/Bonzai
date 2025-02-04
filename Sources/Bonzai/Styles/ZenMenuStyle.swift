import SwiftUI

struct ZenMenuStyle: MenuStyle {
  private let config: MenuDefaults

  init(_ config: MenuDefaults) {
    self.config = config
  }

  func makeBody(configuration: Configuration) -> some View {
    ZenMenuStyleInternalView(configuration, config: config)
  }
}

struct ZenMenuStyleInternalView: View {
  @Environment(\.controlActiveState) private var controlActiveState
  @Environment(\.colorScheme) private var colorScheme

  private let menuConfiguration: MenuStyleConfiguration
  private let config: MenuDefaults
  @State private var isHovered: Bool
  @Binding private var hoverEffect: Bool

  init(_ menuConfiguration: MenuStyleConfiguration,
       config: MenuDefaults) {
    self.menuConfiguration = menuConfiguration
    self.config = config
    _isHovered = .init(initialValue: config.hoverEffect ? false : true)
    _hoverEffect = .init(get: { config.hoverEffect }, set: { _ in })
  }

  var body: some View {
    Menu(menuConfiguration)
      .menuStyle(.borderlessButton)
      .textStyle({ text in
        text.font = config.font
      })
      .buttonStyle { button in
        let menuButtonStyle = config.buttonConfig()
        button.calm = menuButtonStyle.calm
        button.backgroundColor = menuButtonStyle.backgroundColor
        button.cornerRadius = menuButtonStyle.cornerRadius
        button.font = menuButtonStyle.font
        button.foregroundColor = menuButtonStyle.foregroundColor
        button.glow = menuButtonStyle.glow
        button.grayscaleEffect = menuButtonStyle.grayscaleEffect
        button.hoverEffect = menuButtonStyle.hoverEffect
        button.padding = menuButtonStyle.padding
        button.unfocusedOpacity = menuButtonStyle.unfocusedOpacity
      }
      .truncationMode(.middle)
      .foregroundStyle(foregroundStyle())
      .allowsTightening(true)
      .onHover(perform: { value in
        guard config.hoverEffect else { return }
        self.isHovered = value
      })
      .padding(config.padding.edgeInsets)
      .frame(minHeight: 16)
      .background(
        ZenStyleBackgroundView(
          cornerRadius: config.cornerRadius,
          calm: config.calm,
          unfocusedOpacity: config.unfocusedOpacity,
          isHovered: $isHovered,
          color: config.backgroundColor
        )
      )
      .grayscale(grayscale())
      .compositingGroup()
      .shadow(color: Color.black.opacity(shadowOpacity()),
              radius: isHovered ? 1 : 1.25,
              y: isHovered ? 2 : 3)
      .opacity(opacity())
      .animation(.easeOut(duration: 0.2), value: isHovered)
      .contentShape(Rectangle())
  }

  private func foregroundStyle() -> Color {
    isHovered
    ? Color(.white)
    : Color(colorScheme == .dark ? .textColor : .textColor)
  }

  private func shadowOpacity() -> CGFloat {
    isHovered 
    ? colorScheme == .dark ? 0.5 : 0.1
    : 0
  }

  private func grayscale() -> CGFloat {
    config.grayscaleEffect ? isHovered ? 0
    : isHovered ? 0.5 : 1
    : controlActiveState == .key ? 0 : 0.4
  }

  private func opacity() -> CGFloat {
    isHovered
    ? 1.0
    : colorScheme == .light ? 1 : 0.8
  }
}

struct ZenMenuStyle_Previews: PreviewProvider {
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

  static let columns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible())
  ]

  static var previews: some View {
    LazyVGrid(columns: columns) {
      ForEach(colors, id: \.self) { color in
        Menu("Light menu", content: { Text("Hello") })
          .environment(\.colorScheme, .light)
        Menu("Dark menu", content: { Text("Hello") })
          .environment(\.colorScheme, .dark)

        Group {
          Menu("Light menu", content: { Text("Hello") })
            .environment(\.colorScheme, .light)
          Menu("Dark menu", content: { Text("Hello") })
            .environment(\.colorScheme, .dark)
        }
        .menuStyle()

        Group {
          Menu("Light menu", content: { Text("Hello") })
            .environment(\.colorScheme, .light)
          Menu("Dark menu", content: { Text("Hello") })
            .environment(\.colorScheme, .dark)
        }
        .menuStyle { style in
          style.backgroundColor = color
        }
      }
    }
    .frame(width: 600)
    .padding()
  }
}

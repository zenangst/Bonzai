import SwiftUI

struct ZenMenuStyle: MenuStyle {
  @Environment(\.colorScheme) var colorScheme
  @State private var isHovered: Bool

  private let config: ZenStyleConfiguration
  private let menuIndicator: Visibility

  init(_ config: ZenStyleConfiguration,
              menuIndicator: Visibility = .visible) {
    self.config = config
    self.menuIndicator = menuIndicator
    _isHovered = .init(initialValue: config.hoverEffect ? false : true)
  }

  func makeBody(configuration: Configuration) -> some View {
    Menu(configuration)
      .menuStyle(.borderlessButton)
      .font(.caption)
      .truncationMode(.middle)
      .allowsTightening(true)
      .foregroundColor(Color(.textColor))
      .onHover(perform: { value in
        guard config.hoverEffect else { return }
        self.isHovered = value
      })
      .padding(.horizontal, config.padding.horizontal)
      .padding(.vertical, config.padding.vertical)
      .frame(minHeight: 24)
      .background(
        ZenStyleBackgroundView(
          cornerRadius: config.cornerRadius,
          calm: config.calm,
          isHovered: $isHovered,
          nsColor: config.nsColor
        )
      )
      .grayscale(grayscale())
      .compositingGroup()
      .shadow(color: Color.black.opacity(isHovered ? 0.5 : 0),
              radius: isHovered ? 1 : 1.25,
              y: isHovered ? 2 : 3)
      .opacity(opacity())
      .animation(.easeOut(duration: 0.2), value: isHovered)
      .contentShape(Rectangle())
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

struct ZenMenuStyle_Previews: PreviewProvider {
  static var colors: [NSColor] = [
    NSColor.systemRed,
    NSColor.systemOrange,
    NSColor.systemYellow,
    NSColor.systemGreen,
    NSColor.systemBlue,
    NSColor.systemPurple,
    NSColor.systemGray,
    NSColor.systemCyan,
    NSColor.systemMint,
  ]


  static var previews: some View {
    VStack {
      ForEach(colors, id: \.self) {
        Menu("Light menu", content: { Text("Hello") })
          .environment(\.colorScheme, .light)
          .menuStyle(.zen(ZenStyleConfiguration(nsColor: $0)))
        Menu("Dark menu", content: { Text("Hello") })
          .environment(\.colorScheme, .dark)
          .menuStyle(.zen(ZenStyleConfiguration(nsColor: $0)))
      }
    }
    .padding()
  }
}

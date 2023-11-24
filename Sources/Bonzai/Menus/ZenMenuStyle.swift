import SwiftUI

struct ZenMenuStyle: MenuStyle {
  @Environment(\.controlActiveState) var controlActiveState
  @Environment(\.colorScheme) var colorScheme
  @State private var isHovered: Bool
  @Binding private var hoverEffect: Bool

  private let config: ZenStyleConfiguration

  init(_ config: ZenStyleConfiguration) {
    self.config = config
    _isHovered = .init(initialValue: config.hoverEffect.wrappedValue ? false : true)
    _hoverEffect = config.hoverEffect
  }

  func makeBody(configuration: Configuration) -> some View {
    Menu(configuration)
      .menuStyle(.borderlessButton)
      .font(.caption)
      .truncationMode(.middle)
      .allowsTightening(true)
      .foregroundColor(Color(.textColor))
      .onHover(perform: { value in
        guard config.hoverEffect.wrappedValue else { return }
        self.isHovered = value
      })
      .padding(.horizontal, config.padding.horizontal.padding)
      .padding(.vertical, config.padding.vertical?.padding)
      .frame(minHeight: 24)
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
              radius: isHovered ? 1 : 1.25,
              y: isHovered ? 2 : 3)
      .opacity(opacity())
      .animation(.easeOut(duration: 0.2), value: isHovered)
      .contentShape(Rectangle())
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

struct ZenMenuStyle_Previews: PreviewProvider {
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

  static let columns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible())
  ]

  static var previews: some View {
    LazyVGrid(columns: columns) {
      ForEach(colors, id: \.self) {
        Menu("Light menu", content: { Text("Hello") })
          .environment(\.colorScheme, .light)
        Menu("Dark menu", content: { Text("Hello") })
          .environment(\.colorScheme, .dark)

        Menu("Light menu", content: { Text("Hello") })
          .environment(\.colorScheme, .light)
          .menuStyle(.zen(ZenStyleConfiguration(color: $0)))
        Menu("Dark menu", content: { Text("Hello") })
          .environment(\.colorScheme, .dark)
          .menuStyle(.zen(ZenStyleConfiguration(color: $0)))
      }
    }
    .frame(width: 500)
    .padding()
  }
}

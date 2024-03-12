import SwiftUI

struct ZenMenuStyle: MenuStyle {
  private let zenConfiguration: ZenStyleConfiguration

  init(_ config: ZenStyleConfiguration) {
    self.zenConfiguration = config
  }

  func makeBody(configuration: Configuration) -> some View {
    ZenMenuStyleInternalView(configuration, zenConfiguration: zenConfiguration)
  }
}

struct ZenMenuStyleInternalView: View {
  @Environment(\.controlActiveState) private var controlActiveState
  @Environment(\.colorScheme) private var colorScheme

  private let menuConfiguration: MenuStyleConfiguration
  private let zenConfiguration: ZenStyleConfiguration
  @State private var isHovered: Bool
  @Binding private var hoverEffect: Bool

  init(_ menuConfiguration: MenuStyleConfiguration,
       zenConfiguration: ZenStyleConfiguration) {
    self.menuConfiguration = menuConfiguration
    self.zenConfiguration = zenConfiguration
    _isHovered = .init(initialValue: zenConfiguration.hoverEffect.wrappedValue ? false : true)
    _hoverEffect = zenConfiguration.hoverEffect
  }

  var body: some View {
    Menu(menuConfiguration)
      .menuStyle(.borderlessButton)
      .truncationMode(.middle)
      .allowsTightening(true)
      .foregroundColor(Color(.textColor))
      .onHover(perform: { value in
        guard zenConfiguration.hoverEffect.wrappedValue else { return }
        self.isHovered = value
      })
      .padding(.horizontal, zenConfiguration.padding.horizontal.padding)
      .padding(.vertical, zenConfiguration.padding.vertical?.padding)
      .frame(minHeight: 16)
      .background(
        ZenStyleBackgroundView(
          cornerRadius: zenConfiguration.cornerRadius,
          calm: zenConfiguration.calm,
          isHovered: $isHovered,
          nsColor: zenConfiguration.color.nsColor
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
    zenConfiguration.grayscaleEffect.wrappedValue ? isHovered ? 0
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

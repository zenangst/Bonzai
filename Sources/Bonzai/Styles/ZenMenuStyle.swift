import SwiftUI

struct ZenMenuStyle: MenuStyle {
  @Environment(\.menuBackgroundColor) private var backgroundColor: Color
  @Environment(\.menuCalm) private var calm: Bool
  @Environment(\.menuCornerRadius) private var cornerRadius: CGFloat
  @Environment(\.menuFocusEffect) private var focusEffect: Bool
  @Environment(\.menuFont) private var font: Font
  @Environment(\.menuForegroundColor) private var foregroundColor: Color
  @Environment(\.menuGlow) private var glow:  Bool
  @Environment(\.menuGrayscaleEffect) private var grayscaleEffect:  Bool
  @Environment(\.menuHoverEffect) private var hoverEffect:  Bool
  @Environment(\.menuPadding) private var padding: MenuDefaults.Padding
  @Environment(\.menuUnfocusedOpacity) private var unfocusedOpacity :Double

  func makeBody(configuration: Configuration) -> some View {
    ZenMenuStyleInternalView(configuration)
      .environment(\.font, font)
      .environment(\.menuBackgroundColor, backgroundColor)
      .environment(\.menuCalm, calm)
      .environment(\.menuCornerRadius, cornerRadius)
      .environment(\.menuFont, font)
      .environment(\.menuForegroundColor, foregroundColor)
      .environment(\.menuFocusEffect, focusEffect)
      .environment(\.menuGlow, glow)
      .environment(\.menuGrayscaleEffect, grayscaleEffect)
      .environment(\.menuHoverEffect, hoverEffect)
      .environment(\.menuPadding, padding)
      .environment(\.menuUnfocusedOpacity, unfocusedOpacity)
  }
}

struct ZenMenuStyleInternalView: View {
  @Environment(\.menuBackgroundColor) private var backgroundColor: Color
  @Environment(\.menuCalm) private var calm: Bool
  @Environment(\.menuCornerRadius) private var cornerRadius: CGFloat
  @Environment(\.menuFocusEffect) private var focusEffect: Bool
  @Environment(\.menuFont) private var font: Font
  @Environment(\.menuForegroundColor) private var foregroundColor: Color
  @Environment(\.menuGlow) private var glow:  Bool
  @Environment(\.menuGrayscaleEffect) private var grayscaleEffect:  Bool
  @Environment(\.menuHoverEffect) private var hoverEffect:  Bool
  @Environment(\.menuPadding) private var padding: MenuDefaults.Padding
  @Environment(\.menuUnfocusedOpacity) private var unfocusedOpacity :Double

  @Environment(\.controlActiveState) private var controlActiveState
  @Environment(\.colorScheme) private var colorScheme

  private let menuConfiguration: MenuStyleConfiguration
  @State private var isHovered: Bool

  init(_ menuConfiguration: MenuStyleConfiguration) {
    self.menuConfiguration = menuConfiguration
    _isHovered = .init(initialValue: false)
  }

  var body: some View {
    Menu(menuConfiguration)
      .font(font)
      .menuStyle(.borderlessButton)
      .truncationMode(.middle)
      .foregroundStyle(foregroundStyle())
      .allowsTightening(true)
      .onHover(perform: { value in
        guard hoverEffect else { return }
        self.isHovered = value
      })
      .padding(padding.edgeInsets)
      .frame(minHeight: 16)
      .background(
        ZenStyleBackgroundView(
          cornerRadius: cornerRadius,
          calm: calm,
          unfocusedOpacity: unfocusedOpacity,
          isHovered: $isHovered,
          color: backgroundColor
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
    grayscaleEffect ? isHovered ? 0
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

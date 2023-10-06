import SwiftUI

public struct ZenMenuStyle: MenuStyle {
  @Environment(\.colorScheme) var colorScheme
  @State private var isHovered: Bool

  private let config: ZenConfiguration
  private let menuIndicator: Visibility

  public init(_ config: ZenConfiguration,
              menuIndicator: Visibility = .visible) {
    self.config = config
    self.menuIndicator = menuIndicator
    _isHovered = .init(initialValue: config.hoverEffect ? false : true)
  }

  public func makeBody(configuration: Configuration) -> some View {
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
        ZenMenuStyleBackgroundView(
          cornerRadius: config.cornerRadius,
          isHovered: $isHovered,
          nsColor: config.nsColor
        )
      )
      .grayscale(grayscale())
      .compositingGroup()
      .shadow(color: Color.black.opacity(isHovered ? 0.5 : 0),
              radius: isHovered ? 1 : 1.25,
              y: isHovered ? 2 : 3)
      .opacity(opactiy())
      .animation(.easeOut(duration: 0.2), value: isHovered)
      .contentShape(Rectangle())
  }

  private func grayscale() -> CGFloat {
    config.grayscaleEffect ? isHovered ? 0 
    : isHovered ? 0.5 : 1
    : 0
  }

  private func opactiy() -> CGFloat {
    isHovered 
    ? 1.0
    : colorScheme == .light ? 1 : 0.8
  }
}

fileprivate struct ZenMenuStyleBackgroundView: View {
  @Environment(\.colorScheme) var colorScheme
  let cornerRadius: CGFloat
  @Binding var isHovered: Bool
  let nsColor: NSColor

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        .fill(LinearGradient(stops: stops(), startPoint: .top, endPoint: .bottom))
        .background(
          RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .stroke(strokeColor(), lineWidth: 1)
            .offset(y: 0.25)
        )
        .opacity(opacity())
    }
  }

  private func opacity() -> CGFloat {
    isHovered 
    ? 1.0
    : colorScheme == .light ? 0.7 : 0.3
  }

  private func strokeColor() -> Color {
    if colorScheme == .dark {
      Color(nsColor: .shadowColor).opacity(0.2)
    } else {
      Color(nsColor: nsColor).opacity(0.2)
    }
  }

  private func stops() -> [Gradient.Stop] {
    if colorScheme == .dark {
      [
        .init(color: Color(nsColor), location: 0.0),
        .init(color: Color(nsColor.blended(withFraction: 0.3, of: .black)!), location: 0.025),
        .init(color: Color(nsColor.blended(withFraction: 0.5, of: .black)!), location: 1.0),
      ]
    } else {
      [
        .init(color: Color(nsColor.blended(withFraction: 0.8, of: .white)!), location: 0.0),
        .init(color: Color(nsColor.blended(withFraction: 0.2, of: .white)!), location: 0.025),
        .init(color: Color(nsColor.blended(withFraction: 0.3, of: .black)!), location: 1.0),
      ]
    }
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
          .menuStyle(.zen(ZenConfiguration(nsColor: $0)))
        Menu("Dark menu", content: { Text("Hello") })
          .environment(\.colorScheme, .dark)
          .menuStyle(.zen(ZenConfiguration(nsColor: $0)))
      }
    }
    .padding()
  }
}

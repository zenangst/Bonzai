import SwiftUI

public struct ZenLabel<Content>: View where Content: View {
  public enum Style {
    case header
    case sidebar
  }

  private let style: Style
  private let content: () -> Content

  public init(_ style: Style, content: @escaping () -> Content) {
    self.content = content
    self.style = style
  }

  public var body: some View {
    content()
      .font(font(for: style))
      .allowsTightening(true)
      .lineLimit(1)
      .foregroundColor(Color.secondary)
      .frame(height: 12)
  }

  private func font(for style: Style) -> Font {
    switch style {
    case .header: .system(.body, design: .rounded,weight: .semibold)
    case .sidebar: .subheadline.bold()
    }
  }
}

import SwiftUI

public struct ZenLabel<Content>: View where Content: View {
  public enum Style {
    case sidebar
    case content
    case detail
  }

  private let style: Style
  private let content: () -> Content

  public init(_ text: String, style: Style = .detail) where Content == Text {
    self.content = { Text(text) }
    self.style = style
  }

  public init(_ style: Style = .detail, content: @escaping () -> Content) {
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
    case .detail: .system(.callout, design: .rounded,weight: .semibold)
    case .sidebar, .content: .subheadline.bold()
    }
  }
}

import SwiftUI

public enum ZenButtonVariant {
  case calm(color: ZenColor, padding: ZenSize)
  case regular
  case primary
  case positive
  case destructive
  case zen(ZenStyleConfiguration)
}

public extension View {
  func buttonStyle(_ variant: ZenButtonVariant) -> some View {
    let buttonStyle = resolve(variant)
    return self.buttonStyle(buttonStyle)
  }

  private func resolve(_ variant: ZenButtonVariant) -> some ButtonStyle {
    switch variant {
    case .calm(let color, let padding):
      ZenButtonStyle(.init(color: color,
                           padding: .init(horizontal: padding, vertical: padding),
                           calm: true))
    case .regular:
      ZenButtonStyle(.init(color: .systemGray))
    case .primary:
      ZenButtonStyle(.init(color: .accentColor))
    case .positive:
      ZenButtonStyle(.init(color: .systemGreen, grayscaleEffect: .constant(false), hoverEffect: .constant(false)))
    case .destructive:
      ZenButtonStyle(.init(color: .systemRed, grayscaleEffect: .constant(false), hoverEffect: .constant(false)))
    case .zen(let config):
      ZenButtonStyle(config)
    }
  }
}

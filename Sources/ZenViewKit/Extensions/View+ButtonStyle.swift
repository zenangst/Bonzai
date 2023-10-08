import SwiftUI

public enum ZenButtonVariant {
  case calm(NSColor)
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
    case .calm(let nsColor):
      ZenButtonStyle(.init(nsColor: nsColor, calm: true))
    case .primary:
      ZenButtonStyle(.init(nsColor: .controlAccentColor))
    case .positive:
      ZenButtonStyle(.init(nsColor: .systemGreen))
    case .destructive:
      ZenButtonStyle(.init(nsColor: .systemRed))
    case .zen(let config):
      ZenButtonStyle(config)
    }
  }
}

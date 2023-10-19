import SwiftUI

public enum ZenTextFieldVariant {
  case regular(Color?)
  case large(color: ZenColor, backgroundColor: Color?, glow: Bool)
  case zen(ZenStyleConfiguration)
}

public extension View {
  func textFieldStyle(_ variant: ZenTextFieldVariant) -> some View {
    let textFieldStyle = resolve(variant)
    return self.textFieldStyle(textFieldStyle)
  }

  private func resolve(_ variant: ZenTextFieldVariant) -> some TextFieldStyle {
    switch variant {
    case .large(let color, let backgroundColor, let glow):
      if let backgroundColor {
        ZenTextFieldStyle(
          .init(
            color: color,
            backgroundColor: backgroundColor,
            font: .largeTitle,
            glow: glow
          )
        )
      } else {
        ZenTextFieldStyle(
          .init(
            color: color,
            font: .largeTitle,
            glow: glow
          )
        )
      }
    case .regular(let backgroundColor):
      if let backgroundColor = backgroundColor {
        ZenTextFieldStyle(.init(color: .accentColor, backgroundColor: backgroundColor))
      } else {
        ZenTextFieldStyle(.init(color: .accentColor))
      }
    case .zen(let config):
      ZenTextFieldStyle(config)
    }
  }
}

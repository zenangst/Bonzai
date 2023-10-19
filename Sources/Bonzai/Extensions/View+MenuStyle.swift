import SwiftUI

public enum ZenMenuVariant {
  case regular
  case zen(ZenStyleConfiguration)
}

public extension View {
  func menuStyle(_ variant: ZenMenuVariant) -> some View {
    let menuStyle = resolve(variant)
    return self.menuStyle(menuStyle)
  }

  private func resolve(_ variant: ZenMenuVariant) -> some MenuStyle {
    switch variant {
    case .regular: ZenMenuStyle(.init(color: .systemGray))
    case.zen(let config): ZenMenuStyle(config)
    }
  }
}


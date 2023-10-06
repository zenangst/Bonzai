import SwiftUI

public enum ZenMenuStyleKind {
  case zen(ZenConfiguration)
}

public extension View {
  func menuStyle(_ kind: ZenMenuStyleKind) -> some View {
    let menuStyle = resolveMenuStyle(kind)
    return self.menuStyle(menuStyle)
  }

  private func resolveMenuStyle(_ kind: ZenMenuStyleKind) -> some MenuStyle {
    switch kind {
    case.zen(let config): ZenMenuStyle(config)
    }
  }
}


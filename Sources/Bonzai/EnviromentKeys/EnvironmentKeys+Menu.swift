import SwiftUI

struct menuBackgroundColorOverride: EnvironmentKey {
  static let defaultValue: Color = Styles.config.menu.backgroundColor
}

struct menuCalmOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.menu.calm
}

struct menuCornerRadiusOverride: EnvironmentKey {
  static let defaultValue: CGFloat = 6
}

struct menuFocusEffectOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.menu.focusEffect
}

struct menuFontOverride: EnvironmentKey {
  static let defaultValue: Font = Styles.config.menu.font
}

struct menuForegroundColorOverride: EnvironmentKey {
  static let defaultValue: Color = Styles.config.menu.foregroundColor
}

struct menuGlowOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.menu.glow
}

struct menuGrayscaleEffectOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.menu.grayscaleEffect
}

struct menuHoverEffectOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.menu.hoverEffect
}

struct menuPaddingOverride: EnvironmentKey {
  static let defaultValue: MenuDefaults.Padding = Styles.config.menu.padding
}

struct menuUnfocusedOpacityOverride: EnvironmentKey {
  static let defaultValue: Double = Styles.config.menu.unfocusedOpacity
}

extension EnvironmentValues {
  var menuBackgroundColor: Color {
    get { self[menuBackgroundColorOverride.self] }
    set { self[menuBackgroundColorOverride.self] = newValue }
  }

  var menuCalm: Bool {
    get { self[menuCalmOverride.self] }
    set { self[menuCalmOverride.self] = newValue }
  }

  var menuCornerRadius: CGFloat {
    get { self[menuCornerRadiusOverride.self] }
    set { self[menuCornerRadiusOverride.self] = newValue }
  }

  var menuFocusEffect: Bool {
    get { self[menuFocusEffectOverride.self] }
    set { self[menuFocusEffectOverride.self] = newValue }
  }

  var menuFont: Font {
    get { self[menuFontOverride.self] }
    set { self[menuFontOverride.self] = newValue }
  }

  var menuForegroundColor: Color {
    get { self[menuForegroundColorOverride.self] }
    set { self[menuForegroundColorOverride.self] = newValue }
  }

  var menuGlow: Bool {
    get { self[menuGlowOverride.self] }
    set { self[menuGlowOverride.self] = newValue }
  }

  var menuGrayscaleEffect: Bool {
    get { self[menuGrayscaleEffectOverride.self] }
    set { self[menuGrayscaleEffectOverride.self] = newValue }
  }

  var menuHoverEffect: Bool {
    get { self[menuHoverEffectOverride.self] }
    set { self[menuHoverEffectOverride.self] = newValue }
  }

  var menuPadding: MenuDefaults.Padding {
    get { self[menuPaddingOverride.self] }
    set { self[menuPaddingOverride.self] = newValue }
  }

  var menuUnfocusedOpacity: Double {
    get { self[menuUnfocusedOpacityOverride.self] }
    set { self[menuUnfocusedOpacityOverride.self] = newValue }
  }
}

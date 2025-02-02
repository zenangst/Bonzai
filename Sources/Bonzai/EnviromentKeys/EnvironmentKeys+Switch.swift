import SwiftUI

struct switchBackgroundColorOverride: EnvironmentKey {
  static let defaultValue: Color = Styles.config.switch.backgroundColor
}

struct switchCalmOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.switch.calm
}

struct switchCornerRadiusOverride: EnvironmentKey {
  static let defaultValue: CGFloat = 6
}

struct switchFocusEffectOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.switch.focusEffect
}

struct switchFontOverride: EnvironmentKey {
  static let defaultValue: Font = Styles.config.switch.font
}

struct switchForegroundColorOverride: EnvironmentKey {
  static let defaultValue: Color = Styles.config.switch.foregroundColor
}

struct switchGlowOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.switch.glow
}

struct switchGrayscaleEffectOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.switch.grayscaleEffect
}

struct switchHoverEffectOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.switch.hoverEffect
}

struct switchPaddingOverride: EnvironmentKey {
  static let defaultValue: SwitchDefaults.Padding = Styles.config.switch.padding
}

struct switchStyleOverride: EnvironmentKey {
  static let defaultValue: SwitchDefaults.Style = Styles.config.switch.style
}

struct switchUnfocusedOpacityOverride: EnvironmentKey {
  static let defaultValue: Double = Styles.config.switch.unfocusedOpacity
}

extension EnvironmentValues {
  var switchBackgroundColor: Color {
    get { self[switchBackgroundColorOverride.self] }
    set { self[switchBackgroundColorOverride.self] = newValue }
  }

  var switchCalm: Bool {
    get { self[switchCalmOverride.self] }
    set { self[switchCalmOverride.self] = newValue }
  }

  var switchCornerRadius: CGFloat {
    get { self[switchCornerRadiusOverride.self] }
    set { self[switchCornerRadiusOverride.self] = newValue }
  }

  var switchFocusEffect: Bool {
    get { self[switchFocusEffectOverride.self] }
    set { self[switchFocusEffectOverride.self] = newValue }
  }

  var switchFont: Font {
    get { self[switchFontOverride.self] }
    set { self[switchFontOverride.self] = newValue }
  }

  var switchForegroundColor: Color {
    get { self[switchForegroundColorOverride.self] }
    set { self[switchForegroundColorOverride.self] = newValue }
  }

  var switchGlow: Bool {
    get { self[switchGlowOverride.self] }
    set { self[switchGlowOverride.self] = newValue }
  }

  var switchGrayscaleEffect: Bool {
    get { self[switchGrayscaleEffectOverride.self] }
    set { self[switchGrayscaleEffectOverride.self] = newValue }
  }

  var switchHoverEffect: Bool {
    get { self[switchHoverEffectOverride.self] }
    set { self[switchHoverEffectOverride.self] = newValue }
  }

  var switchPadding: SwitchDefaults.Padding {
    get { self[switchPaddingOverride.self] }
    set { self[switchPaddingOverride.self] = newValue }
  }

  var switchStyle: SwitchDefaults.Style {
    get { self[switchStyleOverride.self] }
    set { self[switchStyleOverride.self] = newValue }
  }

  var switchUnfocusedOpacity: Double {
    get { self[switchUnfocusedOpacityOverride.self] }
    set { self[switchUnfocusedOpacityOverride.self] = newValue }
  }
}

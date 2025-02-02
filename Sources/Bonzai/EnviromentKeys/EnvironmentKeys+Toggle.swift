import SwiftUI

struct toggleBackgroundColorOverride: EnvironmentKey {
  static let defaultValue: Color = Styles.config.toggle.backgroundColor
}

struct toggleCalmOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.toggle.calm
}

struct toggleCornerRadiusOverride: EnvironmentKey {
  static let defaultValue: CGFloat = 6
}

struct toggleFocusEffectOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.toggle.focusEffect
}

struct toggleFontOverride: EnvironmentKey {
  static let defaultValue: Font = Styles.config.toggle.font
}

struct toggleForegroundColorOverride: EnvironmentKey {
  static let defaultValue: Color = Styles.config.toggle.foregroundColor
}

struct toggleGlowOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.toggle.glow
}

struct toggleGrayscaleEffectOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.toggle.grayscaleEffect
}

struct toggleHoverEffectOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.toggle.hoverEffect
}

struct togglePaddingOverride: EnvironmentKey {
  static let defaultValue: ToggleDefaults.Padding = Styles.config.toggle.padding
}

struct toggleStyleOverride: EnvironmentKey {
  static let defaultValue: ToggleDefaults.Style = Styles.config.toggle.style
}

struct toggleUnfocusedOpacityOverride: EnvironmentKey {
  static let defaultValue: Double = Styles.config.toggle.unfocusedOpacity
}

extension EnvironmentValues {
  var toggleBackgroundColor: Color {
    get { self[toggleBackgroundColorOverride.self] }
    set { self[toggleBackgroundColorOverride.self] = newValue }
  }

  var toggleCalm: Bool {
    get { self[toggleCalmOverride.self] }
    set { self[toggleCalmOverride.self] = newValue }
  }

  var toggleCornerRadius: CGFloat {
    get { self[toggleCornerRadiusOverride.self] }
    set { self[toggleCornerRadiusOverride.self] = newValue }
  }

  var toggleFocusEffect: Bool {
    get { self[toggleFocusEffectOverride.self] }
    set { self[toggleFocusEffectOverride.self] = newValue }
  }

  var toggleFont: Font {
    get { self[toggleFontOverride.self] }
    set { self[toggleFontOverride.self] = newValue }
  }

  var toggleForegroundColor: Color {
    get { self[toggleForegroundColorOverride.self] }
    set { self[toggleForegroundColorOverride.self] = newValue }
  }

  var toggleGlow: Bool {
    get { self[toggleGlowOverride.self] }
    set { self[toggleGlowOverride.self] = newValue }
  }

  var toggleGrayscaleEffect: Bool {
    get { self[toggleGrayscaleEffectOverride.self] }
    set { self[toggleGrayscaleEffectOverride.self] = newValue }
  }

  var toggleHoverEffect: Bool {
    get { self[toggleHoverEffectOverride.self] }
    set { self[toggleHoverEffectOverride.self] = newValue }
  }

  var togglePadding: ToggleDefaults.Padding {
    get { self[togglePaddingOverride.self] }
    set { self[togglePaddingOverride.self] = newValue }
  }

  var toggleStyle: ToggleDefaults.Style {
    get { self[toggleStyleOverride.self] }
    set { self[toggleStyleOverride.self] = newValue }
  }

  var toggleUnfocusedOpacity: Double {
    get { self[toggleUnfocusedOpacityOverride.self] }
    set { self[toggleUnfocusedOpacityOverride.self] = newValue }
  }
}

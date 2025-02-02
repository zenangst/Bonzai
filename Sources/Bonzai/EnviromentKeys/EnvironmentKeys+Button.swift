import SwiftUI

struct buttonBackgroundColorOverride: EnvironmentKey {
  static let defaultValue: Color = Styles.config.button.backgroundColor
}

struct buttonCalmOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.button.calm
}

struct buttonCornerRadiusOverride: EnvironmentKey {
  static let defaultValue: CGFloat = 6
}

struct buttonFocusEffectOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.button.focusEffect
}

struct buttonFontOverride: EnvironmentKey {
  static let defaultValue: Font = Styles.config.button.font
}

struct buttonForegroundColorOverride: EnvironmentKey {
  static let defaultValue: Color = Styles.config.button.foregroundColor
}

struct buttonGlowOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.button.glow
}

struct buttonGrayscaleEffectOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.button.grayscaleEffect
}

struct buttonHoverEffectOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.button.hoverEffect
}

struct buttonPaddingOverride: EnvironmentKey {
  static let defaultValue: ButtonDefaults.Padding = Styles.config.button.padding
}

struct buttonUnfocusedOpacityOverride: EnvironmentKey {
  static let defaultValue: Double = Styles.config.button.unfocusedOpacity
}

public extension EnvironmentValues {
  var buttonBackgroundColor: Color {
    get { self[buttonBackgroundColorOverride.self] }
    set { self[buttonBackgroundColorOverride.self] = newValue }
  }

  var buttonCalm: Bool {
    get { self[buttonCalmOverride.self] }
    set { self[buttonCalmOverride.self] = newValue }
  }

  var buttonCornerRadius: CGFloat {
    get { self[buttonCornerRadiusOverride.self] }
    set { self[buttonCornerRadiusOverride.self] = newValue }
  }

  var buttonFocusEffect: Bool {
    get { self[buttonFocusEffectOverride.self] }
    set { self[buttonFocusEffectOverride.self] = newValue }
  }

  var buttonFont: Font {
    get { self[buttonFontOverride.self] }
    set { self[buttonFontOverride.self] = newValue }
  }

  var buttonForegroundColor: Color {
    get { self[buttonForegroundColorOverride.self] }
    set { self[buttonForegroundColorOverride.self] = newValue }
  }

  var buttonGlow: Bool {
    get { self[buttonGlowOverride.self] }
    set { self[buttonGlowOverride.self] = newValue }
  }

  var buttonGrayscaleEffect: Bool {
    get { self[buttonGrayscaleEffectOverride.self] }
    set { self[buttonGrayscaleEffectOverride.self] = newValue }
  }

  var buttonHoverEffect: Bool {
    get { self[buttonHoverEffectOverride.self] }
    set { self[buttonHoverEffectOverride.self] = newValue }
  }

  var buttonPadding: ButtonDefaults.Padding {
    get { self[buttonPaddingOverride.self] }
    set { self[buttonPaddingOverride.self] = newValue }
  }

  var buttonUnfocusedOpacity: Double {
    get { self[buttonUnfocusedOpacityOverride.self] }
    set { self[buttonUnfocusedOpacityOverride.self] = newValue }
  }
}

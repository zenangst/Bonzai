import SwiftUI

struct textFieldBackgroundColorOverride: EnvironmentKey {
  static let defaultValue: Color = Styles.config.textField.backgroundColor
}

struct textFieldCalmOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.textField.calm
}

struct textFieldColorOverride: EnvironmentKey {
  static let defaultValue: Color = Styles.config.textField.color
}

struct textFieldCornerRadiusOverride: EnvironmentKey {
  static let defaultValue: CGFloat = 6
}

struct textFieldDecorationColorOverride: EnvironmentKey {
  static let defaultValue: Color = Styles.config.textField.decorationColor
}

struct textFieldFocusEffectOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.textField.focusEffect
}

struct textFieldFontOverride: EnvironmentKey {
  static let defaultValue: Font = Styles.config.textField.font
}

struct textFieldForegroundColorOverride: EnvironmentKey {
  static let defaultValue: Color = Styles.config.textField.foregroundColor
}

struct textFieldGlowOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.textField.glow
}

struct textFieldGrayscaleEffectOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.textField.grayscaleEffect
}

struct textFieldHoverEffectOverride: EnvironmentKey {
  static let defaultValue: Bool = Styles.config.textField.hoverEffect
}

struct textFieldPaddingOverride: EnvironmentKey {
  static let defaultValue: TextFieldDefaults.Padding = Styles.config.textField.padding
}

struct textFieldStyleOverride: EnvironmentKey {
  static let defaultValue: TextFieldDefaults.Style = Styles.config.textField.style
}

struct textFieldUnfocusedOpacityOverride: EnvironmentKey {
  static let defaultValue: Double = Styles.config.textField.unfocusedOpacity
}

extension EnvironmentValues {
  var textFieldBackgroundColor: Color {
    get { self[textFieldBackgroundColorOverride.self] }
    set { self[textFieldBackgroundColorOverride.self] = newValue }
  }

  var textFieldCalm: Bool {
    get { self[textFieldCalmOverride.self] }
    set { self[textFieldCalmOverride.self] = newValue }
  }

  var textFieldColor: Color {
    get { self[textFieldColorOverride.self] }
    set { self[textFieldColorOverride.self] = newValue }
  }

  var textFieldCornerRadius: CGFloat {
    get { self[textFieldCornerRadiusOverride.self] }
    set { self[textFieldCornerRadiusOverride.self] = newValue }
  }

  var textFieldDecorationColor: Color {
    get { self[textFieldDecorationColorOverride.self] }
    set { self[textFieldDecorationColorOverride.self] = newValue }
  }

  var textFieldFocusEffect: Bool {
    get { self[textFieldFocusEffectOverride.self] }
    set { self[textFieldFocusEffectOverride.self] = newValue }
  }

  var textFieldFont: Font {
    get { self[textFieldFontOverride.self] }
    set { self[textFieldFontOverride.self] = newValue }
  }

  var textFieldForegroundColor: Color {
    get { self[textFieldForegroundColorOverride.self] }
    set { self[textFieldForegroundColorOverride.self] = newValue }
  }

  var textFieldGlow: Bool {
    get { self[textFieldGlowOverride.self] }
    set { self[textFieldGlowOverride.self] = newValue }
  }

  var textFieldGrayscaleEffect: Bool {
    get { self[textFieldGrayscaleEffectOverride.self] }
    set { self[textFieldGrayscaleEffectOverride.self] = newValue }
  }

  var textFieldHoverEffect: Bool {
    get { self[textFieldHoverEffectOverride.self] }
    set { self[textFieldHoverEffectOverride.self] = newValue }
  }

  var textFieldPadding: TextFieldDefaults.Padding {
    get { self[textFieldPaddingOverride.self] }
    set { self[textFieldPaddingOverride.self] = newValue }
  }

  var textFieldStyle: TextFieldDefaults.Style {
    get { self[textFieldStyleOverride.self] }
    set { self[textFieldStyleOverride.self] = newValue }
  }

  var textFieldUnfocusedOpacity: Double {
    get { self[textFieldUnfocusedOpacityOverride.self] }
    set { self[textFieldUnfocusedOpacityOverride.self] = newValue }
  }
}

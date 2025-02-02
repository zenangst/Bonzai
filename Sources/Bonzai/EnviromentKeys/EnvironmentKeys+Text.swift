import SwiftUI

struct TextColorOverride: EnvironmentKey {
  static let defaultValue: Color = Styles.config.text.color
}
struct TextFontOverride: EnvironmentKey {
  static let defaultValue: Font = Styles.config.text.font
}

extension EnvironmentValues {
  var textColor: Color {
    get { self[TextColorOverride.self] }
    set { self[TextColorOverride.self] = newValue }
  }

  var textFont: Font {
    get { self[TextFontOverride.self] }
    set { self[TextFontOverride.self] = newValue }
  }
}

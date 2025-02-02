import SwiftUI

public final class Styles {
  @MainActor public static var shared = Styles()
  internal static var config = Config()

  public static func configure<Value>(_ keyPath: WritableKeyPath<Config, Value>, _ handler: (inout Value) -> Void) {
    var value = config[keyPath: keyPath]
    handler(&value)
    config[keyPath: keyPath] = value
  }

  public struct Config {
    var button: ButtonDefaults = .defaults()
    var menu: MenuDefaults = .defaults()
    var `switch`: SwitchDefaults = .defaults()
    var textField: TextFieldDefaults = .defaults()
    var text: TextDefaults = .init()
    var toggle: ToggleDefaults = .init()
  }
}

import SwiftUI

private struct HierarchyStyleLevelKey: EnvironmentKey {
  static let defaultValue: HierarchyStyleViewModifier.Level = .root
}
private struct HierarchyStyleSectionKey: EnvironmentKey {
  static let defaultValue: HierarchyStyleViewModifier.Section = .detail
}

private extension EnvironmentValues {
  var level: HierarchyStyleViewModifier.Level {
    get { self[HierarchyStyleLevelKey.self] }
    set { self[HierarchyStyleLevelKey.self] = newValue }
  }

  var section: HierarchyStyleViewModifier.Section {
    get { self[HierarchyStyleSectionKey.self] }
    set { self[HierarchyStyleSectionKey.self] = newValue }
  }
}

public struct HierarchyStyleViewModifier: ViewModifier {
  public static var debug: Bool = false

  public enum Section: String {
    case sidebar
    case content
    case detail
  }

  public enum Level: String {
    case root
    case primary
    case secondary
    case tertiary
    case list
    case item
    case subItem

    var color: Color {
      switch self {
      case .root: Color.systemRed
      case .primary: Color.systemOrange
      case .secondary: Color.systemYellow
      case .tertiary: Color.systemGreen
      case .list: Color.systemBlue
      case .item: Color.systemPurple
      case .subItem: Color.systemIndigo
      }
    }

    func padding(in section: Section) -> (horizontal: CGFloat, vertical: CGFloat) {
      switch (section, self) {
      case (.sidebar, .root):      (horizontal: 12, vertical: 0)
      case (.sidebar, .primary):   (horizontal: 10, vertical: 4)
      case (.sidebar, .secondary): (horizontal: 4, vertical: 0)
      case (.sidebar, .tertiary):  (horizontal: 4, vertical: 0)
      case (.sidebar, .list):      (horizontal: 0, vertical: 4)
      case (.sidebar, .item):      (horizontal: 8, vertical: 4)
      case (.sidebar, .subItem):   (horizontal: 4, vertical: 0)

      case (.content, .root):      (horizontal: 12, vertical: 12)
      case (.content, .primary):   (horizontal: 10, vertical: 0)
      case (.content, .secondary): (horizontal: 4, vertical: 0)
      case (.content, .tertiary):  (horizontal: 0, vertical: 0)
      case (.content, .list):      (horizontal: 0, vertical: 4)
      case (.content, .item):      (horizontal: 4, vertical: 4)
      case (.content, .subItem):   (horizontal: 0, vertical: 0)

      case (.detail, .root):       (horizontal: 0, vertical: 0)
      case (.detail, .primary):    (horizontal: 16, vertical: 4)
      case (.detail, .secondary):  (horizontal: 8, vertical: 4)
      case (.detail, .tertiary):   (horizontal: 12, vertical: 4)
      case (.detail, .list):       (horizontal: 4, vertical: 6)
      case (.detail, .item):       (horizontal: 6, vertical: 4)
      case (.detail, .subItem):    (horizontal: 4, vertical: 4)
      }
    }
  }

  @Environment(\.section)  private var section
  @Environment(\.level) private var level

  private var overrideSection: Section?
  private var overrideLevel: Level?

  init(overrideSection: Section?, overrideLevel: Level?) {
    self.overrideLevel = overrideLevel
    self.overrideSection = overrideSection
  }

  public func body(content: Content) -> some View {
    let currentSection = overrideSection ?? section
    let currentLevel = overrideLevel ?? level
    applyModifiers(content, for: currentSection, level: currentLevel)
      .environment(\.level, nextLevel(currentLevel))
      .environment(\.section, currentSection)
  }

  private func nextLevel(_ level: Level) -> Level {
    switch level {
    case .root:      .primary
    case .primary:   .secondary
    case .secondary: .tertiary
    case .tertiary:  .tertiary
    case .list:      .item
    case .item:      .subItem
    case .subItem:   .subItem
    }
  }

  @ViewBuilder
  private func applyModifiers(_ content: Content, for section: Section, level: Level) -> some View {
    switch section {
    case .sidebar, .content:
      switch level {
      case .root:
        content
          .modifier(Debugger(color: level.color))
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.top, level.padding(in: section).vertical)
          .padding(.bottom, nextLevel(level).padding(in: section).vertical)
          .textStyle()
          .buttonStyle {
            $0.calm = true
          }
          .menuStyle {
            $0.color = .accentColor
            $0.calm = true
          }
      case .primary:
        content
          .modifier(Debugger(color: level.color))
          .frame(maxWidth: .infinity, alignment: .leading)
          .textStyle {
            $0.font = .headline
          }
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
      case .secondary:
        content
          .modifier(Debugger(color: level.color))
          .frame(maxWidth: .infinity, alignment: .leading)
          .textStyle()
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
      case .tertiary:
        content
          .modifier(Debugger(color: level.color))
          .textStyle()
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
      case .list:
        content
          .modifier(Debugger(color: level.color))
          .textStyle()
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
      case .item:
        content
          .modifier(Debugger(color: level.color))
          .textStyle()
          .menuStyle { menu in
            menu.padding = .small
          }
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
          .environment(\.textFont, .body)
      case .subItem:
        content
          .modifier(Debugger(color: level.color))
          .textStyle()
          .environment(\.textFont, .caption)
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
      }
    case .detail:
      switch level {
      case .root:
        content
          .modifier(Debugger(color: level.color))
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
          .textStyle()
          .buttonStyle()
          .menuStyle()
          .textFieldStyle()
      case .primary:
        content
          .modifier(Debugger(color: level.color))
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
      case .secondary:
        content
          .modifier(Debugger(color: level.color))
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
      case .tertiary:
        content
          .modifier(Debugger(color: level.color))
          .textFieldStyle({ textField in
            textField.style = .roundedBorder
            textField.decorationColor = .clear
            textField.backgroundColor = .clear
            textField.padding = .small
          })
          .textStyle { text in
            text.font = .caption2
          }
          .checkboxStyle { checkbox in
            checkbox.style = .small
          }
          .menuStyle { menu in
            menu.calm = false
            menu.font = .caption2
            menu.cornerRadius = 4
            menu.padding = .medium
          }
          .buttonStyle { button in
            button.calm = false
            button.font = .caption2
            button.padding = .small
          }
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
      case .list:
        content
          .modifier(Debugger(color: level.color))
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
      case .item:
        content
          .modifier(Debugger(color: level.color))
          .textStyle { text in
            text.font = .body
          }
          .textFieldStyle({ textField in
            textField.style = .roundedBorder
            textField.backgroundColor = .clear
          })
          .buttonStyle { button in
            button.font = .caption2
            button.cornerRadius = 4
          }
          .menuStyle { menu in
            menu.font = .caption2
            menu.cornerRadius = 4
          }
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
      case .subItem:
        content
          .modifier(Debugger(color: level.color))
          .textFieldStyle({ textField in
            textField.style = .roundedBorder
            textField.decorationColor = .clear
            textField.backgroundColor = .clear
            textField.padding = .small
          })
          .textStyle { text in
            text.font = .caption2
          }
          .checkboxStyle { checkbox in
            checkbox.style = .small
          }
          .menuStyle { menu in
            menu.calm = false
            menu.font = .caption2
            menu.cornerRadius = 4
            menu.padding = .medium
          }
          .buttonStyle { button in
            button.calm = true
            button.font = .caption2
            button.cornerRadius = 4
            button.padding = .small
          }
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
      }
    }
  }
}

fileprivate struct Debugger: ViewModifier {
  let color: Color

  func body(content: Content) -> some View {
    if HierarchyStyleViewModifier.debug {
      content
        .overlay {
          LinearGradient(stops: [
            .init(color: color.opacity(0.25), location: 0),
            .init(color: color.opacity(0.5), location: 1),
          ], startPoint: .top, endPoint: .bottom)
          .mask {
            RoundedRectangle(cornerRadius: 4)
              .stroke(color, lineWidth: 1)
          }
          .padding(2)
          .allowsHitTesting(false)
        }
    } else {
      content
    }
  }
}

public enum HierarchyStyle {
  case section(HierarchyStyleViewModifier.Section)
  case derived
  case list
  case item
  case subItem

  var debugValue: String {
    switch self {
    case .section(let section): "section(\(section.rawValue))"
    case .derived: "derived"
    case .list: "list"
    case .item: "item"
    case .subItem: "subItem"
    }
  }
}

public extension View {
  @ViewBuilder
  func defaultStyle() -> some View {
    self
      .buttonStyle()
      .checkboxStyle()
      .menuStyle()
      .textFieldStyle()
      .textStyle()
  }

  func style(_ kind: HierarchyStyle) -> some View {
    switch kind {
    case .section(let section):
      self.modifier(HierarchyStyleViewModifier(overrideSection: section, overrideLevel: nil))
    case .derived:
      self.modifier(HierarchyStyleViewModifier(overrideSection: nil, overrideLevel: nil))
    case .list:
      self.modifier(HierarchyStyleViewModifier(overrideSection: nil, overrideLevel: .list))
    case .item:
      self.modifier(HierarchyStyleViewModifier(overrideSection: nil, overrideLevel: .item))
    case .subItem:
      self.modifier(HierarchyStyleViewModifier(overrideSection: nil, overrideLevel: .subItem))
    }
  }
}

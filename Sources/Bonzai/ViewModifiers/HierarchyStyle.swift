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
  public enum Section {
    case sidebar
    case content
    case detail
  }

  public enum Level {
    case root
    case primary
    case secondary
    case tertiary
    case item
    case subItem

    func padding(in section: Section) -> (horizontal: CGFloat, vertical: CGFloat) {
      switch (section, self) {
      case (.sidebar, .root):      (horizontal: 12, vertical: 2)
      case (.sidebar, .primary):   (horizontal: 10, vertical: 4)
      case (.sidebar, .secondary): (horizontal: 4, vertical: 0)
      case (.sidebar, .tertiary):  (horizontal: 4, vertical: 0)
      case (.sidebar, .item):      (horizontal: 8, vertical: 4)
      case (.sidebar, .subItem):   (horizontal: 4, vertical: 0)

      case (.content, .root):      (horizontal: 12, vertical: 4)
      case (.content, .primary):   (horizontal: 10, vertical: 0)
      case (.content, .secondary): (horizontal: 4, vertical: 0)
      case (.content, .tertiary):  (horizontal: 0, vertical: 0)
      case (.content, .item):      (horizontal: 4, vertical: 4)
      case (.content, .subItem):   (horizontal: 0, vertical: 0)

      case (.detail, .root):       (horizontal: 0, vertical: 0)
      case (.detail, .primary):    (horizontal: 16, vertical: 4)
      case (.detail, .secondary):  (horizontal: 8, vertical: 0)
      case (.detail, .tertiary):   (horizontal: 4, vertical: 4)
      case (.detail, .item):       (horizontal: 4, vertical: 8)
      case (.detail, .subItem):    (horizontal: 4, vertical: 0)
      }
    }
  }

  @Environment(\.section)  private var section
  @Environment(\.level) private var level

  private var overrideSection: Section?
  private var overrideLevel: Level?

  init(overrideSection: Section? = nil, overrideLevel: Level? = nil) {
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
          .padding(.top, level.padding(in: section).vertical)
          .padding(.bottom, nextLevel(level).padding(in: section).vertical)
      case .primary:
        content
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
      case .secondary:
        content
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
      case .tertiary:
        content
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
      case .item:
        content
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
      case .subItem:
        content
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
      }
    case .detail:
      switch level {
      case .root:
        content
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
      case .primary:
        content
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
      case .secondary:
        content
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
      case .tertiary:
        content
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
      case .item:
        content
          .roundedContainer(6, padding: 4, margin: 4)
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, 2)
      case .subItem:
        content
          .roundedContainer(4, padding: 4, margin: 2)
          .padding(.horizontal, level.padding(in: section).horizontal)
          .padding(.vertical, level.padding(in: section).vertical)
      }
    }
  }
}

public enum HierarchyStyle {
  case section(HierarchyStyleViewModifier.Section)
  case derived
  case item
  case subItem
}

public extension View {
  func style(_ kind: HierarchyStyle) -> some View {
    switch kind {
    case .section(let section):
      self.modifier(HierarchyStyleViewModifier(overrideSection: section, overrideLevel: nil))
    case .derived:
      self.modifier(HierarchyStyleViewModifier(overrideSection: nil, overrideLevel: nil))
    case .item:
      self.modifier(HierarchyStyleViewModifier(overrideLevel: .item))
    case .subItem:
      self.modifier(HierarchyStyleViewModifier(overrideLevel: .subItem))
    }
  }
}

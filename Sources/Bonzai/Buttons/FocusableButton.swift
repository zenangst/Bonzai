import SwiftUI

public struct FocusableButton<Content, Focus>: View where Content: View, Focus: Hashable {
  @FocusState private var focus: Focus?

  private let identity: () -> Focus
  private let variant: ZenButtonVariant
  private let action: () -> Void
  private let label: () -> Content

  public init(
    _ focus: FocusState<Focus?>,
    identity: @escaping @autoclosure () -> Focus,
    variant: ZenButtonVariant,
    action: @escaping () -> Void,
    label: @escaping () -> Content
  ) {
    _focus = focus
    self.identity = identity
    self.variant = variant
    self.action = action
    self.label = label
  }

  public var body: some View {
    ZStack {
      Button(action: action, label: label)
        .focusable($focus, as: identity(), onFocus: { })
        .buttonStyle(variant)
        .onCommand(#selector(NSResponder.insertNewline(_:)), perform: {
          action()
        })
    }
    .focusable(true)
    .focused($focus, equals: identity())
    .focusEffectDisabled_shim()

  }
}

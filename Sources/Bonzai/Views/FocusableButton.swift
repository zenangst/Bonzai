import SwiftUI

public struct FocusableButton<Content, Focus>: View where Content: View, Focus: Hashable {
  private let identity: () -> Focus
  private let action: () -> Void
  private let label: () -> Content
  private var focus: FocusState<Focus?>.Binding

  public init(
    _ focus: FocusState<Focus?>.Binding,
    identity: @escaping @autoclosure () -> Focus,
    action: @escaping () -> Void,
    label: @escaping () -> Content
  ) {
    self.focus = focus
    self.identity = identity
    self.action = action
    self.label = label
  }

  public var body: some View {
    ZStack {
      Button(action: action, label: label)
        .focusable(focus, as: identity(), onFocus: { })
        .onCommand(#selector(NSResponder.insertNewline(_:)), perform: {
          action()
        })
    }
    .focusable(true)
    .focused(focus, equals: identity())
    .focusEffectDisabled_shim()
  }
}

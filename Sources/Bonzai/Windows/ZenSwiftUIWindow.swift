import SwiftUI

public struct ZenSwiftUIWindowOverrides {
  public var canBecomeKey: Bool
  public var canBecomeMain: Bool

  public init(canBecomeKey: Bool, canBecomeMain: Bool) {
    self.canBecomeKey = canBecomeKey
    self.canBecomeMain = canBecomeMain
  }
}

open class ZenSwiftUIWindow<Content>: NSWindow where Content: View {
  private let sizeFitting: (_ size: CGSize) -> CGSize
  public var overrides: ZenSwiftUIWindowOverrides

  public init(contentRect: NSRect = .zero, styleMask style: NSWindow.StyleMask,
              overrides: ZenSwiftUIWindowOverrides = .init(canBecomeKey: true, canBecomeMain: false),
              @ViewBuilder content rootView: () -> Content) {
    let rootView = rootView()
      .defaultStyle()
    let hostingController = NSHostingController(rootView: rootView)
    self.sizeFitting = { hostingController.sizeThatFits(in: $0) }
    self.overrides = overrides
    super.init(contentRect: contentRect, styleMask: style, backing: .buffered, defer: true)

    hostingController.view.setFrameSize(hostingController.sizeThatFits(in: contentRect.size))

    self.contentView = hostingController.view
    self.isReleasedWhenClosed = false
  }

  public convenience init(contentRect: NSRect = .zero, styleMask style: NSWindow.StyleMask,
                          content: @autoclosure () -> Content) {
    self.init(contentRect: contentRect, styleMask: style, content: content)
  }

  public func sizeThatFits(in size: CGSize) -> CGSize {
    sizeFitting(size)
  }

  open override var canBecomeKey: Bool { overrides.canBecomeKey }
  open override var canBecomeMain: Bool { overrides.canBecomeMain }
}

protocol SizeFitting: NSWindow {
  func sizeThatFits(in size: CGSize) -> CGSize
}

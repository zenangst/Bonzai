import SwiftUI

open class ZenSwiftUIPanel<Content>: NSPanel where Content: View {
  public let hostingController: NSHostingController<Content>
  public var overrides: ZenSwiftUIWindowOverrides

  public init(contentRect: NSRect = .zero, styleMask style: NSWindow.StyleMask,
              overrides: ZenSwiftUIWindowOverrides = .init(canBecomeKey: true, canBecomeMain: false),
              @ViewBuilder content: () -> Content) {
    self.hostingController = NSHostingController(rootView: content())
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
    hostingController.sizeThatFits(in: size)
  }


  open override var canBecomeKey: Bool { overrides.canBecomeKey }
  open override var canBecomeMain: Bool { overrides.canBecomeMain }
}

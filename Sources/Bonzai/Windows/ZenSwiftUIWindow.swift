import SwiftUI

open class ZenSwiftUIWindow<Content>: NSWindow where Content: View {
  public let hostingController: NSHostingController<Content>

  public init(contentRect: NSRect = .zero, styleMask style: NSWindow.StyleMask, @ViewBuilder content: () -> Content) {
    self.hostingController = NSHostingController(rootView: content())
    super.init(contentRect: contentRect, styleMask: style, backing: .buffered, defer: true)

    hostingController.view.setFrameSize(hostingController.sizeThatFits(in: contentRect.size))

    self.contentView = hostingController.view
    self.isReleasedWhenClosed = false
  }

  public convenience init(contentRect: NSRect = .zero, styleMask style: NSWindow.StyleMask,
                          content: @autoclosure () -> Content) {
    self.init(contentRect: contentRect, styleMask: style, content: content)
  }
}

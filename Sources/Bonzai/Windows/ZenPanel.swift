import AppKit
import Combine
import SwiftUI

public final class ZenPanel<Content>: NSPanel where Content: View {
  private let manager: ZenWindowManager
  public override var canBecomeKey: Bool { false }
  public override var canBecomeMain: Bool { false }

  public init(animationBehavior: NSWindow.AnimationBehavior,
              contentRect: NSRect = .init(origin: .zero, size: .init(width: 200, height: 200)),
              styleMask: NSWindow.StyleMask = [.borderless, .nonactivatingPanel],
              content rootView: @autoclosure @escaping () -> Content) {
    self.manager = ZenWindowManager()
    super.init(contentRect: contentRect, styleMask: styleMask, backing: .buffered, defer: false)

    self.animationBehavior = animationBehavior
    self.collectionBehavior.insert(.fullScreenAuxiliary)
    self.collectionBehavior.insert(.canJoinAllSpaces)
    self.collectionBehavior.insert(.stationary)
    self.isOpaque = false
    self.isFloatingPanel = true
    self.isMovable = false
    self.isMovableByWindowBackground = false
    self.level = .screenSaver
    self.becomesKeyOnlyIfNeeded = true
    self.backgroundColor = .clear
    self.acceptsMouseMovedEvents = false
    self.hasShadow = false

    self.manager.window = self

    let rootView = rootView()
      .environmentObject(manager)
      .ignoresSafeArea()

    let contentViewController = NSHostingController(rootView: rootView)
    self.contentViewController = contentViewController
    setFrame(contentRect, display: false)
  }
}

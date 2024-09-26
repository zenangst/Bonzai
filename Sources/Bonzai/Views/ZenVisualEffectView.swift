import AppKit
import SwiftUI

public struct ZenVisualEffectView: NSViewRepresentable {
  private var material: NSVisualEffectView.Material
  private var blendingMode: NSVisualEffectView.BlendingMode
  private var state: NSVisualEffectView.State

  public init(material: NSVisualEffectView.Material = .contentBackground,
              blendingMode: NSVisualEffectView.BlendingMode = .behindWindow,
              state: NSVisualEffectView.State = .active) {
    self.material = material
    self.blendingMode = blendingMode
    self.state = state
  }

  public func makeNSView(context: Context) -> NSVisualEffectView {
    let view = NSVisualEffectView()
    view.material = material
    view.blendingMode = blendingMode
    view.state = state
    view.wantsLayer = true
    return view
  }

  public func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
    nsView.material = material
    nsView.blendingMode = blendingMode
    nsView.state = state
  }
}

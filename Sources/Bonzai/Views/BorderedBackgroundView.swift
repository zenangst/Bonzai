import SwiftUI

public struct BorderedOverlayView: View {
  @Environment(\.isFocused) private var isFocused
  @EnvironmentObject private var publisher: ZenColorPublisher
  private let cornerRadius: CGFloat
  private let globalPublisher: Bool
  
  public init(cornerRadius: CGFloat, globalPublisher: Bool = true) {
    self.cornerRadius = cornerRadius
    self.globalPublisher = globalPublisher
  }
  
  public var body: some View {
    let color = globalPublisher ? ZenColorPublisher.shared.color : publisher.color
    Group {
      RoundedRectangle(cornerRadius: cornerRadius + 1.5, style: .continuous)
        .strokeBorder(Color(nsColor: color.nsColor), lineWidth: 1.5)
      RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        .strokeBorder(Color(nsColor: color.nsColor).opacity(0.5), lineWidth: 1.5)
        .padding(1.5)
    }
    .opacity(isFocused ? 1 : 0)
    .allowsHitTesting(false)
  }
}

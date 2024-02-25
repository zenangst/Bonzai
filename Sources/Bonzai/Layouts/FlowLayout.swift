import SwiftUI

public struct FlowLayout: Layout {
  private let lineSpacing: CGFloat
  private let itemSpacing: CGFloat
  private let minSize: CGSize?
  private let proposedViewSize: ProposedViewSize

  public init(itemSpacing: CGFloat = 0,
              lineSpacing: CGFloat = 0,
              minSize: CGSize? = nil,
              proposedViewSize: ProposedViewSize = .unspecified) {
    self.itemSpacing = itemSpacing
    self.lineSpacing = lineSpacing
    self.minSize = minSize
    self.proposedViewSize = proposedViewSize
  }

  public func makeCache(subviews: Subviews) -> FlowLayoutCache {
    FlowLayoutCache(subviews.map {
      let size = $0.sizeThatFits(proposedViewSize)
      let propsal = ProposedViewSize(size)
      return FlowLayoutCache.Item(proposal: propsal, size: size)
    })
  }

  public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout FlowLayoutCache) -> CGSize {
    guard !subviews.isEmpty else { return .zero }

    if cacheNeedsUpdate(cache, subviews: subviews) {
      cache = makeCache(subviews: subviews)
    }

    guard var proposalWidth = proposal.width,
          proposalWidth > 0 else {
      return .zero
    }

    var totalHeight: CGFloat = 0
    var x: CGFloat = 0
    var y: CGFloat = cache.items.first?.size.height ?? 0

    if !cache.items.isEmpty {
      proposalWidth -= itemSpacing
    }

    for item in cache.items {
      x += item.size.width

      if x > proposalWidth {
        x = item.size.width
        y += item.size.height + lineSpacing
      } else {
        x += itemSpacing
      }
    }

    totalHeight = y

    return CGSize(width: proposalWidth, height: totalHeight)
  }

  public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout FlowLayoutCache) {
    var x: CGFloat = bounds.minX
    var y: CGFloat = bounds.minY
    var lineHeight: CGFloat = y

    let maxX: CGFloat = if let minSize {
      max(bounds.maxX, minSize.width)
    } else {
      bounds.maxX
    }

    for index in subviews.indices {
      let itemSize = cache.items[index].size
      if x + itemSize.width > maxX {
        lineHeight += itemSize.height + lineSpacing
        x = bounds.minX
        y = lineHeight
      }

      subviews[index].place(
        at: .init(x: x, y: y),
        proposal: cache.items[index].proposal
      )

      x += cache.items[index].size.width + itemSpacing
    }
  }

  public static var layoutProperties: LayoutProperties {
    var properties = LayoutProperties()
    properties.stackOrientation = .horizontal
    return properties
  }

  private func cacheNeedsUpdate(_ cache: FlowLayoutCache, subviews: Subviews) -> Bool {
    return cache.items.count != subviews.count
  }
}

public struct FlowLayoutCache {
  var items: [Item]

  init(_ items: [Item]) {
    self.items = items
  }

  struct Item {
    let proposal: ProposedViewSize
    let size: CGSize
  }
}

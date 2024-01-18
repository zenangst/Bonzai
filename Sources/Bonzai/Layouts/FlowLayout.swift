import SwiftUI

public struct FlowLayout: Layout {
  private let padding: CGFloat
  private let itemSpacing: CGFloat
  private let minSize: CGSize?
  private let proposedViewSize: ProposedViewSize

  public init(itemSpacing: CGFloat = 0,
              padding: CGFloat = 0,
              minSize: CGSize? = nil,
              proposedViewSize: ProposedViewSize = .unspecified) {
    self.itemSpacing = itemSpacing
    self.padding = padding
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

    let items = cache.items

    var totalHeight: CGFloat = 0
    var totalWidth: CGFloat = 0
    var lineWidth: CGFloat = padding
    var lineHeight: CGFloat = 0

    for index in items.indices {
      let itemWidthWithSpacing = items[index].size.width + itemSpacing
      if lineWidth + itemWidthWithSpacing + padding > proposal.width ?? 0 {
        totalHeight += lineHeight
        lineWidth = itemSpacing + items[index].size.width
        lineHeight = items[index].size.height
      } else {
        lineWidth += itemWidthWithSpacing
        lineHeight = max(lineHeight, items[index].size.height)
      }

      totalWidth = max(totalWidth, lineWidth + padding)
    }

    totalHeight += lineHeight
    totalWidth -= padding

    if let minSize {
      return .init(
        width: min(totalWidth, minSize.width),
        height: totalWidth > minSize.height ? totalWidth - padding : minSize.height - padding
      )
    } else {
      return .init(width: totalWidth, height: totalHeight)
    }
  }

  public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout FlowLayoutCache) {
    var lineX = bounds.minX + padding
    var lineY = bounds.minY + padding
    var lineHeight: CGFloat = 0

    let maxX: CGFloat
    if let minSize {
      maxX = max(bounds.maxX, minSize.width) - padding
    } else if let proposedWidth = proposal.width {
      maxX = min(proposedWidth, bounds.maxX) - padding
    } else {
      maxX = bounds.maxX - padding
    }

    for index in subviews.indices {
      let itemWidthWithSpacing = cache.items[index].size.width + padding
      if lineX + itemWidthWithSpacing + padding >= maxX {
        lineY += lineHeight
        lineHeight = 0
        lineX = bounds.minX + padding
      }

      subviews[index].place(
        at: .init(
          x: lineX + cache.items[index].size.width / 2,
          y: lineY + cache.items[index].size.height / 2
        ),
        anchor: .center,
        proposal: cache.items[index].proposal
      )

      lineHeight = max(lineHeight, cache.items[index].size.height)
      lineX += itemWidthWithSpacing
    }
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

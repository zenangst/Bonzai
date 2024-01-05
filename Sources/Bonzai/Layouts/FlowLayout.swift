import SwiftUI

public struct FlowLayout: Layout {
  private let proposedViewSize: ProposedViewSize

  public init(proposedViewSize: ProposedViewSize) {
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
    var lineWidth: CGFloat = 0
    var lineHeight: CGFloat = 0

    for index in items.indices {
      if lineWidth + items[index].size.width > proposal.width ?? 0 {
        totalHeight += lineHeight
        lineWidth = items[index].size.width
        lineHeight = items[index].size.height
      } else {
        lineWidth += items[index].size.width
        lineHeight = max(lineHeight, items[index].size.height)
      }

      totalWidth = max(totalWidth, lineWidth)
    }

    totalHeight += lineHeight

    return .init(width: totalWidth, height: totalHeight)
  }


  public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout FlowLayoutCache) {
    guard !subviews.isEmpty else { return }

    var lineX = bounds.minX
    var lineY = bounds.minY
    var lineHeight: CGFloat = 0

    for index in subviews.indices {
      if lineX + cache.items[index].size.width > (proposal.width ?? 0) {
        lineY += lineHeight
        lineHeight = 0
        lineX = bounds.minX
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
      lineX += cache.items[index].size.width
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

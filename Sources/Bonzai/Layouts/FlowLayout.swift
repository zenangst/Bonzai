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

  public func updateCache(_ cache: inout FlowLayoutCache, subviews: Subviews) {
    cache = makeCache(subviews: subviews)
  }

  public func makeCache(subviews: Subviews) -> FlowLayoutCache {
    FlowLayoutCache(subviews.map {
      let size = $0.sizeThatFits(proposedViewSize)
      let propsal = ProposedViewSize(size)
      return FlowLayoutCache.Item(proposal: propsal, size: size)
    })
  }

  public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, 
                           cache: inout FlowLayoutCache) -> CGSize {
    guard !subviews.isEmpty,
          let proposalWidth = proposal.width, proposalWidth > 0 else { return .zero }

    var totalWidth: CGFloat = 0
    var totalHeight: CGFloat = (cache.items.first?.size.height ?? 0) + (lineSpacing * 2)
    var lineWidth: CGFloat = 0
    var lineHeight: CGFloat = 0

    for item in cache.items {
      let size = item.size
      if lineWidth + size.width > proposal.width ?? 0 {
        lineHeight = size.height + lineSpacing
        lineWidth = size.width + itemSpacing
        totalHeight += lineHeight
      } else {
        lineWidth += size.width + itemSpacing
        lineHeight = max(lineHeight, size.height + lineSpacing)
      }

      totalWidth = max(totalWidth, lineWidth)
    }

    return CGSize(width: totalWidth, height: totalHeight)
  }

  public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, 
                            subviews: Subviews, cache: inout FlowLayoutCache) {
    var x: CGFloat = bounds.minX + itemSpacing / 2
    var y: CGFloat = bounds.minY + lineSpacing

    var dynamicItemSpacing: CGFloat = 0
    var firstRowMaxIndex = 0
    var lineHeight: CGFloat = 0
    var hasPositionedFirstRow = false

    for index in subviews.indices {
      if firstRowMaxIndex == 0 {
        let dynamicWidth = dynamicItemSpacing + cache.items[index].size.width
        if dynamicWidth <= bounds.width {
          dynamicItemSpacing += cache.items[index].size.width + itemSpacing
        } else {
          dynamicItemSpacing = (bounds.width - dynamicItemSpacing) / CGFloat(max(index, 1)) + itemSpacing
          firstRowMaxIndex = index
        }

        if index == subviews.indices.count - 1 {
          for index in subviews.indices {
            positionItem(
              x: &x, y: &y,
              item: cache.items[index],
              bounds: bounds, 
              itemSpacing: itemSpacing,
              lineHeight: &lineHeight,
              subviews: subviews, index: index
            )
          }
        }
      } else {
        if !hasPositionedFirstRow {
          for index in 0...firstRowMaxIndex {
            positionItem(
              x: &x, y: &y,
              item: cache.items[index],
              bounds: bounds,
              itemSpacing: dynamicItemSpacing,
              lineHeight: &lineHeight,
              subviews: subviews, index: index
            )
          }
          hasPositionedFirstRow = true
        }

        positionItem(
          x: &x, y: &y,
          item: cache.items[index],
          bounds: bounds, 
          itemSpacing: dynamicItemSpacing,
          lineHeight: &lineHeight,
          subviews: subviews, index: index
        )
      }
    }
  }

  fileprivate func positionItem(x: inout CGFloat, y: inout CGFloat,
                                item: FlowLayoutCache.Item, bounds: CGRect,
                                itemSpacing: CGFloat, lineHeight: inout CGFloat,
                                subviews: FlowLayout.Subviews,
                                index: Range<LayoutSubviews.Index>.Element) {
    if x >= bounds.width - itemSpacing {
      x = bounds.minX + itemSpacing / 2
      y += lineHeight + lineSpacing
    }

    let origin = CGPoint(x: x, y: y)
    subviews[index].place(at: origin, proposal: item.proposal)

    let width: CGFloat
    let height: CGFloat


    if let minSize {
      width = min(minSize.width, item.size.width)
      height = min(minSize.height, item.size.height)
    } else {
      width = item.size.width
      height = item.size.height
    }

    x += width + itemSpacing
    lineHeight = max(lineHeight, height)
  }
}

public struct FlowLayoutCache {
  var items: [Item]

  init(_ items: [Item]) {
    self.items = items
  }

  struct Item: Equatable {
    let proposal: ProposedViewSize
    let size: CGSize
  }
}

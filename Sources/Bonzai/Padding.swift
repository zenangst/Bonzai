import Foundation
import SwiftUI

struct Padding {
  var top: CGFloat
  var leading: CGFloat
  var bottom: CGFloat
  var trailing: CGFloat

  init(top: CGFloat,
     leading: CGFloat,
     bottom: CGFloat,
     trailing: CGFloat) {
    self.top = top
    self.leading = leading
    self.bottom = bottom
    self.trailing = trailing
  }

  init(_ edgeInsets: EdgeInsets) {
    self.top = edgeInsets.top
    self.leading = edgeInsets.leading
    self.bottom = edgeInsets.bottom
    self.trailing = edgeInsets.trailing
  }
}

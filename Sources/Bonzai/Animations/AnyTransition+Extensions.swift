import Foundation
import SwiftUI

public extension AnyTransition {
  static var fadeAndGrow: AnyTransition {
    .asymmetric(insertion: .opacity.combined(with: .scale(scale: 0.1)),
                removal: .opacity.combined(with: .scale(scale: 0.1)))
  }
}

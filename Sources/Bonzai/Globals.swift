struct Globals {
  static var isLiquidGlass: Bool  {
    if #available(macOS 15, *) {
      return true
    } else {
      return false
    }
  }
}

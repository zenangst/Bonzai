import SwiftUI

public struct ArrowBackgroundView: View {
  @Binding private var offset: CGFloat
  @Binding private var tip: CGFloat
  public init(_ offset: Binding<CGFloat> = .constant(12), tip: Binding<CGFloat> = .constant(0)) {
    _offset = offset
    _tip = tip
  }

  public var body: some View {
    Rectangle()
      .fill(
        LinearGradient(stops: [
          .init(color: Color(nsColor: .windowBackgroundColor.blended(withFraction: 0.3, of: .white)!), location: 0.0),
          .init(color: Color(nsColor: .windowBackgroundColor), location: 0.01),
          .init(color: Color(nsColor: .windowBackgroundColor), location: 1.0),
        ], startPoint: .top, endPoint: .bottom)
      )
      .mask(
        Canvas(opaque: true, rendersAsynchronously: true) { context, size in
          context.fill(
            Path(CGRect(origin: .zero, size: CGSize(width: size.width,
                                                    height: size.height - 12))),
            with: .color(Color(.black))
          )

          context.fill(Path { path in
            path.move(to: CGPoint(x: size.width / 2, y: size.height - offset))

            path.addLine(to: CGPoint(x: size.width / 2 - 24, y: size.height - offset))
            path.addLine(to: CGPoint(x: size.width / 2,
                                     y: size.height - tip))
            path.addLine(to: CGPoint(x: size.width / 2 + 24, y: size.height - offset))

          }, with: .color(Color(.black)))
        }
      )
      .shadow(color: Color.white.opacity(0.2), radius: 0, y: 1)
      .shadow(radius: 2, y: 2)
  }
}

struct ArrowBackgroundView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Text("Hellow, World!")
    }
    .padding(64)
    .background(ArrowBackgroundView())
    .padding(.bottom, 16)
  }
}

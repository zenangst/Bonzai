import SwiftUI

struct ZenTextViewModifier: ViewModifier {
    private let font: Font

    init(_ font: Font = .body) {
        self.font = font
    }

    func body(content: Content) -> some View {
        content
            .padding(2.5)
            .font(font)
    }
}

struct ZenTextViewModifier_Previews: PreviewProvider {
    static var previews: some View {
      VStack {
        Text("Regular text")

        Text("Zen text")
          .modifier(ZenTextViewModifier())
      }
      .padding()
    }
}

import SwiftUI

public struct ZenTextEditor: View {
  @EnvironmentObject var publisher: ColorPublisher
  @FocusState var isFocused: Bool
  @State var isHovered: Bool = false
  @Binding var text: String

  private let color: Color
  private let font: Font
  private let placeholder: String
  private let onFocusChange: ((Bool) -> Void)?
  private let onCommandReturnKey: (() -> Void)?

  public init(color: Color = .accentColor,
              text: Binding<String>,
              placeholder: String,
              font: Font = .body,
              onFocusChange: ((Bool) -> Void)? = nil,
              onCommandReturnKey: (() -> Void)? = nil) {
    _text = text
    self.color = color
    self.placeholder = placeholder
    self.font = font
    self.onCommandReturnKey = onCommandReturnKey
    self.onFocusChange = onFocusChange
  }

  public var body: some View {
    TextEditor(text: $text)
      .scrollContentBackground(.hidden)
      .scrollDisabled(false)
      .font(font)
      .padding([.top, .leading, .bottom], 4)
      .scrollIndicators(.hidden)
      .background(alignment: .leading,
                  content: {
        RoundedRectangle(cornerRadius: 4)
          .fill(
            (isFocused ? color : Color(.windowFrameTextColor))
            .opacity(isFocused ? 0.5 : 0.15)
          )
          .frame(width: 5)
      })
      .overlay(alignment: .topLeading) {
        Text(placeholder)
          .font(font)
          .animation(nil, value: text.isEmpty)
          .opacity(text.isEmpty ? 0.5 : 0)
          .animation(.easeInOut(duration: 0.2), value: text.isEmpty)
          .allowsHitTesting(false)
          .padding(.top, 4)
          .padding(.leading, 8)
        Button("", action: { onCommandReturnKey?() })
          .opacity(0.0)
          .keyboardShortcut(.return, modifiers: [.command])
      }
      .padding(4)
      .background(
        RoundedRectangle(cornerRadius: 4)
          .fill((isFocused ? color : Color(.windowFrameTextColor)))
          .opacity(isFocused ? 0.15 : isHovered ? 0.015 : 0)
      )
      .background(
        RoundedRectangle(cornerRadius: 4)
          .stroke(
            (isFocused ? color : Color(.windowFrameTextColor))
              .opacity(isFocused ? 0.5 : 0.15)
            , lineWidth: 1)
          .opacity(isFocused ? 0.75 : isHovered ? 0.15 : 0)

      )
      .onHover(perform: { newValue in  withAnimation(.easeInOut(duration: 0.2)) { isHovered = newValue } })
      .onChange(of: isFocused, perform: { value in
        onFocusChange?(value)
      })
      .focused($isFocused)
  }
}

fileprivate class PreviewPublisher: ObservableObject {
  @State var text: String

  init(text: String) {
    _text = .init(initialValue: text)
  }
}

struct ZenTextEditor_Previews: PreviewProvider {
  @State fileprivate static var code: PreviewPublisher = .init(text: """
#!/usr/bin/env bash

echo "hello world"
""")
  static var previews: some View {
    Group {
      ZenTextEditor(color: .systemGreen, text: .constant(""), placeholder: "Enter text ...")
      ZenTextEditor(color: .systemPurple, text: $code.text, placeholder: "Script goes here…", font: Font.system(.body, design: .monospaced))
    }
  }
}

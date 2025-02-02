import SwiftUI

struct ZenCheckboxStyle: ToggleStyle {
  @Environment(\.colorScheme) var colorScheme
  @Environment(\.toggleForegroundColor) var foregroundColor
  @Environment(\.toggleBackgroundColor) var backgroundColor
  @Environment(\.toggleStyle) var style
  @State var isHovered: Bool = false

  private let config: ToggleDefaults

  init(config: ToggleDefaults) {
    self.config = config
  }

  func makeBody(configuration: Configuration) -> some View {
    Button {
      configuration.isOn.toggle()
    } label: {
      HStack {
        RoundedRectangle(cornerRadius: 4, style: .continuous)
          .fill(isOnColor(configuration))
          .overlay(content: {
            RoundedRectangle(cornerRadius: 4, style: .continuous)
              .stroke(Color(nsColor: .windowFrameTextColor).opacity(0.2), lineWidth: 1.0)
          })
          .overlay {
            Image(systemName: "checkmark")
              .symbolRenderingMode(.palette)
              .foregroundStyle(checkmarkColor())
              .font(Font.system(size: style.fontSize, weight: .heavy))
              .offset(y: configuration.isOn || isHovered ? 0 : -8)
              .opacity(configuration.isOn ? 1 : isHovered ? 0.5 : 0)
              .animation(.easeInOut(duration: 0.15), value: configuration.isOn)
              .animation(.easeInOut(duration: 0.15), value: isHovered)
          }
          .frame(width: style.size.width, height: style.size.height)
          .onHover(perform: { newValue in
            guard isHovered != newValue else { return }
            isHovered = newValue
          })
        configuration.label
          .font(config.font)
      }
    }
    .buttonStyle(.plain)
  }

  private func isOnColor(_ configuration: Configuration) -> Color {
    configuration.isOn
    ? backgroundColor.blended(withFraction: 0.2, of: .black)
    : colorScheme == .dark ? Color(nsColor: .controlColor) : Color(nsColor: .windowBackgroundColor)
  }

  private func checkmarkColor() -> Color {
    colorScheme == .dark
    ? .white.opacity(0.8)
    : .black.opacity(0.4)
  }
}

#Preview {
  HStack {
    VStack {
      Toggle(isOn: .constant(true), label: {})
    }

    VStack {
      Toggle(isOn: .constant(true), label: {})
    }
    .checkboxStyle()
  }
  .padding()
}

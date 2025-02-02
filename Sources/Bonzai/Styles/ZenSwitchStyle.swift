import SwiftUI

struct ZenSwitchStyle: ToggleStyle {
  @Environment(\.colorScheme) var colorScheme
  @Environment(\.switchForegroundColor) var foregroundColor
  @Environment(\.switchBackgroundColor) var backgroundColor

  let style: SwitchDefaults.Style

  init(style: SwitchDefaults.Style) {
    self.style = style
  }

  func makeBody(configuration: Configuration) -> some View {
    Button(action: {
      configuration.isOn.toggle()
    }, label: {
      HStack {
        Capsule()
          .fill(isOnFillColor(configuration))
          .overlay(alignment: configuration.isOn ? .trailing : .leading, content: {
            Circle()
              .fill(Color(.white))
              .overlay(
                Circle()
                  .stroke(isOnColor(configuration), lineWidth: 0.5)
              )
              .padding(1)
              .shadow(radius: 1)
          })
          .overlay {
            Capsule()
              .stroke(Color(nsColor: backgroundColor.nsBackgroundColor.blended(withFraction: 0.5, of: .black)!), lineWidth: 0.5)
              .opacity(configuration.isOn ? 1 : 0)
          }
          .animation(.default, value: configuration.isOn)
          .background(
            Capsule()
              .strokeBorder(isOnColor(configuration), lineWidth: 1)
          )
          .frame(width: style.size.width, height: style.size.height)
        configuration.label
      }
    })
    .buttonStyle(.plain)
  }

  func isOnFillColor(_ configuration: Configuration) -> Color {
    return configuration.isOn
    ? backgroundColor.blended(withFraction: 0.2, of: .black)
    : Color(nsColor: .systemGray).opacity(0.2)
  }

  func isOnColor(_ configuration: Configuration) -> Color {
    configuration.isOn
    ? foregroundColor.blended(withFraction: 0.25, of: .black)
    : colorScheme == .dark
    ? Color(nsColor: .windowBackgroundColor)
    : Color(nsColor: .systemGray).opacity(0.4)
  }
}

#Preview {
  HStack {
    VStack {
      Toggle(isOn: .constant(true), label: { Text("Switch") })
        .toggleStyle(.switch)
    }

    VStack {
      Toggle(isOn: .constant(true), label: {})
    }
    .toggleStyle(ZenSwitchStyle(style: .regular))
  }
  .padding()
}

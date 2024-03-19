import SwiftUI

public struct ZenCheckbox: View {
  public enum Style {
    case regular
    case small

    var size: CGSize {
      switch self {
      case .regular:
        return CGSize(width: 14, height: 14)
      case .small:
        return CGSize(width: 12, height: 12)
      }
    }

    var fontSize: CGFloat {
      switch self {
      case .regular:
        return 10
      case .small:
        return 8
      }
    }
  }

  @Environment(\.colorScheme) private var colorScheme
  @State var isHovered: Bool = false
  @Binding private var isOn: Bool
  private let config: ZenStyleConfiguration
  private let style: Style
  private let titleKey: String
  private let onChange: (Bool) -> Void

  public init(_ titleKey: String = "",
              style: Style = .regular,
              config: ZenStyleConfiguration = .init(),
              isOn: Binding<Bool>,
              onChange: @escaping (Bool) -> Void = { _ in }) {
    _isOn = isOn
    self.config = config
    self.style = style
    self.titleKey = titleKey
    self.onChange = onChange
  }

  public var body: some View {
    Button(action: {
      isOn.toggle()
      onChange(isOn)
    }, label: {
      RoundedRectangle(cornerRadius: 4, style: .continuous)
        .fill(isOnColor)
        .overlay(content: {
          RoundedRectangle(cornerRadius: 4, style: .continuous)
            .stroke(Color(nsColor: .windowFrameTextColor).opacity(0.2), lineWidth: 1.0)
        })
        .overlay {
          Image(systemName: "checkmark")
            .symbolRenderingMode(.palette)
            .foregroundStyle(checkmarkColor())
            .font(Font.system(size: style.fontSize, weight: .heavy))
            .offset(y: isOn || isHovered ? 0 : -8)
            .opacity(isOn ? 1 : isHovered ? 0.5 : 0)
            .animation(.easeInOut(duration: 0.15), value: isOn)
            .animation(.easeInOut(duration: 0.15), value: isHovered)
        }
        .frame(width: style.size.width, height: style.size.height)
        .onHover(perform: { newValue in
          guard isHovered != newValue else { return }
          isHovered = newValue
        })
      if !titleKey.isEmpty {
        Text(titleKey)
          .frame(alignment: .leading)
      }
    })
    .buttonStyle(.plain)
  }

  private var isOnColor: Color {
    isOn
    ? Color(nsColor: config.color.nsColor.blended(withFraction: 0.2, of: .black)!)
    : colorScheme == .dark ? Color(nsColor: .controlColor) : Color(nsColor: .windowBackgroundColor)
  }

  private func checkmarkColor() -> Color {
    colorScheme == .dark
    ? .white.opacity(0.8)
    : .black.opacity(0.4)
  }
}

struct ZenCheckbox_Previews: PreviewProvider {
  static var systemToggles: some View {
    VStack {
      Toggle(isOn: .constant(true), label: {
        Text("Default on")
      })
      Toggle(isOn: .constant(false), label: {
        Text("Default off")
      })
    }
  }

  static var previews: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .top, spacing: 32) {
        VStack(alignment: .leading) {
          Text("System")
            .font(.headline)
          systemToggles
        }

        VStack(alignment: .leading) {
          Text("Regular").font(.headline)
          ZenCheckbox("Default on", isOn: .constant(true))
          ZenCheckbox("Default off", isOn: .constant(false))
        }

        VStack(alignment: .leading) {
          Text("Small")
            .font(.headline)
          ZenCheckbox("Default on", style: .small, isOn: .constant(true))
            .font(.caption)
          ZenCheckbox("Default off", style: .small, isOn: .constant(false))
            .font(.caption)
        }
      }
    }
    .padding()
  }
}

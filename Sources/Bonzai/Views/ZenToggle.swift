import SwiftUI

public struct ZenToggle: View {
  public enum Style {
    case regular
    case medium
    case small

    var size: CGSize {
      switch self {
      case .regular: CGSize(width: 38, height: 20)
      case .medium: CGSize(width: 34, height: 17)
      case .small:   CGSize(width: 22, height: 12)
      }
    }
  }

  @Environment(\.controlActiveState) var controlActiveState
  @Environment(\.colorScheme) var colorScheme
  @Binding private var isOn: Bool
  @State private var isHovered: Bool
  private let style: Style
  private let titleKey: String
  private let config: ZenStyleConfiguration
  private let onChange: (Bool) -> Void

  public init(_ titleKey: String = "",
       config: ZenStyleConfiguration = .init(color: .systemGreen),
       style: Style = .regular,
       isOn: Binding<Bool>,
       onChange: @escaping (Bool) -> Void = { _ in }) {
    _isOn = isOn
    _isHovered = .init(initialValue: config.hoverEffect.wrappedValue ? false : true)
    self.config = config
    self.style = style
    self.titleKey = titleKey
    self.onChange = onChange
  }

  public var body: some View {
    HStack {
      if !titleKey.isEmpty {
        Text(titleKey)
          .opacity(!titleKey.isEmpty ? 1 : 0)
      }
      Button(action: {
        isOn.toggle()
        onChange(isOn)
      }, label: {
        Capsule()
          .fill(isOnFillColor)
          .overlay(alignment: isOn ? .trailing : .leading, content: {
            Circle()
              .fill(Color(.white))
              .overlay(
                Circle()
                  .stroke(isOnColor, lineWidth: 0.5)
              )
              .padding(1)
              .shadow(radius: 1)
          })
          .overlay {
            Capsule()
              .stroke(Color(nsColor: config.color.nsColor.blended(withFraction: 0.5, of: .black)!), lineWidth: 0.5)
              .opacity(isOn ? 1 : 0)
          }
          .animation(.default, value: isOn)
          .background(
            Capsule()
              .strokeBorder(isOnColor, lineWidth: 1)
          )
          .frame(width: style.size.width, height: style.size.height)
      })
      .grayscale(grayscale())
      .buttonStyle(.plain)
    }
  }

  private func grayscale() -> CGFloat {
    config.grayscaleEffect.wrappedValue ? isHovered ? 0
    : isHovered ? 0.5 : 1
    : controlActiveState == .key ? 0 : 0.4
  }


  var isOnFillColor: Color {
    isOn
    ? Color(nsColor: config.color.nsColor.blended(withFraction: 0.2, of: .black)!)
    : Color(nsColor: .systemGray).opacity(0.2)
  }

  var isOnColor: Color {
    isOn
    ? Color(nsColor: config.color.nsColor.blended(withFraction: 0.25, of: .black)!)
    : colorScheme == .dark
      ? Color(nsColor: .windowBackgroundColor)
    : Color(nsColor: .systemGray).opacity(0.4)
  }
}

struct ZenToggle_Previews: PreviewProvider {
  static var systemToggles: some View {
    VStack {
      Toggle(isOn: .constant(true), label: {
        Text("Default on")
      })
      .tint(Color(.systemGreen))
      Toggle(isOn: .constant(false), label: {
        Text("Default off")
      })
      .tint(Color(.systemGreen))
      Toggle(isOn: .constant(true), label: { })
        .tint(Color(.systemGreen))
    }
  }

  static var previews: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .top, spacing: 32) {
        VStack(alignment: .leading) {
          Text("System")
            .font(.headline)
          Divider()
          systemToggles
            .toggleStyle(.switch)
        }
        .frame(minWidth: 128)

        VStack(alignment: .leading) {
          Text("Regular")
            .font(.headline)
          Divider()
          ZenToggle("Default on",
                    style: .regular,
                    isOn: .constant(true)) { _ in }
          ZenToggle("Default off",
                    style: .regular,
                    isOn: .constant(false)) { _ in }
          ZenToggle("",
                    style: .regular,
                    isOn: .constant(true)) { _ in }
        }
        .frame(minWidth: 128)

        VStack(alignment: .leading) {
          Text("Medium")
            .font(.headline)
          Divider()
          ZenToggle("Default on",
                    style: .medium,
                    isOn: .constant(true)) { _ in }
          ZenToggle("Default off",
                    style: .medium,
                    isOn: .constant(false)) { _ in }
          ZenToggle("",
                    style: .medium,
                    isOn: .constant(true)) { _ in }
        }
        .frame(minWidth: 128)

        VStack(alignment: .leading) {
          Text("Small")
            .font(.headline)
          Divider()
          ZenToggle("Default on", style: .small, isOn: .constant(true)) { _ in }
          ZenToggle("Default off", style: .small, isOn: .constant(false)) { _ in }
          ZenToggle("",
                    style: .small,
                    isOn: .constant(true)) { _ in }
        }
        .frame(minWidth: 128)
      }
    }
    .padding()
  }
}


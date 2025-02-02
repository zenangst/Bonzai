import SwiftUI

public final class WhatsNewPublisher: ObservableObject {
  @Published public var info: WhatsNewView.AppInfo
  @Published public var items: [WhatsNewView.Item] = []

  public init(_ info: WhatsNewView.AppInfo, items: [WhatsNewView.Item]) {
    self.info = info
    self.items = items
  }

  public func publish(_ items: [WhatsNewView.Item]) {
    self.items = items
  }
}

public struct WhatsNewView: View {
  public struct AppInfo {
    let icon: Icon
    let name: String
    let version: String
    let buildNumber: String
  }

  public struct Item: Identifiable {
    public let id: String
    public let symbol: String
    public let name: String
    public let description: String

    public init(id: String, symbol: String, name: String, description: String) {
      self.id = id
      self.symbol = symbol
      self.name = name
      self.description = description
    }
  }
  @State private var didAppear: Bool = false
  @ObservedObject private var publisher: WhatsNewPublisher
  private let onContinue: () -> Void
  private let onReleaseNotes: () -> Void

  public init(_ publisher: WhatsNewPublisher,
              onReleaseNotes: @escaping () -> Void,
              onContinue: @escaping () -> Void) {
    self.publisher = publisher
    self.onReleaseNotes = onReleaseNotes
    self.onContinue = onContinue
  }

  public var body: some View {
    VStack(spacing: 0) {
      VStack(spacing: 0) {
          HStack {
            IconView(icon: publisher.info.icon,
                     size: .init(width: 56, height: 56))
            VStack(alignment: .leading) {
              Group {
                Text("What's New in ")
                + Text(publisher.info.name)
              }
              .fixedSize()
              .font(Font.system(size: 20))
              .fontWeight(.bold)
              .fontDesign(.rounded)
              .allowsTightening(true)
              .minimumScaleFactor(0.9)

              Group {
                Text("Version: ") + Text(publisher.info.version).bold()
              }
              .font(Font.system(size: 14))
            }
            .frame(maxWidth: 350, alignment: .leading)
          }
      }
      .frame(maxWidth: .infinity)
      .padding(.horizontal)
      .padding(.top, 16)
      .padding(.bottom, 24)
      .background(ArrowBackgroundView()
        .ignoresSafeArea(.all)
      )

      ScrollView(.vertical) {
        VStack {
          let enumerated = Array(zip(publisher.items.indices, publisher.items))
          ForEach(enumerated, id: \.0.self) { offset, item in
            let baseAnimationDuration: TimeInterval = 0.3
            let delay = TimeInterval(offset) * (baseAnimationDuration - 0.15)
            WhatsNewItemView(item: item)
              .padding(4)
              .frame(maxWidth: 400, alignment: .leading)
              .transition(
                .asymmetric(
                  insertion: 
                      .scale(scale: 0.1, anchor: .leading)
                      .combined(with: .opacity)
                      .animation(.smooth(duration: baseAnimationDuration).delay(delay))
                  ,
                  removal: .scale(scale: 0.1)
                )
                .animation(.easeInOut)
              )
          }
        }
        .frame(maxWidth: .infinity)
      }
      .frame(minHeight: 320)
      .background(alignment: .leading, content: {
        HStack(spacing: 0) {
          Rectangle()
            .fill(Color.accentColor)
            .frame(width: didAppear ? 10 : 0)
            .opacity(didAppear ? 1 : 0)
          Rectangle()
            .fill(Color.accentColor)
            .opacity(0.75)
            .frame(width: didAppear ? 10 : 0)
            .opacity(didAppear ? 1 : 0)
          Rectangle()
            .fill(Color.accentColor)
            .opacity(0.5)
            .frame(width: didAppear ? 10 : 0)
            .opacity(didAppear ? 1 : 0)
          Rectangle()
            .fill(Color.accentColor)
            .opacity(0.25)
            .frame(width: didAppear ? 10 : 0)
            .opacity(didAppear ? 1 : 0)
        }
        .animation(.bouncy(duration: 2, extraBounce: 0.2).delay(0.4), value: didAppear)
      })
      .background(Color(nsColor: .underPageBackgroundColor))
      .clipShape(RoundedRectangle(cornerRadius: 8))
      .background(
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color(nsColor: .controlColor), lineWidth: 1)
      )
      .padding()

      HStack {
        Button("Release notes", action: {})
        Spacer()
        Button("Continue", action: {})
      }
      .padding(.horizontal, 24)
      .padding(.bottom, 18)
    }
    .onAppear {
      didAppear = true
    }
    .background()
  }
}

private struct WhatsNewItemView: View {
  @State private var didAppear: Bool = false
  private let item: WhatsNewView.Item

  init(item: WhatsNewView.Item) {
    self.item = item
  }

  var body: some View {
    HStack(alignment: .top, spacing: 16) {
      Rectangle()
        .fill(
          LinearGradient(stops: stops(), startPoint: startPoint(), endPoint: endPoint())
        )
        .animation(.smooth(duration: 2).repeatForever(),
                   value: didAppear)
        .aspectRatio(contentMode: .fit)
        .frame(width: 32)
        .mask {
          Image(systemName: item.symbol)
            .resizable()
            .aspectRatio(contentMode: .fit)
        }
        .padding(.top, 8)

      VStack(alignment: .leading) {
        Text(item.name)
          .font(.title2)
          .bold()
          .foregroundStyle(Color.primary)
        Text(item.description)
      }
      .frame(alignment: .leading)
      .padding(4)
    }
    .padding(.vertical, 8)
    .onAppear {
      didAppear = true
    }
  }

  func startPoint() -> UnitPoint { didAppear ? .topLeading : .topTrailing }
  func endPoint() -> UnitPoint { didAppear ? .bottom : .leading }

  func stops() -> [Gradient.Stop] {
    didAppear
    ? [
      .init(color: Color.primary, location: 0.1),
      .init(color: Color(nsColor: .controlAccentColor.withSystemEffect(.pressed)), location: 0.2),
      .init(color: Color.accentColor, location: 0.7),
      .init(color: Color(nsColor: .controlAccentColor.withSystemEffect(.disabled)), location: 1.0),
    ]
    : [
      .init(color: Color(nsColor: .controlAccentColor.withSystemEffect(.disabled)), location: 0.0),
      .init(color: Color.accentColor, location: 1.0),
    ]
  }
}

struct WhatsNewView_Previews: PreviewProvider {
  static let items: [WhatsNewView.Item] = [
    .init(
      id: UUID().uuidString,
      symbol: "newspaper.fill",
      name: "What's New Screen",
      description: "This screen here is new!"
    ),
    .init(
      id: UUID().uuidString,
      symbol: "filemenu.and.selection",
      name: "Menubar improvments",
      description: "We cleaned up the menubar and added new menus items for adding configurations, groups and workflows"
    ),
    .init(
      id: UUID().uuidString,
      symbol: "text.alignleft",
      name: "Typing commands",
      description: "Adds support for selected text when runing typing commands"
    ),
    .init(
      id: UUID().uuidString,
      symbol: "app.badge",
      name: "Notifications",
      description: "You can now configure notifications when running commands"
    ),
    .init(
      id: UUID().uuidString,
      symbol: "uiwindow.split.2x1",
      name: "New features in Window Commands",
      description: "Adds support for padding when using move & increase size window commands"
    ),
    .init(
      id: UUID().uuidString,
      symbol: "tree.circle",
      name: "UI Improvements",
      description: "Migrated to the new Bonzai repository"
    )
  ]

  static var info: WhatsNewView.AppInfo = .init(
    icon: Icon(bundleIdentifier: "com.apple.Finder", path: "/System/Library/CoreServices/Finder.app"),
    name: "Keyboard Cowboy",
    version: "3.16.2",
    buildNumber: "276"
  )

  static var publisher = WhatsNewPublisher(info, items: [])

  static var previews: some View {
    WhatsNewView(publisher,
                 onReleaseNotes: {},
                 onContinue: {})
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        publisher.publish(Self.items)
      }
    }
    .previewLayout(.sizeThatFits)
  }
}

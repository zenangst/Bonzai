import Combine
import SwiftUI

public struct IconView: View {
  let icon: Icon
  let size: CGSize

  public init(icon: Icon, size: CGSize) {
    self.icon = icon
    self.size = size
  }

  public var body: some View {
    InternalIconView(icon, size: size) { phase in
      if case .success(let image) = phase {
        image
          .resizable()
      } else {
        RoundedRectangle(cornerRadius: 4)
          .fill(Color.clear)
      }
    }
    .aspectRatio(contentMode: .fill)
    .frame(width: size.width, height: size.height)
    .fixedSize()
    .drawingGroup()
  }
}

struct IconView_Previews: PreviewProvider {
  static var previews: some View {
    IconView(icon: .init(bundleIdentifier: "com.apple.finder.",
                         path: "/System/Library/CoreServices/Finder.app"),
             size: .init(width: 32, height: 32))
  }
}

fileprivate final class IconLoader: ObservableObject {
  @MainActor
  @Published var phase = AsyncImagePhase.empty

  private var task: Task<(), Error>? {
    willSet {
      self.task?.cancel()
    }
  }
  private let icon: Icon

  init(_ icon: Icon) {
    self.icon = icon
  }

  deinit {
    task?.cancel()
  }

  @MainActor
  func load(with size: CGSize) {
    task = Task {
      if let nsImage = await IconCache.shared.image(for: icon, size: size) {
        phase = .success(Image(nsImage: nsImage))
      } else {
        await internalLoad(size)
      }
    }
  }

  private func internalLoad(_ size: CGSize) async {
    self.task?.cancel()
    guard let nsImage = await IconCache.shared.image(for: icon, size: size)
    else { return }

    let image = Image(nsImage: nsImage)
    await MainActor.run {
      phase = .success(image)
    }
  }
}

fileprivate struct InternalIconView<Content>: View where Content: View {
  @ObservedObject var loader: IconLoader
  @ViewBuilder private var content: (AsyncImagePhase) -> Content
  private let size: CGSize

  init(_ icon: Icon,
       size: CGSize,
       @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
    _loader = .init(wrappedValue: IconLoader(icon))
    self.size = size
    self.content = content
  }

  var body: some View {
    content(loader.phase)
      .onAppear {
        loader.load(with: size)
      }
  }
}

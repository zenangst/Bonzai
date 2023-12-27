import Cocoa
import Foundation
import Combine

public final class ZenWindowManager: ObservableObject {
  private let passthrough = PassthroughSubject<Void, Never>()
  private var subscription: AnyCancellable?
  weak var window: NSWindow?

  init(subscription: AnyCancellable? = nil, window: NSWindow? = nil) {
    self.subscription = subscription
    self.window = window
  }

  public func cancelClose() {
    subscription?.cancel()
  }

  public func close() {
    window?.close()
  }

  public func close(after stride: DispatchQueue.SchedulerTimeType.Stride,
                    then: @escaping @MainActor @Sendable () -> Void = {}) {
    subscription = passthrough
      .debounce(for: stride, scheduler: DispatchQueue.main)
      .sink {
        Task {
          await then()
        }
      }
    passthrough.send()
  }
}

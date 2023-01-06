import SwiftUI
import Cocoa

@main
struct ClickToLookUpApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        MenuBarExtra("Click to Look Up App", systemImage: "character.book.closed.fill") {
            Button("Quit Click to Look Up") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }
    }
}

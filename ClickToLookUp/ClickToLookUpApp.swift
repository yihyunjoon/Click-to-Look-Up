import SwiftUI
import Cocoa

@main
struct ClickToLookUpApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let appName = "Click to Look Up"

    var body: some Scene {
        MenuBarExtra("\(appName) App", systemImage: "character.book.closed.fill") {
            Button("About \(appName)") {
                NSApp.orderFrontStandardAboutPanel()
                NSApp.activate(ignoringOtherApps: true)
            }
            Button("Settings...") {
                NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
                NSApp.activate(ignoringOtherApps: true)
            }.keyboardShortcut(",")
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }
        Settings {
            SettingsView()
        }
    }
}

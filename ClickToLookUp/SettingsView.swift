import SwiftUI
import LaunchAtLogin

struct SettingsView: View {
    var body: some View {
        VStack {
            LaunchAtLogin.Toggle {
                Text("Launch at login")
            }
        }
        .padding(20)
        .frame(width: 300, height: 150)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

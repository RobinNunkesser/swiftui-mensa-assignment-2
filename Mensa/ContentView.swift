import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection){
            MensaView().tag(0).tabItem {
                Image(systemName: "1.square.fill")
                Text("First")
            }
            SettingsView().tag(1).tabItem {
                Image(systemName: "2.square.fill")
                Text("Second")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

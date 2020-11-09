import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
           ClockView()
             .tabItem {
                Image(systemName: "deskclock")
                Text("Clock")
              }
            Text("The content of the Stats view")
              .tabItem {
                 Image(systemName: "bolt")
                 Text("Stats")
               }
            Text("The content of the MapView view")
            .tabItem {
                Image(systemName: "map")
                Text("Map")
            }
            Text("The content of the Settings view")
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

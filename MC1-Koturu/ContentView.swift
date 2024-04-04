//
//  ContentView.swift
//  MC1-Koturu
//
//  Created by Timothy Andrian on 01/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tabs = .home
    
    enum Tabs {
        case home
        case sleep
        case catalog
        case settings
    }
    var body: some View {
        TabView(selection: $selection) {
            HomePage().tabItem {
                Label("Beranda", image: "navBean")
            }.tag(Tabs.home)
            SleepPage().tabItem {
                Label("Tidur", image: "navSleep")
            }.tag(Tabs.sleep)
            CatalogPage().tabItem {
                Label("Katalog", image: "navCatalog")
            }.tag(Tabs.catalog)
            SettingPage().tabItem {
                Label("Pengaturan", image: "navSetting")
            }.tag(Tabs.settings)
        }
        .tint(.third)
        .toolbarBackground(.second, for: .tabBar)
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}


//import SwiftUI

//struct ContentView: View {
//    @State private var selection: Tabs = .catalog
//    
//    enum Tabs {
//        case home
//        case sleep
//        case catalog
//        case settings
//    }
//    
//    var body: some View {
//        TabView(selection: $selection) {
//            SleepPage().tabItem {
//                Label("Tidur", systemImage: "moon.zzz")
//            }.tag(Tabs.sleep)
//            
//            CatalogPage().tabItem {
//                Label("Katalog", systemImage: "list.dash")
//            }.tag(Tabs.catalog)
//        }
//    }
//}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


//
//  ContentView.swift
//  MC1-Koturu
//
//  Created by Timothy Andrian on 01/04/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        MainTabView().preferredColorScheme(.dark)
//        TabView(selection: $selection) {
//            HomePage().tabItem { Image("bean-nav")}
//            SleepPage().tabItem { Image("bean-nav") }
//            CatalogPage().tabItem { Image("bean-nav")}
//            ProfilePage().tabItem { Image("bean-nav") }
//        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  MC1-Koturu
//
//  Created by Timothy Andrian on 01/04/24.
//

import SwiftUI

struct ContentView: View {    
    @State private var selection: Tabs = .home
    @State private var personal: Personalized
    @State private var dailySleep: [DailySleep]
    @State private var defaultBaverages: [DefaultBaverage]
    @State private var customBaverages: [CustomBaverage]
    
    let homePage: String = "Beranda"
    let sleepPage: String = "Tidur"
    let catalogPage: String = "Katalog"
    let settingPage: String = "sPengaturan"
    
    enum Tabs {
        case home
        case sleep
        case catalog
        case settings
    }
    
    init() {
        _personal = State(initialValue: personalizedTemplate)
        _dailySleep = State(initialValue: dailySleepsTemplate)
        _defaultBaverages = State(initialValue: defaultBavearagesTemplate)
        _customBaverages = State(initialValue: customBavearagesTemplate)
    }
    
    var body: some View {
        TabView(selection: $selection) {
            HomePage(data: $personal).tabItem {
                Label(homePage, image: "navBean")
            }.tag(Tabs.home)
                .onAppear(perform: {
                    refreshData(page: homePage)
                })
            SleepPage(data: $dailySleep).tabItem {
                Label(sleepPage, image: "navSleep")
            }.tag(Tabs.sleep)
                .onAppear(perform: {
                    refreshData(page: sleepPage)
                })
            CatalogPage(dataPersonal: $personal, dataCustom: $customBaverages, dataDefault: $defaultBaverages).tabItem {
                Label(catalogPage, image: "navCatalog")
            }.tag(Tabs.catalog)
                .onAppear(perform: {
                    refreshData(page: catalogPage)
                })
            SettingPage(data: $personal).tabItem {
                Label(settingPage, image: "navSetting")
            }.tag(Tabs.settings)
                .onAppear(perform: {
                    refreshData(page: settingPage)
                })
        }
        .tint(.third)
        .toolbarBackground(.second, for: .tabBar)
        .preferredColorScheme(.light)
    }
    
    // Refresh Data From Local File
    func refreshData(page: String) {
        switch page {
        case sleepPage:
            self.dailySleep = loadLocalFile(fileDailySleeps)
        case catalogPage:
            self.personal = loadLocalFile(filePersonalized)
            self.defaultBaverages = loadLocalFile(fileDefaultBaverages)
            self.customBaverages = loadLocalFile(fileCustomBaverages)
        case settingPage:
            self.personal = loadLocalFile(filePersonalized)
        default:
            self.personal = loadLocalFile(filePersonalized)
            self.defaultBaverages = loadLocalFile(fileDefaultBaverages)
            self.customBaverages = loadLocalFile(fileCustomBaverages)
            self.dailySleep = loadLocalFile(fileDailySleeps)
        }
    }
}

#Preview {
    ContentView()
}

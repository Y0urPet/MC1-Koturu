//
//  MainTabView.swift
//  MC1-Koturu
//
//  Created by Timothy Andrian on 02/04/24.
//

import SwiftUI

enum TabbedItems: Int, CaseIterable{
    case home = 0
    case sleep
    case catalog
    case profile
    
    var iconName: String{
        switch self {
        case .home:
            return "bean-nav"
        case .sleep:
            return "sleep-nav"
        case .catalog:
            return "catalog-nav"
        case .profile:
            return "profile-nav"
        }
    }
}

struct MainTabView: View {
    
    @State var selectedTab = 0
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            switch self.selectedTab {
                case 0:
                    HomePage()
                case 1:
                    SleepPage()
                case 2:
                    CatalogPage()
                case 3:
                    ProfilePage()
                default:
                    HomePage()
            }
            
            ZStack{
                HStack{
                    ForEach((TabbedItems.allCases), id: \.self){ item in
                        Button{
                            selectedTab = item.rawValue
                        } label: {
                            CustomTabItem(imageName: item.iconName, isActive: (selectedTab == item.rawValue))
                        }
                    }
                }
                .padding(6)
            }
            .frame(height: 70)
            .background(.second.opacity(1))
            .cornerRadius(25)
            .padding(.horizontal, 26)
        }
    }
}

extension MainTabView{
    func CustomTabItem(imageName: String, isActive: Bool) -> some View{
        HStack(spacing: 10){
            Spacer()
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .third : .third.opacity(0.3))
                .frame(width: 25, height: 25)

            Spacer()
        }
//        .frame(width: 60.0, height: 60.0)
//        .background(isActive ? .second.opacity(0.4) : .clear)
//        .cornerRadius(30)
    }
}

#Preview {
    MainTabView()
}

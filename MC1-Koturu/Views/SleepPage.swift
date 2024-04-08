//
//  SleepPage.swift
//  MC1-Koturu
//
//  Created by Timothy Andrian on 04/04/24.
//

import SwiftUI
import Charts

struct SleepPage: View {
    @Binding private var dailySleep: [DailySleep]
    
    init(data: Binding<[DailySleep]>) {
        _dailySleep = data
    }
    
    private func calculateSleepPoint(data: [DailySleep]) -> Int {
        var count: Int = 0
        for temp in data {
            count += temp.point
        }
        return count
    }

    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    VStack(spacing:20) {
                        HStack(spacing: 175) {
                            VStack(alignment:.leading) {
                                Text("Tidur").font(.system(size: 32)).fontWeight(.bold)
                                    .foregroundStyle(.second)
                                Text("Nilai Tidur").font(.system(size: 32)).fontWeight(.bold)
                                    .foregroundStyle(.second)
                            }
                            Rectangle().frame(width: 20,height: 20).foregroundStyle(.third)
                        }.padding(.top, 50)
                        HStack(spacing:20) {
                            VStack(alignment: .leading) {
                                HStack(spacing: 165) {
                                    VStack(alignment: .leading) {
                                        Text("Rata - rata Kualiatas Tidur")
                                            .font(.system(size: 12))
                                            .foregroundStyle(.prime)
                                            .fontWeight(.regular)
                                        Text("Senang")
                                            .font(.system(size: 16))
                                            .foregroundStyle(.prime)
                                            .fontWeight(.bold)
                                    }
                                }
                                HStack(spacing:20) {
                                    Chart(dailySleep) {sleep in
                                        BarMark(
                                            x: .value("Shape Type", sleep.day),
                                            y: .value("Total Count", sleep.point),
                                            width: .fixed(16)
                                        )
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .foregroundStyle(.second)
                                        
                                    }
                                    .frame(width: 180,height: 100)
                                    .chartScrollableAxes(.horizontal)
                                    .chartXVisibleDomain(length: Int(UIScreen.main.bounds.width / 50))
                                    .chartYAxis(.hidden)
                                    
                                    switch calculateSleepPoint(data: dailySleep) {
                                    case 1..<35:
                                        Image(systemName: "battery.25percent")
                                            .resizable()
                                            .frame(width: 60, height: 30)
                                            .foregroundColor(.cupcolor)
                                    case 35:
                                        Image(systemName: "battery.50percent")
                                            .resizable()
                                            .frame(width: 60, height: 30)
                                            .foregroundColor(.cupcolor)
                                    case 42...56:
                                        Image(systemName: "battery.75percent")
                                            .resizable()
                                            .frame(width: 60, height: 30)
                                            .foregroundColor(.cupcolor)
                                    case 63...70:
                                        Image(systemName: "battery.100percent")
                                            .resizable()
                                            .frame(width: 60, height: 30)
                                            .foregroundColor(.cupcolor)
                                    default:
                                        Image(systemName: "battery.0percent")
                                            .resizable()
                                            .frame(width: 60, height: 30)
                                            .foregroundColor(.cupcolor)
                                    }
                                }
                            }
                            Image(systemName:"chevron.right").resizable().frame(width: 7.2, height: 12).foregroundStyle(.prime)
                        }.padding()
                            .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                        HStack(spacing: 140){
                            Text("Analisa Kesehatan").font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundStyle(.second)
                            Rectangle().frame(width: 20,height: 20).foregroundStyle(.third)
                        }
                        VStack {
                            HStack(spacing: 140){
                                VStack(alignment: .leading) {
                                    Text("Detak jantung saat istirahat").font(.system(size: 12))
                                        .fontWeight(.regular)
                                    .foregroundStyle(.second)
                                    HStack {
                                        Image("batas").resizable().frame(width: 12.5, height: 11.5)
                                        Text("--").font(.system(size: 12))
                                            .fontWeight(.regular)
                                    }
                                }
                                Image(systemName:"chevron.right").resizable().frame(width: 7.2, height: 12).foregroundStyle(.prime)
                            }.padding(.bottom, 5).overlay(Divider().background(.second), alignment: .bottom)
                            HStack(spacing: 225){
                                VStack(alignment: .leading) {
                                    Text("Durasi Tidur").font(.system(size: 12))
                                        .fontWeight(.regular)
                                    .foregroundStyle(.second)
                                    HStack {
                                        Image("kasur").resizable().frame(width: 12.5, height: 8.75)
                                        Text("--").font(.system(size: 12))
                                            .fontWeight(.regular)
                                    }
                                }
                                Image(systemName:"chevron.right").resizable().frame(width: 7.2, height: 12).foregroundStyle(.prime)
                            }
                        }.padding()
                            .background(.white)
                        .clipShape(.rect(
                            topLeadingRadius: 12,
                            bottomLeadingRadius: 12, 
                            bottomTrailingRadius: 12,
                            topTrailingRadius: 12
                            
                        ))
                        Rectangle().frame(height: 100)
                            .position(x:geo.size.width/2,y:+223).foregroundStyle(.second)
                    }
                }
            }.background(.third)
        }.toolbarBackground(.second, for: .tabBar)
    }
}

#Preview {
    SleepPage(data: getDailySleepsData())
}

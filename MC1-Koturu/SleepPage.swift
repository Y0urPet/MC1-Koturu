//
//  SleepPage.swift
//  MC1-Koturu
//
//  Created by Timothy Andrian on 04/04/24.
//

import SwiftUI
import Charts

struct SleepPage: View {
    var data: [dailySleepCount] = [
        .init(type: "Senin", count: 1),
        .init(type: "Selasa", count:1),
        .init(type: "Rabu", count: 1),
        .init(type: "Kamis", count: 1),
        .init(type: "Jumat", count: 1),
        .init(type: "Sabtu", count: 1),
        .init(type: "Minggu", count: 5),
    ]
    
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
                                    Chart(data) { data in
                                        BarMark(
                                            x: .value("Shape Type", data.type),
                                            y: .value("Total Count", data.count),
                                            width: .fixed(16)
                                        )
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .foregroundStyle(.second)
                                        
                                    }
                                    .frame(width: 180,height: 100)
                                    .chartScrollableAxes(.horizontal)
                                    .chartXVisibleDomain(length: Int(UIScreen.main.bounds.width / 50))
                                .chartYAxis(.hidden)
                                    Image("bxs_smile").resizable().frame(width: 82, height: 82)
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

struct dailySleepCount: Identifiable {
    var type: String
    var count: Double
    var id = UUID()
}

#Preview {
    SleepPage()
}

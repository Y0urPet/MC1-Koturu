//
//  HomePage.swift
//  MC1-Koturu
//
//  Created by Timothy Andrian on 01/04/24.
//

import SwiftUI
import Charts

struct HomePage: View {
    @Binding private var personalData: Personalized
    
    @State var totalCaffeine = 0
    @State var isOverLimiting = false
        
    var data: [dailyDrinkCount] = [
        .init(type: "Senin", count: 1),
        .init(type: "Selasa", count:5),
        .init(type: "Rabu", count: 1),
        .init(type: "Kamis", count: 1),
        .init(type: "Jumat", count: 1),
        .init(type: "Sabtu", count: 1),
        .init(type: "Minggu", count: 1),
    ]
    
    init(data: Binding<Personalized>) {
        _personalData = data
    }
            
    var body: some View {
        VStack {
            NavigationView {
                GeometryReader { geo in
                    ZStack {
                        Image("beanBackground")
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                VStack {
                                    Text("Kandungan Kafein dalam Tubuh")
                                        .font(.system(size: 14))
                                        .fontWeight(.regular)
                                        .foregroundStyle(.second)
                                    VStack (spacing: 15){
                                        Text("\(totalCaffeine)mg/\(personalData.maxDailyCaffeine)")
                                            .font(.system(size: 32))
                                            .fontWeight(.black)
                                            .foregroundStyle(.second)
                                            .padding(.bottom, 0)
                                        HStack{
                                            Text("Tersisa 10 jam")
                                                .font(.system(size: 14))
                                                .fontWeight(.bold)
                                                .padding(.top, 5)
                                                .padding(.bottom, 5)
                                                .padding(.leading, 25)
                                                .padding(.trailing, 25)
                                                .background(.second)
                                                .foregroundStyle(.third)
                                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                            Image(systemName: "info.circle.fill")
                                                .resizable()
                                                .frame(width: 20,height: 20)
                                                .foregroundStyle(.info)
                                        }
                                    }
                                }.padding(.bottom, 30)
                                    .padding(.top, 50)
                                
                                VStack(spacing: 30) {
                                    // Daftar Minuman
                                    VStack {
                                        VStack() {
                                            HStack(spacing: 160) {
                                                Text("Daftar Minuman")
                                                    .font(.system(size: 20))
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.prime)
                                                NavigationLink(destination: InputCaffeineForm(data: $personalData), label: {
                                                    Image(systemName: "plus")
                                                        .resizable()
                                                        .frame(width: 21,height: 21)
                                                        .foregroundStyle(.prime)
                                                })
                                            }
                                            HStack(spacing: 100){
                                                VStack(alignment: .leading,spacing: 5){
                                                    Text("Kapal Api")
                                                        .font(.system(size: 16))
                                                        .fontWeight(.bold)
                                                        .foregroundStyle(.prime)
                                                        .frame(width: 150, alignment: .leading)
                                                    Text("60mg kafein")
                                                        .font(.system(size: 12))
                                                        .fontWeight(.regular)
                                                        .foregroundStyle(.prime)
                                                }
                                                Image("inputCoffee").resizable().frame(width: 50,height: 50).onTapGesture {
                                                    if totalCaffeine < 400 {
                                                        totalCaffeine += 60
                                                    } else {
                                                        isOverLimiting = true
                                                    }
                                                }.alert(isPresented: $isOverLimiting, content: {
                                                    Alert(title: Text("You drink too much coffee!"))
                                                })
                                            }
                                            .padding()
                                            .background(.white)
                                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                                        }
                                    }
                                    
                                    // Minuman Terakhir
                                    VStack {
                                        HStack(spacing: 145) {
                                            VStack(alignment: .leading) {
                                                Text("Terakhir Diminum")
                                                    .font(.system(size: 20))
                                                    .fontWeight(.bold)
                                                .foregroundStyle(.prime)
                                                Text("1 April")
                                            }
                                            Rectangle().frame(width: 21,height: 21).foregroundStyle(.third)
                                        }
                                        VStack() {
                                            // untuk kasus minum kopi dibawah 1 jam
                                            HStack(spacing: 30){
                                                VStack(alignment: .leading,spacing: 5){
                                                    Text("Kapal Api")
                                                        .font(.system(size: 16))
                                                        .fontWeight(.bold)
                                                        .foregroundStyle(.prime)
                                                        .frame(width: 150, alignment: .leading)
                                                    HStack {
                                                        Text("Dibawah 1 jam yang lalu")
                                                            .font(.system(size: 12))
                                                            .fontWeight(.regular)
                                                            .foregroundStyle(.prime)
                                                            .frame(width: 135, alignment: .leading)
                                                        
                                                        Text("1 Bungkus")
                                                            .font(.system(size: 12))
                                                            .fontWeight(.regular)
                                                            .foregroundStyle(.prime)
                                                            .frame(width: 70,height: 20, alignment: .center)
                                                            .background(.fourth)
                                                            .clipShape(RoundedRectangle(cornerRadius: 6))
                                                    }
                                                }
                                                Text("60mg")
                                                    .font(.system(size: 16))
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.prime)
                                                    .frame(width: 60,alignment: .trailing)
                                            }
                                            .padding()
                                            .background(.white)
                                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                                            
                                            // kasus kopi setelah 1 jam
                                            HStack(spacing: 80){
                                                VStack(alignment: .leading,spacing: 5){
                                                    Text("Kapal Api")
                                                        .font(.system(size: 16))
                                                        .fontWeight(.bold)
                                                        .foregroundStyle(.prime)
                                                        .frame(width: 150, alignment: .leading)
                                                    HStack {
                                                        Text("1 jam yang lalu")
                                                            .font(.system(size: 12))
                                                            .fontWeight(.regular)
                                                            .foregroundStyle(.prime)
                                                            .frame(width: 85, alignment: .leading)
                                                        
                                                        Text("1 Bungkus")
                                                            .font(.system(size: 12))
                                                            .fontWeight(.regular)
                                                            .foregroundStyle(.prime)
                                                            .frame(width: 70,height: 20, alignment: .center)
                                                            .background(.fourth)
                                                            .clipShape(RoundedRectangle(cornerRadius: 6))
                                                    }
                                                }
                                                Text("60mg")
                                                    .font(.system(size: 16))
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.prime)
                                                    .frame(width: 60,alignment: .trailing)
                                            }
                                            .padding()
                                            .background(.white)
                                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                                            
                                            // kasus kopi setelah 24 jam
                                            HStack(spacing: 80){
                                                VStack(alignment: .leading,spacing: 5){
                                                    Text("Kapal Api")
                                                        .font(.system(size: 16))
                                                        .fontWeight(.bold)
                                                        .foregroundStyle(.prime)
                                                        .frame(width: 150, alignment: .leading)
                                                    HStack {
                                                        Text("1 hari yang lalu")
                                                            .font(.system(size: 12))
                                                            .fontWeight(.regular)
                                                            .foregroundStyle(.prime)
                                                            .frame(width: 85, alignment: .leading)
                                                        
                                                        Text("1 Bungkus")
                                                            .font(.system(size: 12))
                                                            .fontWeight(.regular)
                                                            .foregroundStyle(.prime)
                                                            .frame(width: 70,height: 20, alignment: .center)
                                                            .background(.fourth)
                                                            .clipShape(RoundedRectangle(cornerRadius: 6))
                                                    }
                                                }
                                                Text("60mg")
                                                    .font(.system(size: 16))
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.prime)
                                                    .frame(width: 60,alignment: .trailing)
                                            }
                                            .padding()
                                            .background(.white)
                                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                                        }
                                    }
                                    // Konsumsi Kafein
                                    VStack {
                                        HStack(spacing: 150) {
                                            Text("Konsumsi Kafein")
                                                .font(.system(size: 20))
                                                .fontWeight(.bold)
                                                .foregroundStyle(.prime)
                                            Rectangle().frame(width: 21,height: 21).foregroundStyle(.third)
                                        }
                                        VStack {
                                            HStack(spacing: 165) {
                                                VStack(alignment: .leading) {
                                                    Text("Total")
                                                        .font(.system(size: 12))
                                                        .foregroundStyle(.prime)
                                                        .fontWeight(.regular)
                                                    Text("120mg")
                                                        .font(.system(size: 16))
                                                        .foregroundStyle(.prime)
                                                        .fontWeight(.bold)
                                                }
                                                
                                                VStack(alignment: .trailing) {
                                                    Text("Daily Average")
                                                        .font(.system(size: 12))
                                                        .foregroundStyle(.prime)
                                                        .fontWeight(.regular)
                                                    Text("120mg")
                                                        .font(.system(size: 16))
                                                        .foregroundStyle(.prime)
                                                        .fontWeight(.bold)
                                                }
                                            }
                                            Chart(data) { data in
                                                BarMark(
                                                    x: .value("Shape Type", data.type),
                                                    y: .value("Total Count", data.count),
                                                    width: .fixed(16)
                                                )
                                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                                .foregroundStyle(.prime)
                                                
                                            }
                                            .frame(width: 270,height: 100)
                                            .chartScrollableAxes(.horizontal)
                                            .chartXVisibleDomain(length: Int(UIScreen.main.bounds.width / 100))
                                            .chartYAxis(.hidden)
                                        }
                                        .padding()
                                        .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    }
                                }
                                Rectangle().foregroundStyle(.second).frame(height: 110).ignoresSafeArea().offset(y:100)
                            }
                        }
                    }
                }
                .background(.third)
            }
        }.toolbarBackground(.second, for: .tabBar)
    }
}

struct dailyDrinkCount: Identifiable {
    var type: String
    var count: Double
    var id = UUID()
}

#Preview {
    HomePage(data: getPersonalData())
}

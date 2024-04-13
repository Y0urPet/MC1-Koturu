//
//  SettingPage.swift
//  MC1-Koturu
//
//  Created by Timothy Andrian on 04/04/24.
//

import SwiftUI

struct SettingPage: View {
    @Binding var personalData: Personalized    
    
    let choice = ["100", "200", "300", "400", "500", "600", "700"]
    let choiceEfek = ["4", "5", "6", "7", "8"]
        
    @State var date = Date()
    @State private var selection: String = ""
    @State private var selectionEfek: String = ""
    @State private var sleepTime: String = ""
    
    // Init Data
    init(data: Binding<Personalized>) {
        _personalData = data
        _selection = State(initialValue: String(personalData.maxDailyCaffeine))
        _selectionEfek = State(initialValue: String(personalData.maxCaffeineEffect))
        _sleepTime = State(initialValue: personalData.sleepTime)
    }

        
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    VStack(spacing:20) {
                        Text("Pengaturan Pribadi").font(.system(size: 24)).fontWeight(.black).foregroundStyle(.second)
                        
                        HStack(spacing: 90) {
                            HStack {
                                Image("kasur").resizable().frame(width: 33, height: 24)
                                VStack(alignment: .leading) {
                                    Text("Waktu Tidur").font(.system(size: 14)).foregroundStyle(.second).fontWeight(.semibold).frame(width: 130, alignment: .leading)
                                    Text("Waktu tidur anda").font(.system(size: 12)).foregroundStyle(.second).fontWeight(.regular)
                                        .frame(width: 130,alignment: .leading)
                                    
                                }
                            }
                            DatePicker("", selection: formattedTime, displayedComponents: .hourAndMinute).frame(width: 70)
                                .tint(.prime)
                        }
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        HStack(spacing: 30) {
                            HStack {
                                Image("batas").resizable().frame(width: 30, height: 27.5)
                                VStack(alignment: .leading) {
                                    Text("Batas kafein harian anda").font(.system(size: 14)).foregroundStyle(.second).fontWeight(.semibold).frame(width: 165,alignment: .leading)
                                    Text("Asupan kafein harian maksimum tanpa efek kesehatan yang negatif.").font(.system(size: 12)).foregroundStyle(.second).fontWeight(.regular).frame(width: 135,alignment: .leading)
                                    
                                }
                            }
                            Picker("Masa Efek Kafein", selection: $selection) {
                                ForEach(choice, id: \.self) {
                                    Text($0 + "mg")
                                }
                            }.tint(.prime)
                        }
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        HStack(spacing: 70) {
                            HStack {
                                Image("kasur").resizable().frame(width: 33, height: 24)
                                VStack(alignment: .leading) {
                                    Text("Masa Efek Kafein").font(.system(size: 14)).foregroundStyle(.second).fontWeight(.semibold).frame(width: 115,alignment: .leading)
                                    Text("Waktu yang dibutuhkan untuk menghilangkan setengah dari kafein di tubuhmu.").font(.system(size: 12)).foregroundStyle(.second).fontWeight(.regular).frame(width: 135,alignment: .leading)
                                }
                            }
                            Picker("Masa Efek Kafein", selection: $selectionEfek) {
                                ForEach(choiceEfek, id: \.self) {
                                    Text($0 + " jam")
                                }
                            }
                            .tint(.prime)
                        }
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        Button {
                            // Action If Any Updated Data
                            if selection != String(personalData.maxDailyCaffeine) || selectionEfek != String(personalData.maxCaffeineEffect) || sleepTime != personalData.sleepTime {
                                updateData(maxDailyCaffeine: $selection, maxCaffeineEffect: $selectionEfek, sleepTime: $sleepTime, isSaving: true)
                            }

                        } label: {
                            Text("Simpan").foregroundStyle(.white).font(.system(size: 14)).fontWeight(.bold)
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        .padding(.leading, 153)
                        .padding(.trailing, 153)
                        .background(.second)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                    }
                    .padding(.bottom, 200)
                                        
                    Rectangle().frame(height: 100)
                        .position(x:geo.size.width/2,y:+750).foregroundStyle(.second)
                }
            }.background(.third)
        }.toolbarBackground(.second, for: .tabBar)
    }
    
    // Update Data on Resouces
    private func updateData(maxDailyCaffeine: Binding<String>, maxCaffeineEffect: Binding<String>, sleepTime: Binding<String>, isSaving: Bool) {
        if isSaving {
            if let maxDailyCaffeineInt = Int(maxDailyCaffeine.wrappedValue),
               let maxCaffeineEffectInt = Int(maxCaffeineEffect.wrappedValue) {
                            save(Personalized(
                                maxDailyCaffeine: maxDailyCaffeineInt,
                                maxCaffeineEffect: maxCaffeineEffectInt,
                                sleepTime: sleepTime.wrappedValue), toFile: "personalizedSetting.json")
            }
        }
    }
    
    // Formated String to Date
    private var formattedTime: Binding<Date> {
        Binding<Date>(
            // Getter Data
            get: {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                if let sleepDate = dateFormatter.date(from: sleepTime) {
                    return sleepDate
                } else {
                    return Date()                    }
            },
            // Setter Data
            set: { newDate in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                sleepTime = dateFormatter.string(from: newDate)
            }
        )
    }
}

#Preview {
    SettingPage(data: getPersonalData())
}

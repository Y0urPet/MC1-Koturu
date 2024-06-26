//
//  SettingPage.swift
//  MC1-Koturu
//
//  Created by Timothy Andrian on 04/04/24.
//

import SwiftUI

struct SettingPage: View {
    
    @State var date = Date()
    @State private var selection = "400mg"
    let choice = ["100mg", "200mg", "400mg"]
    @State private var selectionEfek = "5 jam"
    let choiceEfek = ["5 jam", "6 jam", "7 jam", "8 jam"]
    @State var isSavingSettings = false
    
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
                            DatePicker("", selection: $date, displayedComponents: .hourAndMinute).frame(width: 70)
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
                                    Text($0)
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
                                    Text($0)
                                }
                            }
                            .tint(.prime)
                        }
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        Button {
                            isSavingSettings.toggle()
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
}

#Preview {
    SettingPage()
}

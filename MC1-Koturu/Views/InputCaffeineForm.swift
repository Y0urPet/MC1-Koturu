//
//  InputCaffeineForm.swift
//  MC1-Koturu
//
//  Created by Timothy Andrian on 02/04/24.
//

import SwiftUI

struct InputCaffeineForm: View {
    @Binding private var personalData: Personalized
    @State private var isSaving = false
    @State private var checked = false
    
    @State private var isWadah = false
    @State private var isKonstan = false
    @State private var isVolume = false
    @State private var selection = "Sedang(60mg)"
    let choice = ["Kecil(30mg)", "Sedang(60mg)", "Besar(120mg)", "Sangat besar(150)", "Lainnya"]
    @State private var lainnya: String = ""
    @State private var isLainnya = false
    @State private var coffeeName = ""
    
    init(data: Binding<Personalized>) {
        _personalData = data
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Tambah Minuman")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                VStack(alignment: .leading) {
                    HStack(spacing: 110) {
                        Text("Nama: ")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                            .foregroundStyle(.prime)
                        Rectangle().frame(width: 21,height: 21).foregroundStyle(.third)
                    }
                    TextField("Masukkan nama kopi anda", text: $coffeeName)
                        .frame(width: 300)
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 75) {
                        Text("Metode Penghitungan")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.prime)
                        Rectangle().frame(width: 21,height: 21).foregroundStyle(.white)
                    }
                    // Berdasarkan ukuran wadah
                    HStack {
                        Image(systemName: isWadah ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(isWadah ? .prime : Color.secondary)
                            .onTapGesture {
                                if isVolume || isKonstan {
                                    self.isVolume = false
                                    self.isKonstan = false
                                    self.isWadah.toggle()
                                } else {
                                    self.isWadah.toggle()
                                }
                            }
                        VStack(alignment: .leading) {
                            Text("Ukuran Wadah")
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                            Text("Kafein diukur berdasarkan wadah.")
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                        }
                    }
                    // Berdasarkan Konstan
                    HStack {
                        Image(systemName: isKonstan ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(isKonstan ? .prime : Color.secondary)
                            .onTapGesture {
                                if isVolume || isWadah {
                                    self.isVolume = false
                                    self.isWadah = false
                                    self.isKonstan.toggle()
                                } else {
                                    self.isKonstan.toggle()
                                }
                            }
                        VStack(alignment: .leading) {
                            Text("Konstan")
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                            Text("Kafein diukur berdasarkan persaji.")
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                        }
                    }
                    //
                    HStack {
                        Image(systemName: isVolume ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(isVolume ? .prime: Color.secondary)
                            .onTapGesture {
                                if isKonstan || isWadah {
                                    self.isWadah = false
                                    self.isKonstan = false
                                    self.isVolume.toggle()
                                } else {
                                    self.isVolume.toggle()
                                }
                            }
                        VStack(alignment: .leading) {
                            Text("Volume")
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                            Text("Kafein diukur berdasarkan volume.")
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                        }
                    }
                }.padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                VStack {
                    HStack(spacing: 10) {
                        Text("Pilih jumlah Kafein")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                        Picker("Pilih jumlah Kafein", selection: $selection) {
                            ForEach(choice, id: \.self) {
                                Text($0)
                            }
                        }
                        .onChange(of: selection){
                            if self.selection == "Lainnya" {
                                isLainnya = true
                            } else {
                                isLainnya = false
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    if isLainnya {
                        TextField("Masukkan jumlah kafein anda (mg)", text: $lainnya).keyboardType(.numberPad).frame(width: 300)
                    }
                }
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                
                HStack(spacing: 110) {
                    VStack(alignment: .leading) {
                        Text("Referensi: ")
                            .fontWeight(.bold)
                            .font(.system(size: 12))
                            .foregroundStyle(.prime)
                        Text("""
                               - One shot of espresso : 75mg
                               - One large latte : 150mg
                               - One cup of drip coffee : 180mg
                               - Decaf Coffee : 3% of the regular
                             """)
                        .fontWeight(.light)
                        .font(.system(size: 12))
                        .foregroundStyle(.prime)
                    }
                    Rectangle().frame(width: 21,height: 21).foregroundStyle(.third)
                }
                NavigationLink(destination: HomePage(data: $personalData).navigationBarBackButtonHidden(true), label: {
                    Button{
                        isSaving.toggle()
                    } label: {
                        NavigationLink(destination: HomePage(data: $personalData).navigationBarBackButtonHidden(true), label: {
                            Text("Simpan").fontWeight(.bold).font(.system(size: 16))
                        })
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .padding(.leading, 140)
                    .padding(.trailing, 140)
                    .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                })
            }
            .position(x: UIScreen.main.bounds.width/2-15 ,y: UIScreen.main.bounds.height/2 - 180)
            .padding(16)
            .background(.third)
//            .navigationTitle("Ubah Minuman")
            .toolbarBackground(.hidden, for: .tabBar)
            
        }
        .tint(.second)
    }
    func saveUser() {
        print("User Saved")
    }
}



#Preview {
    InputCaffeineForm(data: getPersonalData())
}

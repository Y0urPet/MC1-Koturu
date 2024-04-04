//
//  InputCaffeineForm.swift
//  MC1-Koturu
//
//  Created by Timothy Andrian on 02/04/24.
//

//import SwiftUI
//
//struct InputCaffeineForm: View {
//    @State private var speed = 50.0
//    @State private var isEditing = false
//    @State var active: Bool = false
//
//    @State private var percent = 50.0
//    @State private var waveOffset = Angle(degrees: 0)
//
//    @State private var choice = "Tablespoon"
//    var starters = ["Teaspoon", "Tablespoon", "Sachet"]
//
//    @State var dateSelection = Date()
//
//    var body: some View {
//        GeometryReader { geo in
//            ZStack {
//                Image("uppergradient").position(CGPoint(x: UIScreen.main.bounds.width/2, y: 59))
//                Image("BottomGradien").position(CGPoint(x: UIScreen.main.bounds.width/2, y: 735))
//                Text("Add Caffeine Record")
//                    .foregroundStyle(.prime).fontWeight(.bold).font(.system(size: 30))
//                    .position(CGPoint(x: UIScreen.main.bounds.width/2, y: 150))
//                Text("\(Int(percent))mg")
//                    .foregroundStyle(.prime)
//                    .fontWeight(.bold)
//                    .font(.system(size: 32))
//                    .position(CGPoint(x: geo.size.width/2, y: 570))
//                    .animation(nil)
//                VStack {
//                    Wave3(offSet: Angle(degrees: waveOffset.degrees), percent: percent)
//                        .fill(.cupcolor)
//                    //                    .clipShape(Rectangle())
//                        .frame(width: 133,height: 315)
//                        .position(x: geo.size.width/2-24,y: 420)
//                }.onAppear {
//                    withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
//                        self.waveOffset = Angle(degrees: 360)
//                    }
//                }
//                RoundedRectangle(cornerRadius: 15.0)
//                    .frame(width: 38,height:197)
//                    .position(CGPoint(x: 303, y: 350))
//                    .foregroundStyle(.cupcolor)
//                HStack {
//                    Image("cup_big").resizable().frame(width: 195,height: 210).offset(x:60,y: 5)
//                    Slider(
//                        value: $percent,
//                        in: 50...100,
//                        onEditingChanged: { editing in
//                            isEditing = editing
//                        }
//
//                    ).tint(.white)
//                        .rotationEffect(Angle(degrees: -90)).frame(width: 170)
//                }.position(CGPoint(x: UIScreen.main.bounds.width/2+6, y: 350))
//
//                Text("Caffeine Content")
//                    .foregroundStyle(.prime).fontWeight(.regular).font(.system(size: 17))
//                    .position(CGPoint(x: geo.size.width/2, y: 520))
//
//                Picker("", selection: $choice) {
//                    ForEach(starters, id: \.self) {
//                        Text($0)
//                    }
//                }
//                .pickerStyle(.segmented).frame(width: 320)
//                .position(CGPoint(x: geo.size.width/2, y: 630))
//                .colorInvert()
//                .colorMultiply(.prime)
//
//                Button(action: submitCaffeine) {
//                    Text("Add")
//                        .foregroundStyle(.fifth)
//                        .fontWeight(.bold)
//                        .font(.system(size: 22))
//                        .padding(.leading,70)
//                        .padding(.trailing, 70)
//                        .padding(.top, 10)
//                        .padding(.bottom, 10)
//
//                }
//                .background(.prime)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
//                .position(CGPoint(x: geo.size.width/2-45, y: 700))
//
//                DatePicker("",selection: $dateSelection, displayedComponents: .hourAndMinute)
//                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
//                    .position(CGPoint(x: geo.size.width/2 + 90, y: 700))
//                    .colorInvert()
//                    .colorMultiply(Color.prime)
//            }
//            .background(.fifth)
//        }
//        .ignoresSafeArea()
//    }
//
//    func submitCaffeine() {
//
//    }
//}
//
//struct Wave3: Shape {
//    var offSet: Angle
//    var percent: Double
//
//    var animatableData: Double {
//        get { offSet.degrees }
//        set { offSet = Angle(degrees: newValue) }
//    }
//
//    func path(in rect: CGRect) -> Path {
//        var p = Path()
//
//        let lowestWave = 0.02
//        let highestWave = 1.00
//
//        let newPercent = lowestWave + (highestWave - lowestWave) * (percent / 100)
//
//        let waveHeight = 0.015 * rect.height
//        let yOffset = CGFloat(1 - newPercent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
//        let startAngle = offSet
//        let endAngle = offSet + Angle(degrees: 360 + 10)
//
//        p.move(to: CGPoint(x: 0, y: yOffset + waveHeight * CGFloat(sin(offSet.radians))))
//
//        for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 5) {
//            let x = CGFloat((angle - startAngle.degrees) / 360) * rect.width
//            p.addLine(to: CGPoint(x: x, y: yOffset + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
//        }
//
//        p.addLine(to: CGPoint(x: UIScreen.main.bounds.width/2-65, y: 170))
//        p.addLine(to: CGPoint(x: 0, y: 170))
//        p.closeSubpath()
//
//        return p
//    }
//}

import SwiftUI

struct InputCaffeineForm: View {
    //    @State private var firstName = ""
    //    @State private var lastName = ""
    //    @State private var birthdate = Date()
    //    @State private var shouldSendNewsLetter = false
    //    @State private var numberOfLikes = 1
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
                NavigationLink(destination: HomePage().navigationBarBackButtonHidden(true), label: {
                    Button{
                        isSaving.toggle()
                    } label: {
                        NavigationLink(destination: HomePage().navigationBarBackButtonHidden(true), label: {
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
    InputCaffeineForm()
}

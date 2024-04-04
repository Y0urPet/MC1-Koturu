//
//  CatalogPage.swift
//  MC1-Koturu
//
//  Created by Timothy Andrian on 04/04/24.
//

import SwiftUI

struct CatalogPage: View {
    @State private var selection = "Sedang(60mg)"
    let choice = ["Kecil(30mg)", "Sedang(60mg)", "Besar(120mg)", "Sangat besar(150)", "Lainnya"]
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    VStack(spacing:20) {
                        VStack {
                            HStack(spacing: 150) {
                                VStack(alignment: .leading, spacing: 30) {
                                    Text("Minuman").font(.system(size: 32)).fontWeight(.bold).foregroundStyle(.second)
                                    VStack(alignment: .leading) {
                                        Text("Minuman Saya").font(.system(size: 20)).fontWeight(.bold).foregroundStyle(.second)
                                        Text("Personalisasi dan sesuaikan minuman kafein.").font(.system(size: 12)).fontWeight(.regular).foregroundStyle(.second)
                                    }
                                }
                                Rectangle().frame(width: 21,height: 21).foregroundStyle(.third)
                            }
                            HStack {
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack {
                                        NavigationLink(destination: InputCaffeineForm(), label: {
                                            VStack {
                                                Image("addDrink")
                                                    .resizable()
                                                    .frame(width: 48, height: 48)
                                                Text("Add").font(.system(size: 12)).foregroundStyle(.third)
                                            }
                                        })
                                        VStack {
                                            Image("customDrink")
                                                .resizable()
                                                .frame(width: 48, height: 48)
                                            Text("Blend1").font(.system(size: 12)).foregroundStyle(.third)
                                        }
                                        VStack {
                                            Image("customDrink")
                                                .resizable()
                                                .frame(width: 48, height: 48)
                                            Text("Blend12").font(.system(size: 12)).foregroundStyle(.third)
                                        }
                                        VStack {
                                            Image("customDrink")
                                                .resizable()
                                                .frame(width: 48, height: 48)
                                            Text("Blend3").font(.system(size: 12)).foregroundStyle(.third)
                                        }
                                        VStack {
                                            Image("customDrink")
                                                .resizable()
                                                .frame(width: 48, height: 48)
                                            Text("Blend4").font(.system(size: 12)).foregroundStyle(.third)
                                        }
                                    }
                                }
                                Image(systemName: "chevron.right").foregroundStyle(.third)
                            }.padding()
                                .background(.second)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        
                        HStack(spacing:90) {
                            VStack(alignment: .leading) {
                                Text("Merek").font(.system(size: 22)).fontWeight(.bold).foregroundStyle(.second)
                                Text("Kelola merek dan minuman kopi anda.").font(.system(size: 12)).fontWeight(.regular).foregroundStyle(.second)
                            }
                            Rectangle().frame(width: 21,height: 21).foregroundStyle(.third)
                        }
                        
                        HStack(spacing: 208) {
                            VStack(alignment: .leading) {
                                Text("Kapal Api").font(.system(size: 20)).fontWeight(.bold).foregroundStyle(.second)
                                //                        Divider()
                                VStack(alignment: .leading) {
                                    Text("Mantap Gula")
                                    Text("Kopi Susu")
                                }
                            }
                            Rectangle().frame(width: 21,height: 21).foregroundStyle(.third)
                        }
                        Divider()
                        HStack(spacing: 208) {
                            VStack(alignment: .leading) {
                                Text("Good Day").font(.system(size: 20)).fontWeight(.bold).foregroundStyle(.second)
                                //                        Divider()
                                VStack(alignment: .leading) {
                                    Text("Complete Mix")
                                    Text("Cappucino")
                                }
                            }
                            Rectangle().frame(width: 21,height: 21).foregroundStyle(.third)
                        }
                    }.padding(30).position(x:geo.size.width/2,y:+280).foregroundStyle(.second)
                    Rectangle().frame(height: 100)
                        .position(x:geo.size.width/2,y:+750).foregroundStyle(.second)
                }
            }.background(.third)
        }.toolbarBackground(.second, for: .tabBar)
    }
}

#Preview {
    CatalogPage()
}

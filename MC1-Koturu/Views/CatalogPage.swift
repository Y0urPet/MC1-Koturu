//
//  CatalogPage.swift
//  MC1-Koturu
//
//  Created by Timothy Andrian on 04/04/24.
//

import SwiftUI

struct CatalogPage: View {
    @State private var isExpanded = false
    @Binding private var customBaverage : [CustomBaverage]
    @Binding private var defaultBaverage : [DefaultBaverage]
    @Binding private var personal : Personalized
    
    init(dataPersonal: Binding<Personalized>, dataCustom: Binding<[CustomBaverage]>, dataDefault: Binding<[DefaultBaverage]>) {
        _customBaverage = dataCustom
        _defaultBaverage = dataDefault
        _personal = dataPersonal
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    VStack(spacing:10) {
                        VStack {
                            HStack(spacing: 150) {
                                VStack(alignment: .leading, spacing: 20) {
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
                                        NavigationLink(destination: InputCaffeineForm(data: $personal), label: {
                                            VStack {
                                                Image("addDrink")
                                                    .resizable()
                                                    .frame(width: 48, height: 48)
                                                Text("Add").font(.system(size: 12)).foregroundStyle(.third)
                                            }
                                        })

                                        HStack {
                                            Group {
                                                ForEach(customBaverage) {baverage in
                                                    VStack {
                                                        baverage.image                                        .resizable()
                                                            .frame(width: 48, height: 48)
                                                        Text(baverage.name)
                                                            .font(.system(size: 12))
                                                            .foregroundStyle(.third)
                                                            .multilineTextAlignment(.leading)
                                                    }
                                                }
                                            }
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

                        VStack {
                            Group {
                                ForEach(defaultBaverage) {baverage in
                                    
                                    HStack(spacing: 10){                                            baverage.image
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .padding(.leading, -5)

                                        Text(baverage.name)
                                                .font(.system(size: 16))
                                                .fontWeight(.bold)
                                                .foregroundStyle(.prime)
                                                .frame(width: 150, alignment: .leading)
                                        
                                        Image(systemName: "chevron.up").foregroundStyle(.black)
                                            .padding(.leading, 60)
                                        
                                    }.frame(width: UIScreen.main.bounds.width - 100, height: 40)
                                    .padding()
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                                    
                                
                                }
                            }
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
    CatalogPage(dataPersonal: getPersonalData(),dataCustom: getCustomBaveragesData(), dataDefault: getDefaultBaveragesData())
}

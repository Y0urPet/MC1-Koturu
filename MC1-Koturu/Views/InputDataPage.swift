//
//  InputCaffeineForm.swift
//  MC1-Koturu
//
//  Created by Timothy Andrian on 02/04/24.
//

import SwiftUI

struct InputDataPage: View {
    @Binding private var personalData: Personalized
    @Binding private var caffeineConsumption: [CaffeineConsumption]
    @Binding private var customBaverages: [CustomBaverage]
    @Binding private var defaultBaverages: [DefaultBaverage]
    
    @State private var selectionBaverageType = "Default"
    @State private var selectionDefaultBaverage = "Kopi Kapal Api"
    @State private var selectionDefaultBaverageType = "Special"
    @State private var selectionCustomBaverage = "Americano"
    
    @State private var choiceType = ""
    private var defaultChoice: [String]
    
    let baverageTypeChoice = ["Custom", "Default"]
    
    
    init(dataPersonal: Binding<Personalized>, dataCaffeine: Binding<[CaffeineConsumption]>, defaultBaverage: Binding<[DefaultBaverage]>, customBaverage: Binding<[CustomBaverage]>) {
        _personalData = dataPersonal
        _caffeineConsumption = dataCaffeine
        _customBaverages = customBaverage
        _defaultBaverages = defaultBaverage
        defaultChoice = [""]
        for data in defaultBaverage {
            defaultChoice.append(data.wrappedValue.name)
        }
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack{
                    Image("beanBackground")
                    VStack(spacing: 20) {
                        Text("Input Data")
                            .font(.title)
                            .fontWeight(.bold)
                        HStack(spacing: 30) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Pilih Tipe Minuman")
                                        .font(.system(size: 15))
                                        .foregroundStyle(.second)
                                        .fontWeight(.semibold)
                                        .frame(width: 165, alignment: .leading)
                                }
                                Picker("Masa Efek Kafein", selection: $selectionBaverageType) {
                                    ForEach(baverageTypeChoice, id: \.self) {
                                        Text($0)
                                    }
                                }.onChange(of: selectionBaverageType) {
//                                    print(selectionBaverageType)
                                }
                            }
                        }
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .frame(width: 400)
                        
                        if selectionBaverageType == "Default" {
                            HStack(spacing: 30) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Pilih Minuman")
                                            .font(.system(size: 15))
                                            .foregroundStyle(.second)
                                            .fontWeight(.semibold)
                                            .frame(width: 165, alignment: .leading)
                                    }
                                    
                                    Picker("Default Baverage", selection: $selectionDefaultBaverage) {
                                        ForEach(defaultChoice, id: \.self) {
                                            Text($0)
//                                            print($0)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .frame(width: 400)
                            
//                            if selectionDefaultBaverage != "" {
//                                HStack(spacing: 30) {
//                                    HStack {
//                                        VStack(alignment: .leading) {
//                                            Text("Pilih Jeni Minuman")
//                                                .font(.system(size: 15))
//                                                .foregroundStyle(.second)
//                                                .fontWeight(.semibold)
//                                                .frame(width: 165, alignment: .leading)
//                                        }
//                                        
//                                        Picker("Default Baverage", selection: $selectionDefaultBaverage) {
//                                            ForEach($defaultBaverages, id: \.self) { $data in
//                                                ForEach($data.wrappedValue.varians, id: \.self) { baverage in
//                                                    if data.name == $selectionDefaultBaverage.wrappedValue {
//                                                        Text(baverage.name)
//                                                    }
//                                                }
//                                            }
//                                        }.tint(.prime)
//                                    }
//                                }
//                                .padding()
//                                .background(.white)
//                                .clipShape(RoundedRectangle(cornerRadius: 8))
//                                .frame(width: 400)
//                            }
                        } else {
                            HStack(spacing: 30) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Pilih Minuman")
                                            .font(.system(size: 15))
                                            .foregroundStyle(.second)
                                            .fontWeight(.semibold)
                                            .frame(width: 165, alignment: .leading)
                                    }
                                    
                                    Picker("Custom Baverage", selection: $selectionCustomBaverage) {
                                        ForEach($customBaverages, id: \.self) { $data in
                                            Text(data.name)
                                        }
                                    }.tint(.prime)
                                }
                            }
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .frame(width: 400)
                        }
                    }
                }
            }.background(.third)
        }.toolbarBackground(.second, for: .tabBar)
    }
}


#Preview {
    InputDataPage(dataPersonal: getPersonalData(), dataCaffeine: getCaffeinConsumptionData(), defaultBaverage: getDefaultBaveragesData(), customBaverage: getCustomBaveragesData())
}

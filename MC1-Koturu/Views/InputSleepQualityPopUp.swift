//
//  InputSleepQualityPopUp.swift
//  MC1-Koturu
//
//  Created by Doni Pebruwantoro on 13/04/24.
//

import SwiftUI

struct InputSleepQualityPopUp: View {
    @Binding private var dailySleep: [DailySleep]
    @State private var point = 0
    
    @Environment(\.presentationMode) var presentationMode
    
    init(data: Binding<[DailySleep]>) {
        _dailySleep = data
    }


    var body: some View {
        VStack {
            ZStack {
                Color.black.opacity(0.5).ignoresSafeArea()
                VStack {
                    VStack {
                        Image(systemName: "xmark")
                            .frame(width: 370, height: 60)
                            .offset(x: 150, y: -10)
                            .padding(.bottom, -30)
                            .foregroundStyle(.prime)
                    }
                    
                    VStack {
                        HStack {
                            Text("Apakah kamu tidur nyenyak?")
                                    .font(.title3)
                                    .padding()
                                    .foregroundColor(.white)
                                    .frame(width: 315, height: 40)
                                .background(.prime)
                            .cornerRadius(30)
                            
                            Image(systemName: "info.circle.fill")
                                .resizable()
                                .offset(x: -35, y: 0)
                                .frame(width: 15,height: 15)
                                .foregroundStyle(.info)
                        }
                    }

                    HStack {
                        Image(systemName: "1.circle.fill")
                            .resizable()
                            .foregroundColor(point == 1 ? .second : .info)
                            .frame(width: 30, height: 30)
                            .padding(EdgeInsets(top: 10, leading: 5, bottom: 5, trailing: 5))
                            .padding(.horizontal, 5).onTapGesture {
                                self.point = 1
                            }

                        Image(systemName: "2.circle.fill")
                            .resizable()
                            .foregroundColor(point == 2 ? .second : .info)
                            .frame(width: 30, height: 30)
                            .padding(EdgeInsets(top: 10, leading: 5, bottom: 5, trailing: 5))
                            .padding(.horizontal, 5).onTapGesture {
                                self.point = 2
                            }

                        Image(systemName: "3.circle.fill")
                            .resizable()
                            .foregroundColor(point == 3 ? .second : .info)
                            .frame(width: 30, height: 30)
                            .padding(EdgeInsets(top: 10, leading: 5, bottom: 5, trailing: 5))
                            .padding(.horizontal, 5).onTapGesture {
                                self.point = 3
                            }
                        
                        Image(systemName: "4.circle.fill")
                            .resizable()
                            .foregroundColor(point == 4 ? .second : .info)
                            .frame(width: 30, height: 30)
                            .padding(EdgeInsets(top: 10, leading: 5, bottom: 5, trailing: 5))
                            .padding(.horizontal, 5).onTapGesture {
                                self.point = 4
                            }
                        
                        Image(systemName: "5.circle.fill")
                            .resizable()
                            .foregroundColor(point == 5 ? .second : .info)
                            .frame(width: 30, height: 30)
                            .padding(EdgeInsets(top: 10, leading: 5, bottom: 5, trailing: 5))
                            .padding(.horizontal, 5).onTapGesture {
                                self.point = 5
                            }
                    }
                    
                    VStack {
                        HStack {
                            Text("Tidak\nNyenyak")
                                .font(.callout)
                                .padding(.horizontal, 10)
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .padding(.bottom, 50)
                                .padding(.top, 5)
                            .offset(x: -70)
                            Text("Nyenyak")
                                .font(.callout)
                                .padding(.horizontal, 10)
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .padding(.bottom, 50)
                                .padding(.top, -10)
                            .offset(x: 70)

                        }
                    }
                    
                    if point > 0 {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.prime)
                                .frame(width: 100, height: 30)
                                .padding(.bottom, 60)
                            
                            Button("Save") {
                                if dailySleep.isEmpty {
                                    let daily: DailySleep = DailySleep(id: 1, createdAt: timeFormatString(), point: self.point)
                                    
                                    createDataSleep(data: [daily])
                                    
                                } else {
                                    let daily: DailySleep = DailySleep(id: Int($dailySleep[$dailySleep.wrappedValue.count-1].wrappedValue.id+1), createdAt: timeFormatString(), point: self.point)
                                    
                                    // Create Data
                                    self.$dailySleep.wrappedValue.append(daily)
                                    createDataSleep(data: $dailySleep.wrappedValue)
                                }
                                presentationMode.wrappedValue.dismiss()
                                refreshData()
                            }
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.top, -40)
                        }
                        .padding(.bottom, -50)
                        .padding(.top, -30)
                    }
                }
                .background(Color.white)
                .cornerRadius(15)
                .padding()
            }
        }.background(.third)
    }
    
    func createDataSleep(data: [DailySleep]){
        save(data, toFile: fileDailySleeps)
    }
    
    func refreshData() {
        dailySleep = loadLocalFile(fileDailySleeps)
    }
}

#Preview {
    InputSleepQualityPopUp(data: getDailySleepsData())
}

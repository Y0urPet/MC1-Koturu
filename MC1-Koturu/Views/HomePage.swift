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
    @Binding private var caffeineConsumptioData: [CaffeineConsumption]
    @Binding private var customBaverages: [CustomBaverage]
    @Binding private var defaultBaverages: [DefaultBaverage]

    
    @State var totalCaffeine = 0
    @State var isOverLimiting = false
    private var countArr: [Int] = []
    private var dayArr: [String] = []
    private var totalDataConsumption: Int
    private var favorite: CaffeineConsumption = CaffeineConsumption(id: 0, name: "", caffeine: 0, createdAt: "")
    private var average: Int = 0
    
    init(dataPersonal: Binding<Personalized>, dataConsumptions: Binding<[CaffeineConsumption]>, defaultBaverage: Binding<[DefaultBaverage]>, customBaverage: Binding<[CustomBaverage]>) {
        _personalData = dataPersonal
        _caffeineConsumptioData = dataConsumptions
        _customBaverages = customBaverage
        _defaultBaverages = defaultBaverage
        totalDataConsumption = dataConsumptions.count
        let (count, day, baverage, averageAmount, totalAmount) = getMappingdataBaverage(data: caffeineConsumptioData)
        countArr = count
        dayArr = day
        favorite = baverage
        average = averageAmount
        totalCaffeine = totalAmount
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
                                        Text("\(totalCaffeine)mg/" + String(personalData.maxDailyCaffeine) + "mg")                                            .font(.system(size: 32))
                                            .fontWeight(.black)
                                            .foregroundStyle(.second)
                                            .padding(.bottom, 0)
                                        HStack{
                                            Text("\(personalData.maxCaffeineEffect) jam")
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
                                            }
                                        }
                                    }.padding(.bottom, -20)
                                    
                                    ScrollView(.horizontal) {
                                        HStack {
                                            Group {
                                                ForEach(customBaverages) { baverage in
                                                    VStack(spacing: 10){
                                                        VStack(alignment: .leading,spacing: 5){
                                                            Text(baverage.name)
                                                                .font(.system(size: 16))
                                                                .fontWeight(.bold)
                                                                .foregroundStyle(.prime)
                                                                .frame(width: 100, alignment: .leading)
                                                            Text("\(baverage.caffeine)mg kafein")
                                                                .font(.system(size: 12))
                                                                .fontWeight(.regular)
                                                                .foregroundStyle(.prime)
                                                        }
                                                        Image("inputCoffee").resizable().frame(width: 50,height: 50).onTapGesture {
                                                            if totalCaffeine < personalData.maxDailyCaffeine && totalCaffeine + baverage.caffeine <= personalData.maxDailyCaffeine {
                                                                totalCaffeine += baverage.caffeine
                                                                
                                                                if isDataNull(data: $caffeineConsumptioData) {
                                                                    let consumption: CaffeineConsumption = CaffeineConsumption(id: 1, name: baverage.name, caffeine: baverage.caffeine, createdAt: timeFormatString())
                                                                    createDataConsumption(data: [consumption])
                                                                    // Update
                                                                    refreshData()
                                                                } else {
                                                                    let consumption: CaffeineConsumption = CaffeineConsumption(id: Int($caffeineConsumptioData[$caffeineConsumptioData.wrappedValue.count-1].wrappedValue.id+1), name: baverage.name, caffeine: baverage.caffeine, createdAt: timeFormatString())

                                                                    // Create Data
                                                                    self.$caffeineConsumptioData.wrappedValue.append(consumption)
                                                                    createDataConsumption(data: $caffeineConsumptioData.wrappedValue)
                                                                    
                                                                    // Update
                                                                    refreshData()
                                                                }
                                                            } else {
                                                                isOverLimiting = true
                                                            }
                                                        }.alert(isPresented: $isOverLimiting, content: {
                                                            Alert(title: Text("You drink too much coffee!"))
                                                        }).padding(.leading, -50)
                                                    }
                                                    .padding()
                                                    .background(.white)
                                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                                                }
                                            }
                                        }
                                    }.frame(width: geo.size.width-50).padding(.bottom, -20)

                                    
                                    if isDataNull(data: $caffeineConsumptioData) {
                                        HStack(spacing: 145) {
                                            VStack(alignment: .leading) {
                                                Text("Terakhir Diminum")
                                                    .font(.system(size: 20))
                                                    .fontWeight(.bold)
                                                .foregroundStyle(.prime)
                                                Text("-")
                                            }
                                            Rectangle().frame(width: 2,height: 2).foregroundStyle(.third)
                                        }
                                        
                                        VStack {
                                                HStack(spacing: 30){
                                                    VStack(alignment: .leading, spacing: 1){
                                                        Text("Data belum dimasukkan")
                                                            .font(.system(size: 16))
                                                            .fontWeight(.bold)
                                                            .foregroundStyle(.prime)
                                                            .frame(width: 300, alignment: .leading)
                                                    }
                                                }
                                                .padding()
                                                .background(.white)
                                                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                                            
                                        }.padding(.top, -25)
                                        
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
                                                Text("Data belum dimasukkan")
                                                    .font(.system(size: 16))
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.prime)
                                                    .frame(width: 300, alignment: .leading)
                                            }
                                            .padding()
                                            .background(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        }.padding(.bottom, 400)
                                    } else {
                                        HStack(spacing: 145) {
                                            VStack(alignment: .leading) {
                                                Text("Terakhir Diminum")
                                                    .font(.system(size: 20))
                                                    .fontWeight(.bold)
                                                .foregroundStyle(.prime)
                                                Text(getDateAndMonth(createdAtString: $caffeineConsumptioData[(totalDataConsumption-1)].wrappedValue.createdAt))
                                            }
                                            Rectangle().frame(width: 21,height: 21).foregroundStyle(.third)
                                            
                                        }
                                        
                                        Group {
                                            ForEach($caffeineConsumptioData.wrappedValue.reversed().prefix(3), id: \.self) { temp in
                                                // Minuman Terakhir
                                                VStack {
                                                    VStack() {
                                                        // untuk kasus minum kopi dibawah 1 jam
                                                        HStack(spacing: 30){
                                                            VStack(alignment: .leading,spacing: 5){
                                                                Text(temp.name)
                                                                    .font(.system(size: 16))
                                                                    .fontWeight(.bold)
                                                                    .foregroundStyle(.prime)
                                                                    .frame(width: 150, alignment: .leading)
                                                                HStack {
                                                                    Text("Diminum \(calculateDifferenceTime(createdAtString: temp.createdAt)) yang lalu")
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
                                                            Text("\(temp.caffeine)mg")
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
                                            }
                                        }.padding(.top, -10).padding(.bottom, -5)
                                        
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
                                                        Text("\(totalCaffeine)mg")
                                                            .font(.system(size: 16))
                                                            .foregroundStyle(.prime)
                                                            .fontWeight(.bold)
                                                    }
                                                    
                                                    VStack(alignment: .trailing) {
                                                        Text("Daily Average")
                                                            .font(.system(size: 12))
                                                            .foregroundStyle(.prime)
                                                            .fontWeight(.regular)
                                                        Text("\(average)mg")
                                                            .font(.system(size: 16))
                                                            .foregroundStyle(.prime)
                                                            .fontWeight(.bold)
                                                    }
                                                }

                                                Chart(dayArr.indices, id: \.self) { idx in
                                                    BarMark(
                                                        x: .value("Shape Type", dayArr[idx]),
                                                        y: .value("Total Count", countArr[idx]),
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
    
    func createDataConsumption(data: [CaffeineConsumption]) {
        save(data, toFile: fileCaffeineConsumption)
    }
    
    func refreshData() {
        caffeineConsumptioData = loadLocalFile(fileCaffeineConsumption)
    }
    
    func calculateDifferenceTime(createdAtString: String) -> String {
        let now = Date()
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        if let createdAt = dateFormatter.date(from: createdAtString) {
            let timeDifference = now.timeIntervalSince(createdAt)
            let hours = (timeDifference / 3600)
            let minutes = (timeDifference / 60)
           
            if hours <= 0 {
                if minutes <= 0 {
                    return String(format: "%.f detik", timeDifference)
                } else {
                    return String(format: "%.f menit", minutes)
                }
            } else {
                return String(format: "%.f jam", hours)
            }
            
        }
        
        return ""
    }
    
    func getMappingdataBaverage(data: [CaffeineConsumption]) -> ([Int], [String], CaffeineConsumption, Int, Int) {
        var resultConsumption = [Int]()
        var resultDay = [String]()
        var count = 0
        var tempDay = ""
        var favorite: CaffeineConsumption = CaffeineConsumption(id: 0, name: "", caffeine: 0, createdAt: "")
        var average: Int = 0
        var total: Int = 0
        if !data.isEmpty {
            for temp in data {
                let currentDay = getDay(createdAtString: temp.createdAt)
                
                if tempDay.isEmpty {
                    tempDay = currentDay
                }
                
                if currentDay == tempDay {
                    count += 1
                } else {
                    resultDay.append(tempDay)
                    resultConsumption.append(count)
                    count = 1
                    tempDay = currentDay
                }
            }
            
            if !tempDay.isEmpty {
                resultDay.append(tempDay)
                resultConsumption.append(count)
            }
            
            favorite = getFavoriteBaverage(data: data)
            average = dailyAverage(data: data)
            total = getTotalDailyConsumption(data: data)
        }
        
        return (resultConsumption, resultDay, favorite, average, total)
    }
    
    func getTotalDailyConsumption(data: [CaffeineConsumption]) -> Int {
        let normalFormat = DateFormatter()
        normalFormat.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        
        let now: Date = Date()
        let formattedDateNow = dateFormat.string(from: now)
       
        var totalAmount: Int = 0
        
        for temp in data {
            if let tempDate = normalFormat.date(from: temp.createdAt) {
                let tempDateStr = dateFormat.string(from: tempDate)
                if tempDateStr == formattedDateNow {
                    totalAmount += temp.caffeine
                }
            }
        }
        
        return totalAmount

    }
    
    func dailyAverage(data: [CaffeineConsumption]) -> Int {
        let normalFormat = DateFormatter()
        normalFormat.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        
        let now: Date = Date()
        let formattedDateNow = dateFormat.string(from: now)
       
        var totalAmount: Int = 0
        var count: Int = 0
        
        for temp in data {
            if let tempDate = normalFormat.date(from: temp.createdAt) {
                let tempDateStr = dateFormat.string(from: tempDate)
                if tempDateStr == formattedDateNow {
                    count += 1
                    totalAmount += temp.caffeine
                }
            }
        }
        
        return totalAmount/count
    }
    
    func getFavoriteBaverage(data: [CaffeineConsumption]) -> CaffeineConsumption {
        var countMap: [String: Int] = [:]
        
        for item in data {
            countMap[item.name, default: 0] += 1
        }
       
        var maxCount = 0
        var favorite: CaffeineConsumption = data[0]
        
        for item in data {
            if let count = countMap[item.name], count > maxCount {
                maxCount = count
                favorite = item
            }
        }
            
        
        return favorite
    }
    
    func isDataNull(data: Binding<[CaffeineConsumption]>) -> Bool {
        if data.isEmpty {
            return true
        }
        return false
    }
}

#Preview {
    HomePage(dataPersonal: getPersonalData(), dataConsumptions: getCaffeinConsumptionData(), defaultBaverage: getDefaultBaveragesData(), customBaverage: getCustomBaveragesData())
}

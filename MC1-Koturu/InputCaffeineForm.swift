//
//  InputCaffeineForm.swift
//  MC1-Koturu
//
//  Created by Timothy Andrian on 02/04/24.
//

import SwiftUI

struct InputCaffeineForm: View {
    @State private var speed = 50.0
    @State private var isEditing = false
    @State var active: Bool = false
    
    @State private var percent = 50.0
    @State private var waveOffset = Angle(degrees: 0)
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("uppergradient").position(CGPoint(x: UIScreen.main.bounds.width/2, y: 59))
                Image("BottomGradien").position(CGPoint(x: UIScreen.main.bounds.width/2, y: 735))
                Text("Add Caffeine Record")
                    .foregroundStyle(.prime).fontWeight(.bold).font(.system(size: 30))
                    .position(CGPoint(x: UIScreen.main.bounds.width/2, y: 150))
//                withAnimation(.linear(duration: 0)) {
//                    Text("\(Int(percent))mg")
//                        .foregroundStyle(.prime)
//                        .fontWeight(.bold)
//                        .font(.system(size: 32))
//                        .position(CGPoint(x: geo.size.width/2, y: 580))
//                }
                Text("\(Int(percent))mg")
                    .foregroundStyle(.prime)
                    .fontWeight(.bold)
                    .font(.system(size: 32))
                    .position(CGPoint(x: geo.size.width/2, y: 580))
                    .animation(nil)
                VStack {
                    Wave3(offSet: Angle(degrees: waveOffset.degrees), percent: percent)
                        .fill(.cupcolor)
    //                    .clipShape(Rectangle())
                        .frame(width: 133,height: 315)
                    .position(x: geo.size.width/2-24,y: 420)
                }.onAppear {
                    withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                        self.waveOffset = Angle(degrees: 360)
                    }
                }
                RoundedRectangle(cornerRadius: 15.0)
                    .frame(width: 38,height:197)
                    .position(CGPoint(x: 303, y: 350))
                    .foregroundStyle(.cupcolor)
                HStack {
                    Image("cup_big").resizable().frame(width: 195,height: 210).offset(x:60,y: 5)
                    Slider(
                        value: $percent,
                        in: 50...100,
                        onEditingChanged: { editing in
                            isEditing = editing
                        }
                        
                    ).tint(.white)
                    .rotationEffect(Angle(degrees: -90)).frame(width: 170)
                }.position(CGPoint(x: UIScreen.main.bounds.width/2+6, y: 350))
                
                Text("Caffeine Content")
                    .foregroundStyle(.prime).fontWeight(.regular).font(.system(size: 17))
                    .position(CGPoint(x: geo.size.width/2, y: 540))
//                Text("\(Int(percent))mg")
//                    .withAnimation(nil)
//                    .foregroundStyle(.prime).fontWeight(.bold)
//                    .font(.system(size: 32))
//                    .position(CGPoint(x: geo.size.width/2, y: 580))
                    
                Button(action: submitCaffeine) {
                    Text("Add")
                        .foregroundStyle(.fifth)
                        .fontWeight(.bold)
                        .font(.system(size: 32))
                        .padding(.leading,120)
                        .padding(.trailing, 120)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                }
                .background(.prime)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .position(CGPoint(x: geo.size.width/2, y: 650))
            }
            .background(.fifth)
        }
        .ignoresSafeArea()
    }
    
    func submitCaffeine() {
        
    }
}

struct Wave3: Shape {
    var offSet: Angle
    var percent: Double
    
    var animatableData: Double {
        get { offSet.degrees }
        set { offSet = Angle(degrees: newValue) }
    }
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        let lowestWave = 0.02
        let highestWave = 1.00
        
        let newPercent = lowestWave + (highestWave - lowestWave) * (percent / 100)
        
        let waveHeight = 0.015 * rect.height
        let yOffset = CGFloat(1 - newPercent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
        let startAngle = offSet
        let endAngle = offSet + Angle(degrees: 360 + 10)
        
        p.move(to: CGPoint(x: 0, y: yOffset + waveHeight * CGFloat(sin(offSet.radians))))
        
        for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 5) {
            let x = CGFloat((angle - startAngle.degrees) / 360) * rect.width
            p.addLine(to: CGPoint(x: x, y: yOffset + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
        }
        
        p.addLine(to: CGPoint(x: UIScreen.main.bounds.width/2-65, y: 170))
        p.addLine(to: CGPoint(x: 0, y: 170))
        p.closeSubpath()
        
        return p
    }
}



#Preview {
    InputCaffeineForm()
}

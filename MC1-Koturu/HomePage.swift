//
//  HomePage.swift
//  MC1-Koturu
//
//  Created by Timothy Andrian on 01/04/24.
//

import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    @Published var x = 0.0
    @Published var y = 0.0
    
    init() {
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
            guard let motion = data?.attitude else { return }
            self?.x = motion.roll
            self?.y = motion.pitch
        }
    }
}

struct HomePage: View {
    @State private var percent = 110.0
    @State private var waveOffset = Angle(degrees: 0)
    @State private var waveOffset2 = Angle(degrees: 0)
    @StateObject private var motion = MotionManager()
    let totalDuration = 3.0
    var body: some View {
        NavigationView {
            ZStack {
                Image("homebackground").position(CGPoint(x: UIScreen.main.bounds.width/2+20, y: 300))
                Image("uppergradient").position(CGPoint(x: UIScreen.main.bounds.width/2, y: 59))
                GeometryReader { geo in
                    ScrollView {
                        VStack(spacing: 16) {
                            ZStack {
                                // Wave
                                Wave(offSet: Angle(degrees: waveOffset.degrees), percent: percent)
                                    .fill(Color.second)
                                    .ignoresSafeArea()
                                    .position(CGPoint(x: geo.size.width / 2, y: geo.size.height + motion.y * 280))
                                    .onAppear {
                                        withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                                            self.waveOffset = Angle(degrees: 360)
                                        }
                                    }
                                Wave2(offSet: Angle(degrees: waveOffset2.degrees), percent: percent)
                                    .fill(.prime)
                                    .ignoresSafeArea()
                                    .position(CGPoint(x: geo.size.width / 2, y: geo.size.height + motion.y * 280))
                                    .onAppear {
                                        withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                                            self.waveOffset2 = Angle(degrees: 360)
                                        }
                                    }
                                    .frame(height: geo.size.height)
                                NavigationLink(destination: InputCaffeineForm(), label: {
                                    Image("Coffee-button2")
                                        .resizable()
                                        .frame(width: 150,height: 150)
                                    .position(CGPoint(x: geo.size.width / 2, y: geo.size.height/2))
                                }).ignoresSafeArea()
                                VStack(spacing: 10) {
                                    Text("Body Caffeine").foregroundStyle(.prime)
                                    Text("0mg / 400mg")
                                        .fontWeight(.bold).font(.system(size: 40))
                                        .foregroundStyle(.prime)
                                        .shadow(radius: 10)
                                }.position(CGPoint(x: UIScreen.main.bounds.width/2, y: 120))
                                VStack(spacing: 40) {
                                    Text("Swipe Up")
                                        .foregroundStyle(.second)
                                    //Swipe Instruction animator
                                    Image(systemName: "arrow.up")
                                        .resizable()
                                        .frame(width: 50,height: 50)
                                        .foregroundStyle(.second)
                                        .keyframeAnimator(initialValue: AnimationProperties(), repeating: true) { content, value in
                                            content
                            //                    .scaleEffect(y: value.verticalStretch)
                                                .offset(y: value.yTranslation)
                                                
                                        } keyframes: { _ in
                                            KeyframeTrack(\.verticalStretch) {
                                                SpringKeyframe(0.6, duration: totalDuration * 0.15)
                                                CubicKeyframe(1, duration: totalDuration * 0.15)
                                                CubicKeyframe(1.2, duration: totalDuration * 0.4)
                                                CubicKeyframe(1.1, duration: totalDuration * 0.15)
                                                SpringKeyframe(1, duration: totalDuration * 0.15)
                                            }
                                            
                                            KeyframeTrack(\.yTranslation) {
                                                CubicKeyframe(0, duration: totalDuration * 0.1)
                                                CubicKeyframe(-25, duration: totalDuration * 0.3)
                                                CubicKeyframe(-25, duration: totalDuration * 0.3)
                                                CubicKeyframe(0, duration: totalDuration * 0.3)
                                            }
                                        }
                                }
                                .position(CGPoint(x: UIScreen.main.bounds.width/2, y: 700))
                                .opacity(0.5)
                                
                            }
                            // Caffeine Intake
                            VStack(alignment: .leading) {
                                Text("Caffeine Intake").foregroundStyle(.white).font(.system(size: 25)).fontWeight(.bold)
                                HStack {
                                    Image("Coffee-button").resizable().aspectRatio(contentMode: .fill)
                                        .frame(width: 100,height: 100)
                                    VStack(alignment: .leading) {
                                        Text("Aku Leppy").fontWeight(.bold).padding(.bottom).foregroundStyle(.black)
                                        HStack {
                                            Image(systemName: "mappin.circle.fill").foregroundStyle(.black)
                                            Text("3,5km").font(.system(size: 12)).foregroundStyle(.black)
                                            Image(systemName: "scalemass.fill").foregroundStyle(.black)
                                            Text("4,6kg").font(.system(size: 12)).foregroundStyle(.black)
                                            Image(systemName: "pawprint.fill").foregroundStyle(.black)
                                            Text("Female").font(.system(size: 10)).foregroundStyle(.black)
                                        }
                                    }
                                    VStack {
                                        Image(systemName: "heart.fill").padding(.bottom,60).padding(.trailing, 20)
                                            .foregroundStyle(.red)
                                    }
                                }.background(Color.white)
                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                                .shadow(radius: 10)
                            }.padding(.top,40)
                            // Caffeine Log
                            VStack(alignment: .leading) {
                                Text("Caffeine Log").foregroundStyle(.white).font(.system(size: 25)).fontWeight(.bold)
                                HStack {
                                    Image("Coffee-button").resizable().aspectRatio(contentMode: .fill)
                                        .frame(width: 100,height: 100)
                                    VStack(alignment: .leading) {
                                        Text("Aku Leppy").fontWeight(.bold).padding(.bottom)
                                            .foregroundStyle(.black)
                                        HStack {
                                            Image(systemName: "mappin.circle.fill")
                                                .foregroundStyle(.black)
                                            Text("3,5km").font(.system(size: 12)).foregroundStyle(.black)
                                            Image(systemName: "scalemass.fill")
                                                .foregroundStyle(.black)
                                            Text("4,6kg").font(.system(size: 12)).foregroundStyle(.black)
                                            Image(systemName: "pawprint.fill")
                                                .foregroundStyle(.black)
                                            Text("Female").font(.system(size: 10)).foregroundStyle(.black)
                                        }
                                    }
                                    VStack {
                                        Image(systemName: "heart.fill").padding(.bottom,60).padding(.trailing, 20)
                                            .foregroundStyle(.red)
                                    }
                                }.background(Color.white)
                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                                .shadow(radius: 10)
                            }.padding(.top,16)
                            VStack(alignment: .leading) {
                                Text("Caffeine History").foregroundStyle(.white).font(.system(size: 25)).fontWeight(.bold)
                                
                                ForEach(0 ..< 5) { item in
                                    HStack {
                                        Image("Coffee-button").resizable().aspectRatio(contentMode: .fill)
                                            .frame(width: 100,height: 100)
                                        VStack(alignment: .leading) {
                                            Text("Aku Leppy").fontWeight(.bold).padding(.bottom).foregroundStyle(.black)
                                            HStack {
                                                Image(systemName: "mappin.circle.fill")
                                                    .foregroundStyle(.black)
                                                Text("3,5km").font(.system(size: 12)).foregroundStyle(.black)
                                                Image(systemName: "scalemass.fill")
                                                    .foregroundStyle(.black)
                                                Text("4,6kg").font(.system(size: 12)).foregroundStyle(.black)
                                                Image(systemName: "pawprint.fill")
                                                    .foregroundStyle(.black)
                                                Text("Female").font(.system(size: 10)).foregroundStyle(.black)
                                            }
                                        }
                                        VStack {
                                            Image(systemName: "heart.fill").padding(.bottom,60).padding(.trailing, 20)
                                                .foregroundStyle(.red)
                                        }
                                    }.background(Color.white)
                                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                                    .shadow(radius: 10)
                                    .padding(.top,16)
                                }
                            }.padding(.top,16).padding(.bottom, 100)
                        }
                    }
                }.ignoresSafeArea()
            }.background(Color.third)
        }
    }
}

struct Wave: Shape {
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
        
        let waveHeight = 0.01 * rect.height
        let yOffset = CGFloat(1 - newPercent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
        let startAngle = offSet
        let endAngle = offSet + Angle(degrees: 360 + 10)
        
        p.move(to: CGPoint(x: 0, y: yOffset + waveHeight * CGFloat(sin(offSet.radians))))
        
        for angle in stride(
            from: startAngle.degrees,
            through: endAngle.degrees,
            by: 5
        ) {
            let x = CGFloat((angle - startAngle.degrees) / 360) * rect.width
            p.addLine(to: CGPoint(x: x, y: yOffset + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
        }
        
        p.addLine(to: CGPoint(x: rect.width + 300, y: rect.height))
        p.addLine(to: CGPoint(x: -300, y: rect.height))
        p.closeSubpath()
        return p
    }
}

struct Wave2: Shape {
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
        
        let waveHeight = 0.02 * rect.height
        let yOffset = CGFloat(1 - newPercent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
        let startAngle = offSet
        let endAngle = offSet + Angle(degrees: 360 + 10)
        
        p.move(to: CGPoint(x: 0, y: yOffset + waveHeight * CGFloat(sin(offSet.radians))))
        
        for angle in stride(
            from: startAngle.degrees,
            through: endAngle.degrees,
            by: 5
        ) {
            let x = CGFloat((angle - startAngle.degrees) / 360) * rect.width
            p.addLine(to: CGPoint(x: x, y: yOffset + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
        }
        
        p.addLine(to: CGPoint(x: rect.width + 300, y: rect.height+1100))
        p.addLine(to: CGPoint(x: -300, y: rect.height+1100))
        p.closeSubpath()
        return p
    }
}

struct AnimationProperties {
    var yTranslation = 0.0
    var verticalStretch = 1.0
}

#Preview {
    HomePage()
}

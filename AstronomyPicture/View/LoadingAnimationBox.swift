//
//  LoadingAnimationBox.swift
//  AstronomyPicture
//
//  Created by Andrey Kaldyaev on 31.01.2023.
//

import SwiftUI

struct LoadingAnimationBox: View {
    
    let rainbowGradient = Gradient(colors: [
        Color(hue: 1, saturation: 0, brightness: 0.5),
        Color(hue: 1, saturation: 0, brightness: 0.9),
        Color(hue: 1, saturation: 0, brightness: 0.5),
        Color(hue: 1, saturation: 0, brightness: 0.4)
    ])
    
    @State private var startRadius: CGFloat = 10
    
    var body: some View {
        
        GeometryReader { geometry in
            RadialGradient(gradient: self.rainbowGradient,
                           center: UnitPoint(x: 0.5, y: 0.5),
                           startRadius: self.startRadius,
                           endRadius: geometry.size.width * 0.6)
            .onAppear {
                withAnimation(Animation.linear(duration: 1)
                    .repeatForever(autoreverses: true)) {
                        self.startRadius = geometry.size.width * 0.1
                    }
            }
        }
        .frame(maxWidth: 400)
        .scaledToFit()
        
    }
}

struct LoadingAnimationBox_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAnimationBox()
    }
}

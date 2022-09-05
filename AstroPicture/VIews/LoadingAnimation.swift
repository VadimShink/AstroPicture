//
//  LoadingAnimation.swift
//  AstroPicture
//
//  Created by Vadim Shinkarenko on 05.09.2022.
//

import SwiftUI

struct LoadingAnimation: View {
    @State var scale = 1.0

    var body: some View {
        Circle()
            .frame(width: 200, height: 200)
            .scaleEffect(scale)
            .onAppear {
                let baseAnimation = Animation.easeInOut(duration: 1)
                let repeated = baseAnimation.repeatForever(autoreverses: true)

                withAnimation(repeated) {
                    scale = 0.5
                }
            }
    }
}

struct LoadingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAnimation()
    }
}

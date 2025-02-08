//
//  Color+Extensions.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/7/25.
//

import SwiftUI

struct GradientBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 201/255, green: 255/255, blue: 224/255),
                Color(red: 243/255, green: 245/255, blue: 246/255)
            ]),
            startPoint: .bottom,
            endPoint: .top
        )
        .ignoresSafeArea()
    }
}

//extension View {
//    func gradientBackground() -> some View {
//        self.background(
//            LinearGradient(
//                gradient: Gradient(colors: [
//                    Color(red: 201/255, green: 255/255, blue: 224/255),
//                    Color(red: 243/255, green: 245/255, blue: 246/255)
//                ]),
//                startPoint: .bottom,
//                endPoint: .top
//            )
//            .ignoresSafeArea()
//        )
//    }
//}

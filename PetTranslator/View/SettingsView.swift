//
//  SettingsView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/9/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            GradientBackground()
            VStack(spacing: 10) {
                Text("Settings")
                    .font(.system(size: 30, weight: .bold, design: .default))
                Spacer()
                ForEach(0..<7) { _ in
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 50)
                }
                .foregroundStyle(Color(red: 214/255, green: 220/255, blue: 255/255, opacity: 1))
                .padding(.horizontal, 30)
                Spacer()
            }
        }
    }
}

#Preview {
    SettingsView()
}

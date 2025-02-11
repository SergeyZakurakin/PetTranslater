//
//  SettingsView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/9/25.
//

import SwiftUI

struct SettingsView: View {
    
    let settingsOptions = [
            "Rate Us", "Share App", "Contact Us", "Restore Purchases",
            "Privacy Policy", "Terms of Use"
        ]
    
    var body: some View {
        ZStack {
            GradientBackground()
            VStack(spacing: 10) {
                Text("Settings")
                    .foregroundStyle(.black)
                    .font(.system(size: 30, weight: .bold, design: .default))
                Spacer()
                ForEach(settingsOptions, id: \.self) { option in
                    SettingsRowView(title: option) {
                        // tap
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    SettingsView()
}

//
//  SettingsRowView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/9/25.
//

import SwiftUI

struct SettingsRowView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .frame(height: 50)
            .background(Color(red: 214/255, green: 220/255, blue: 255/255))
            .cornerRadius(20)
            .padding(.horizontal, 30)
        }
    }
}

#Preview {
    SettingsRowView(title: "Example", action: {})
}

//
//  ModeSwitchView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/9/25.
//

import SwiftUI

struct ModeSwitchView: View {
    var body: some View {
        HStack(spacing: 30) {
            Text("PET")
            Image(.arrow)
                .frame(width: 24, height: 24)
            Text("HUMAN")
        }
        .font(.custom("konkhmer-sleokchher", size: 16))
        .foregroundStyle(.black)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ModeSwitchView()
}

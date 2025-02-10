//
//  TranslatorTitleView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/9/25.
//

import SwiftUI

struct TranslatorTitleView: View {
    var body: some View {
        Text("Translator")
            .font(.custom("konkhmer-sleokchher", size: 32))
            .foregroundStyle(.black)
            .fontWeight(.bold)
            .padding()
    }
}
#Preview {
    TranslatorTitleView()
}

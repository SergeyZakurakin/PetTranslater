//
//  ResultView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/7/25.
//

import SwiftUI

struct ResultView: View {
    @ObservedObject var viewModel: TranslatorViewModel

    var body: some View {
        VStack {
            Text("Translation Result")
                .font(.title)
                .padding()
            
            Text(viewModel.translatedText)
                .font(.headline)
                .padding()
            
            NavigationLink(destination: TranslatorView()) {
                Text("Back to Home")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    ResultView(viewModel: TranslatorViewModel())
}

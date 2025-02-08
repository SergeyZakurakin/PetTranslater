//
//  ProcessingView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/7/25.
//

import SwiftUI

struct ProcessingView: View {
    @ObservedObject var viewModel: TranslatorViewModel
    @State private var isProcessing = true

    var body: some View {
        VStack {
            Text("Processing...")
                .font(.title)
                .padding()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(2)

            if !isProcessing {
                NavigationLink(destination: ResultView(viewModel: viewModel)) {
                    Text("View Result")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .onAppear {
            viewModel.processTranslation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isProcessing = false
            }
        }
    }
}

#Preview {
    ProcessingView(viewModel: TranslatorViewModel())
}

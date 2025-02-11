//
//  TranslatingView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/10/25.
//


import SwiftUI

struct TranslatingView: View {
    @StateObject var viewModel: TranslatingViewModel
    @State private var shouldNavigateToResult = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                GradientBackground()
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    if viewModel.text.isEmpty {
                        Text("Translating audio...")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding(.bottom, 20)
                    } else {
                        Text(viewModel.text)
                            .font(.title2)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    Spacer()
                    Spacer()
                    viewModel.animal.image
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding(.top, 51)
                    Spacer()
                    
                }
            }
            .task {
                do {
                    try await viewModel.translateAudio()
                    shouldNavigateToResult = true
                } catch {
                    print("Error: \(error)")
                }
            }
            .background(
                NavigationLink(
                    "",
                    destination: ResultView(viewModel: .init(text: viewModel.text), selectedAnimal: viewModel.animal),
                    isActive: $shouldNavigateToResult
                )
            )
        }
    }
}

#Preview {
    TranslatingView(viewModel: TranslatingViewModel(audioURL: URL(string: "file://dummy")!, animal: .dog))
}

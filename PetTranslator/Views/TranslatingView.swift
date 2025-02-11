//
//  TranslatingView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/10/25.
//


import SwiftUI

final class TranslatingViewModel: ObservableObject {
    let audioURL: URL
    let animal: Animal
    let translator: TranslatorProtocol
    @Published var text: String = ""
    
    init(audioURL: URL, animal: Animal, translator: TranslatorProtocol = SimpleTranslator()) {
        self.audioURL = audioURL
        self.animal = animal
        self.translator = translator
    }
    
    func translateAudio() async throws {
        let data = try? Data(contentsOf: audioURL)
        let result = try await translator.translate(audio: data ?? Data(), animal: animal)
        sleep(2)
        await updateText(result)
    }
    
    @MainActor
    func updateText(_ text: String) {
        self.text = text
    }
}

struct TranslatingView: View {
    @StateObject var viewModel: TranslatingViewModel
    @State private var shouldNavigateToResult = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                GradientBackground()
                    .ignoresSafeArea()
                
                VStack {
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

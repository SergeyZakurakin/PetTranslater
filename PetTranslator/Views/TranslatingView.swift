//
//  TranslatingView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/10/25.
//

import SwiftUI

final class TranslatingViewModel: ObservableObject {
    static var `default` = TranslatingViewModel(audioURL: URL.applicationDirectory)
    let audioURL: URL
    let animal: Animal
    let translator: TranslatorProtocol
    @Published var text: String = ""
    
    init(audioURL: URL, animal: Animal = .dog, translator: TranslatorProtocol = SimpleTranslator()) {
        self.audioURL = audioURL
        self.animal = animal
        self.translator = translator
    }
    
    func traslateAudio() async throws {
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
            VStack {
                if viewModel.text != "" {
                    Text(viewModel.text)
                } else {
                    Text("Translating audio....")
                }
                viewModel.animal.image
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding()
                    .padding(.top, 51)
            }
        }
        .task {
                    do {
                        try await viewModel.traslateAudio()
                        shouldNavigateToResult = true
                    } catch {
                        print("Error: \(error)")
                    }
                
            }
            .background(
                NavigationLink("",
                               destination: ResultView(viewModel: .init(text: viewModel.text), selectedAnimal: viewModel.animal),
                               isActive: $shouldNavigateToResult)
            )
    }
}

#Preview {
    TranslatingView(viewModel: .default)
}

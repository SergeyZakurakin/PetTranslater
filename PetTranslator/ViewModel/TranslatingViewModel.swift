//
//  TranslatingViewModel.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/11/25.
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

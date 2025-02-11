//
//  ResultViewModel.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/9/25.
//

import SwiftUI

final class ResultViewModel: ObservableObject {
    let text: String
    
    init(text: String) {
        self.text = text
    }
    
    @Published var randomPhrase: String = ""
    
    private let dogPhrases = [
        "I'm hungry, feed me!",
        "Let's go for a walk!",
        "Did you bring me a treat?",
        "Stop working, pet me!",
        "Throw the ball, human!"
    ]
    
    private let catPhrases = [
        "What are you doing, human?",
        "I demand more food!",
        "Leave me alone, I’m sleeping.",
        "Stop touching me!",
        "Pet me… but only for 5 seconds."
    ]
    
//    func generateRandomPhrase(for animal: Animal) async throws -> String {
//        try await translator.translate(audio: Data(), animal: animal)
//    }
}

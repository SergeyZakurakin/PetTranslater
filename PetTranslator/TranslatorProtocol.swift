//
//  TranslatorProtocol.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/10/25.
//

import Foundation
import SwiftUICore

public enum Animal: String {
    case dog
    case cat
    
    var image: Image {
        Image(self.rawValue)
    }
    
    /// TODO
    var iconImage200PaddingTop51: any View {
        Image(self.rawValue)
            .resizable()
            .frame(width: 200, height: 200)
            .padding()
            .padding(.top, 51)
    }
}

public protocol TranslatorProtocol {
    func translate(audio: Data, animal: Animal) async throws -> String
    
}

class SimpleTranslator: TranslatorProtocol {
    private var dictionary: [Animal: [String]] = [:]
    
    init() {
        // загрузить из локального файла перевод
        let dogPhrases = [
            "I'm hungry, feed me!",
            "Let's go for a walk!",
            "Did you bring me a treat?",
            "Stop working, pet me!",
            "Throw the ball, human!"
        ]
        
        let catPhrases = [
            "What are you doing, human?",
            "I demand more food!",
            "Leave me alone, I’m sleeping.",
            "Stop touching me!",
            "Pet me… but only for 5 seconds."
        ]
        self.dictionary = [
            .dog : dogPhrases,
            .cat : catPhrases,
            ]
    }
    
    func translate(audio: Data, animal: Animal) async throws -> String {
        let reult = dictionary[animal, default: []].randomElement() ?? ""
        return reult
    }
}

class AnimalTranslator: TranslatorProtocol {
    func translate(audio: Data, animal: Animal) async throws -> String {
        return "\(animal)"
    }
    
    
}

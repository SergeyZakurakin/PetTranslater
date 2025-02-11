//
//  PetTranslatorApp.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/7/25.
//

import SwiftUI

@main
struct PetTranslatorApp: App {
    @StateObject var animalViewModel = AnimalSelectionViewModel()
    
    var body: some Scene {
        WindowGroup {
            TranslatorView()
                .environmentObject(animalViewModel) // Передаем в среду
        }
    }
}

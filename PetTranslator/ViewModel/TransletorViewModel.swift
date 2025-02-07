//
//  TransletorViewModel.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/7/25.
//

import SwiftUI
import AVFoundation

class TranslatorViewModel: ObservableObject {
    @Published var isAnimalMode = false
    @Published var selectedAnimal = "dog"
    @Published var isRecording = false
    @Published var translatedText = ""
    
//    private let recorder = AudioRecorder()

    func toggleAnimalMode() {
        isAnimalMode.toggle()
    }
    
    func selectAnimal(_ animal: String) {
        selectedAnimal = animal
    }
    
//    func startRecording() {
//        recorder.startRecording()
//        isRecording = recorder.isRecording
//    }
    
//    func stopRecording() {
//        recorder.stopRecording()
//        isRecording = recorder.isRecording
//    }
    
    func processTranslation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.translatedText = self.isAnimalMode ? "Woof woof! (I'm hungry)" : "Hello! Feed me!"
        }
    }
}

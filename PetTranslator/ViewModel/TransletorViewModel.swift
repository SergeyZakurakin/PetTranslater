//
//  TransletorViewModel.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/7/25.
//

import SwiftUI
import AVFoundation

final class TranslatorViewModel: ObservableObject {
    @Published var isAnimalMode = false
    @Published var selectedAnimal = "dog"
    @Published var isRecording = false
    @Published var translatedText = ""
    @Published var isMicrophoneGranted = false
    @Published var shouldNavigateToProcessing = false
    
    private let recorder = AudioRecorder()

    func toggleAnimalMode() {
        isAnimalMode.toggle()
    }
    
    func selectAnimal(_ animal: String) {
        selectedAnimal = animal
    }
    
    func startRecording() {
        recorder.startRecording()
        isRecording = recorder.isRecording
    }
    
    func stopRecording() {
        recorder.stopRecording()
        isRecording = recorder.isRecording
    }
    
    func processTranslation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.translatedText = self.isAnimalMode ? "Woof woof! (I'm hungry)" : "Hello! Feed me!"
        }
    }
    
    // Новый метод для запроса доступа к микрофону
    func requestMicrophoneAccess(completion: @escaping (Bool) -> Void) {
        AVAudioSession.sharedInstance().requestRecordPermission { [weak self] granted in
            DispatchQueue.main.async {
                self?.isMicrophoneGranted = granted
                print(granted ? "Microphone access granted" : "Microphone access denied")
                completion(granted)
            }
        }
    
    }
    func navigateToProcessingView() {
        shouldNavigateToProcessing = true
    }
}

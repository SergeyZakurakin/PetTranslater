//
//  ProcessingViewModel.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/8/25.
//

import SwiftUI
import AVFoundation

class ProcessingViewModel: ObservableObject {
    @Published var isProcessing = true
    @Published var fillWidth: CGFloat = 0
    @Published var isRecording = false
    @Published var recordedAudioURL: URL?
    @Published var randomPhrase = ""
    @Published var selectedAnimal: String = "dog"
    
    private var recorder: AVAudioRecorder?
    
    let dogPhrases = ["Woof! Woof!", "Bark! Bark!", "Arf! Arf!"]
    let catPhrases = ["Meow! Meow!", "Purr... Purr...", "Hiss! Hiss!"]
    
    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.playAndRecord, mode: .default)
        try? audioSession.setActive(true)
        
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        let fileURL = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        do {
            recorder = try AVAudioRecorder(url: fileURL, settings: settings)
            recorder?.record()
            isRecording = true
        } catch {
            print("Recording failed: \(error)")
        }
    }
    
    func stopRecording(animal: String) {
        recorder?.stop()
        isRecording = false
        
        // проверка работает ли запись
        if let recordedURL = recorder?.url {
            print("Запись сохранена по пути: \(recordedURL)")
        } else {
            print("Ошибка: Файл записи не создан.")
        }
        
        // Генерация случайной фразы
        if animal == "dog" {
            randomPhrase = dogPhrases.randomElement() ?? "Woof!"
        } else if animal == "cat" {
            randomPhrase = catPhrases.randomElement() ?? "Meow!"
        }
        
        recordedAudioURL = recorder?.url
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // Логика анимации и статуса обработки
    func startProcessingAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation {
                self.fillWidth = 163 // Максимальная ширина для заливки
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isProcessing = false
        }
    }
}

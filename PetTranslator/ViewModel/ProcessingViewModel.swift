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
        DispatchQueue.main.async {
            if let recordedURL = self.recorder?.url {
                print("Запись сохранена по пути: \(recordedURL)")
            } else {
                print("Ошибка: Файл записи не создан.")
            }
            
            // Генерация случайной фразы
            if animal == "dog" {
                self.randomPhrase = self.dogPhrases.randomElement() ?? "Woof!"
            } else if animal == "cat" {
                self.randomPhrase = self.catPhrases.randomElement() ?? "Meow!"
            }
            
            self.objectWillChange.send() // Уведомляем SwiftUI об изменении
            print("Сгенерированная фраза: \(self.randomPhrase)")
        }
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

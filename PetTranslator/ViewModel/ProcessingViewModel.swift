//
//  ProcessingViewModel.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/8/25.
//

import SwiftUI
import AVFoundation

final class ProcessingViewModel: ObservableObject {
    @Published var isProcessing = true
    @Published var fillWidth: CGFloat = 0
    @Published var isRecording = false
    @Published var recordedAudioURL: URL?
    @Published var randomPhrase = ""
    @Published var selectedAnimal: String = "dog"
    
    private var recorder: AVAudioRecorder?
    
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
            print("Ошибка при записи: \(error)")
        }
    }
    
    func stopRecording() {
        recorder?.stop()
        isRecording = false
        
        // Проверка, сохранён ли файл
        DispatchQueue.main.async {
            if let recordedURL = self.recorder?.url {
                print("Запись сохранена по пути: \(recordedURL)")
            } else {
                print("Ошибка: Файл записи не был создан.")
            }
            
            self.objectWillChange.send()
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
                self.fillWidth = 163
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isProcessing = false
        }
    }
}

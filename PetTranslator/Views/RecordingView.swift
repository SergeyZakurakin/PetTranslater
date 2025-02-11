//
//  RecordingView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/7/25.
//

// RecordingView.swift
// RecordingView.swift
import SwiftUI

struct RecordingView: View {
    @ObservedObject var viewModel: TranslatorViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("recordingScreen")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
            .onAppear {
                checkMicrophoneAccess()
            }
            .navigationDestination(isPresented: $viewModel.shouldNavigateToProcessing) {
                // Передаем selectedAnimal как Binding<Animal>
                ProcessingView(viewModel: ProcessingViewModel(), selectedAnimal: $viewModel.selectedAnimal)
            }
        }
    }
    
    private func checkMicrophoneAccess() {
        viewModel.requestMicrophoneAccess { granted in
            DispatchQueue.main.async {
                if granted {
                    viewModel.isRecording = true
                    viewModel.shouldNavigateToProcessing = true
                } else {
                    dismiss() // Закрыть экран, если доступ отклонен
                }
            }
        }
    }
}

#Preview {
    RecordingView(viewModel: TranslatorViewModel())
}

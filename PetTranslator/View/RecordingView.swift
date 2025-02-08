//
//  RecordingView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/7/25.
//

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
                       ProcessingView(viewModel: viewModel)
                   }
               }
           }
    
    private func checkMicrophoneAccess() {
        viewModel.requestMicrophoneAccess { granted in
            DispatchQueue.main.async {
                if granted {
                    viewModel.isRecording = true
                    viewModel.shouldNavigateToProcessing = true // Перейти дальше
                } else {
                    dismiss() // Закрыть экран, если отказ
                }
            }
        }
    }
}

#Preview {
    RecordingView(viewModel: TranslatorViewModel())
}


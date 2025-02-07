//
//  RecordingView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/7/25.
//

import SwiftUI

struct RecordingView: View {
    @ObservedObject var viewModel: TranslatorViewModel

    var body: some View {
        VStack {
            Text("Recording...")
                .font(.title)
                .padding()
            
            Button(action: {
                if viewModel.isRecording {
                    viewModel.stopRecording()
                } else {
                    viewModel.startRecording()
                }
            }) {
                Image(systemName: viewModel.isRecording ? "stop.circle.fill" : "mic.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding()
            }
            
            if !viewModel.isRecording {
                NavigationLink(destination: ProcessingScreen(viewModel: viewModel)) {
                    Text("Process Recording")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}


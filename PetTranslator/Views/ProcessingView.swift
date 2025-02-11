//
//  ProcessingView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/7/25.
//

// ProcessingView.swift
import SwiftUI

struct ProcessingView: View {
    @ObservedObject var viewModel: ProcessingViewModel
    @Binding var selectedAnimal: Animal // Теперь это Binding<Animal>
    @State private var selectedTab: Int = 0
    @State private var shouldNavigateToResult = false
    @State private var isSettingsActive: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                GradientBackground()
                    .ignoresSafeArea()
                
                VStack {
                    TranslatorTitleView()
                    ModeSwitchView()
                    
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                                .frame(width: 178, height: 176)
                                .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
                            HStack {
                                ZStack {
                                    LinearGradient(gradient: Gradient(colors: [.blue, .blue]), startPoint: .leading, endPoint: .trailing)
                                        .frame(width: viewModel.fillWidth, height: 70)
                                        .cornerRadius(16)
                                        .animation(.easeInOut(duration: 3), value: viewModel.fillWidth)
                                        .mask(
                                            Image(.wave)
                                                .resizable()
                                                .frame(width: 163, height: 100)
                                        )
                                }
                            }
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                                .frame(width: 107, height: 176)
                                .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
                            VStack {
                                Button(action: { selectedAnimal = .dog }) {
                                    Image(.pet1)
                                        .resizable()
                                        .frame(width: 83, height: 70)
                                        .opacity(selectedAnimal == .dog ? 1.0 : 0.5)
                                }
                                
                                Button(action: { selectedAnimal = .cat }) {
                                    Image(.pet2)
                                        .resizable()
                                        .frame(width: 83, height: 70)
                                        .opacity(selectedAnimal == .cat ? 1.0 : 0.5)
                                }
                            }
                        }
                    }
                    .padding(.top, 58)
                    
                    Image(selectedAnimal.rawValue)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding()
                        .padding(.top, 51)
                    
                    Spacer()
                    
                    if viewModel.isProcessing {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(2)
                            .padding(.vertical, 20)
                    }
                }
                .padding(.horizontal, 20)
                
                VStack {
                    Spacer()
                    CustomTabBar(selectedTab: $selectedTab, isSettingsActive: $isSettingsActive)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 20)
                }
            }
            .navigationBarHidden(true)
            .background(
                NavigationLink(
                    destination: TranslatingView(viewModel: .init(audioURL: viewModel.recordedAudioURL ?? .desktopDirectory)),
                    isActive: $shouldNavigateToResult,
                    label: { EmptyView() }
                )
            )
        }
        .onAppear {
            viewModel.startProcessingAnimation()
            
            viewModel.startRecording()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                viewModel.stopRecording()
                shouldNavigateToResult = true
            }
        }
    }
}

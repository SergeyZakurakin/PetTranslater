//
//  ProcessingView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/7/25.
//

import SwiftUI

struct ProcessingView: View {
    @ObservedObject var viewModel: ProcessingViewModel
    @State private var selectedAnimal = Animal.cat
    @State private var selectedTab: Int = 0
    @State private var shouldNavigateToResult = false
    @State private var isSettingsActive: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Градиентный фон на весь экран
                GradientBackground()
                    .ignoresSafeArea()
                
                // Основной контент
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
                                Button(action: { viewModel.selectedAnimal = "dog" }) {
                                    Image(.pet1)
                                        .resizable()
                                        .frame(width: 83, height: 70)
                                        .opacity(viewModel.selectedAnimal == "dog" ? 1.0 : 0.5)
                                }
                                
                                Button(action: { viewModel.selectedAnimal = "cat" }) {
                                    Image(.pet2)
                                        .resizable()
                                        .frame(width: 83, height: 70)
                                        .opacity(viewModel.selectedAnimal == "cat" ? 1.0 : 0.5)
                                }
                            }
                        }
                    }
                    .padding(.top, 58)
                    
                    // Иконка выбранного животного
                    Image(viewModel.selectedAnimal == "dog" ? "cat" : "dog")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding()
                        .padding(.top, 51)
                    
                    Spacer()
                    
                    // Статус обработки
                    if viewModel.isProcessing {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(2)
                            .padding(.vertical, 20)
                    }
                }
                .padding(.horizontal, 20)
                
                // Кастомный таббар
                VStack {
                    Spacer()
                    CustomTabBar(selectedTab: $selectedTab, isSettingsActive: $isSettingsActive)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 20)
                }
            }
            .navigationBarHidden(true)
            .background(
                // !!!!!!!!!! Recorded audio URL
                // Скрытый NavigationLink для автоматического перехода
                NavigationLink(
                    destination:
//                        ResultView(viewModel: ResultViewModel(audioURL: viewModel.recordedAudioURL!), selectedAnimal: selectedAnimal),
                    TranslatingView(viewModel: .init(audioURL: viewModel.recordedAudioURL ?? .desktopDirectory, animal: selectedAnimal)),
                    isActive: $shouldNavigateToResult,
                    label: { EmptyView() }
                )
            )
        }
        .onAppear {
            viewModel.startProcessingAnimation()
            
            // Начинаем запись через 4 секунды
            viewModel.startRecording()
            
            // Автоматический переход через 4 секунды
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                viewModel.stopRecording()
                shouldNavigateToResult = true
            }
        }
    }
}

#Preview {
    ProcessingView(viewModel: ProcessingViewModel())
}

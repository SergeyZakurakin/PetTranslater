//
//  ProcessingView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/7/25.
//

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

                    // Блок с волной и кнопками выбора животного
                    HStack {
                        // Волна
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                                .frame(width: 178, height: 176)
                                .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)

                            // Анимация заполнения волны
                            ZStack {
                                LinearGradient(gradient: Gradient(colors: [.blue, .blue]),
                                               startPoint: .leading, endPoint: .trailing)
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

                        // Блок с кнопками выбора животного
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                                .frame(width: 107, height: 176)
                                .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)

                            VStack {
                                    Image(.pet1)
                                        .resizable()
                                        .frame(width: 83, height: 70)
                                        .opacity(0.5)
                                

                                    Image(.pet2)
                                        .resizable()
                                        .frame(width: 83, height: 70)
                                        .opacity(0.5)
                                }
                            
                        }
                    }
                    .padding(.top, 58)

                    // Изображение выбранного животного
                    selectedAnimal.image
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding(.top, 51)

                    if viewModel.isProcessing {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(2)
                            .padding(.vertical, 20)
                    }
                }
                .padding(.horizontal, 20)

                // TabBar внизу
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
                    destination: TranslatingView(
                        viewModel: TranslatingViewModel(
                            audioURL: viewModel.recordedAudioURL ?? URL(fileURLWithPath: "/tmp/audio.m4a"),
                            animal: selectedAnimal
                        )
                    ),
                    isActive: $shouldNavigateToResult,
                    label: { EmptyView() }
                )
            )
        }
        .onAppear {
            viewModel.startProcessingAnimation()
            viewModel.startRecording()

            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                viewModel.stopRecording()
                shouldNavigateToResult = true
            }
        }
    }
}


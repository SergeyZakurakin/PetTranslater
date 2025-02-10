//
//  ProcessingView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/7/25.
//

import SwiftUI

struct ProcessingView: View {
    @ObservedObject var viewModel: ProcessingViewModel
    @State private var selectedAnimal: String = "dog"
    @State private var selectedTab: Int = 0 // Состояние для таббара
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
                    Text("Translator")
                        .font(.custom("konkhmer-sleokchher", size: 32))
                        .foregroundStyle(.black)
                        .fontWeight(.bold)
                        .padding()
                    
                    // Переключатель "Человек / Животное"
                    HStack(spacing: 30) {
                        Text("PET")
                        Image(.arrow) // Замените на вашу иконку стрелки
                            .frame(width: 24, height: 24)
                        Text("HUMAN")
                    }
                    .font(.custom("konkhmer-sleokchher", size: 16))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    
                    // Секция для кнопки записи
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
                                        .cornerRadius(16) // Маска для округлых краев
                                        .animation(.easeInOut(duration: 3), value: viewModel.fillWidth) // Анимация
                                        .mask(
                                            Image(.wave)
                                                .resizable()
                                                .frame(width: 163, height: 100)
                                        ) // Маска с иконкой волны
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
                    Spacer() // Размещаем таббар внизу
                    CustomTabBar(selectedTab: $selectedTab, isSettingsActive: $isSettingsActive)
                        .padding(.horizontal, 40) // Отступы по бокам
                        .padding(.bottom, 20) // Отступ снизу
                }
            }
            .navigationBarHidden(true) // Скрываем навигационную панель
            .background(
                // Скрытый NavigationLink для автоматического перехода
                NavigationLink(
                    destination: ResultView(viewModel: ResultViewModel(), selectedAnimal: selectedAnimal),
                    isActive: $shouldNavigateToResult,
                    label: { EmptyView() }
                )
            )
        }
        .onAppear {
            viewModel.startProcessingAnimation()
            
            // Автоматический переход через 4 секунды
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                shouldNavigateToResult = true
            }
        }
    }
}

#Preview {
    ProcessingView(viewModel: ProcessingViewModel())
}

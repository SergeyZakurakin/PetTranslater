//
//  TranslatorView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/7/25.
//

import SwiftUI

struct TranslatorView: View {
    @EnvironmentObject var animalViewModel: AnimalSelectionViewModel
    @StateObject var viewModel = TranslatorViewModel()
    @State private var selectedTab = 0
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
                    
                    // Кнопки записи и выбора животного
                    HStack {
                        NavigationLink(destination: RecordingView(viewModel: viewModel)) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white)
                                    .frame(width: 178, height: 176)
                                    .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
                                VStack {
                                    Image(.microphone2)
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .padding()
                                    Text("Start to speak")
                                        .foregroundStyle(.black)
                                        .font(.custom("konkhmer-sleokchher", size: 16))
                                }
                            }
                        }
                        
                        ZStack {
                            AnimalSelectionView(selectedAnimal: $viewModel.selectedAnimal)
                        }
                    }
                    .padding(.top, 58)
                    
                    // Большая иконка выбранного животного
                    Image(viewModel.selectedAnimal == "dog" ? "cat" : "dog")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding()
                        .padding(.top, 51)
                    
                    Spacer()
                }
                
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
                // Скрытый NavigationLink для перехода на SettingsView
                NavigationLink(
                    destination: SettingsView(),
                    isActive: $isSettingsActive,
                    label: { EmptyView() }
                )
            )
        }
    }
}

#Preview {
    TranslatorView()
}

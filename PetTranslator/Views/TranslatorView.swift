//
//  TranslatorView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/7/25.
//

// TranslatorView.swift
import SwiftUI

struct TranslatorView: View {
    @StateObject var viewModel = TranslatorViewModel()
    @State private var selectedTab = 0
    @State private var isSettingsActive: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                GradientBackground()
                    .ignoresSafeArea()
                
                VStack {
                    TranslatorTitleView()
                    ModeSwitchView()
                    
                    // Кнопки записи и выбора животного
                    HStack {
                        // Кнопка для записи, передаем viewModel как параметр
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
                        
                        // Передаем привязку selectedAnimal в AnimalSelectionView
                        AnimalSelectionView(selectedAnimal: $viewModel.selectedAnimal)
                            .padding(.top, 58)
                        
                        // Иконка выбранного животного
                        AnimalIconView(animal: viewModel.selectedAnimal)
                        
                        Spacer()
                    }
                    
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
}

#Preview {
    TranslatorView()
}

//
//  ResultView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/7/25.
//

import SwiftUI

struct ResultView: View {
    @ObservedObject var viewModel: ResultViewModel
    @Environment(\.dismiss) var dismiss // Для закрытия экрана
    
    var selectedAnimal: String

    var body: some View {
        ZStack {
            GradientBackground() // Градиентный фон
            
            VStack {
                // Верхний заголовок с крестиком
                HStack {
                    // Кнопка закрытия
                    Button(action: {
                        dismiss()
                    }) {
                        ZStack {
                            Circle()
                                .foregroundStyle(.white)
                                .frame(width: 48, height: 48)
                            
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.black)
                        }
                    }
                    Spacer()
                    // Заголовок по центру
                    Text("Result")
                        .foregroundColor(.black)
                        .font(.title)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 50) // Смещаем вверх
                
                Spacer(minLength: 20) // Регулируемый отступ вниз
                
                // Блок с текстом
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(red: 214/255, green: 220/255, blue: 255/255, opacity: 1))
                        .frame(width: 291, height: 142)
                    
                    // Иконка polygon справа
                    Image(.polygon)
                        .offset(x: 100, y: 120)
                    
                    Text(viewModel.randomPhrase)
                        .font(.headline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: 250)
                        .offset(y: -10)
                }
                
                Spacer(minLength: 20) // Регулируемый отступ вниз
                
                // Иконка животного
                Image(selectedAnimal == "dog" ? "dog" : "cat")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 184, height: 184)
                    .padding()
                
                Spacer()
            }
            .padding(.top, 20) // Дополнительный отступ вверх
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.generateRandomPhrase(for: selectedAnimal)
            print("ResultView: \(viewModel.randomPhrase)")
        }
    }
}

#Preview {
    ResultView(viewModel: ResultViewModel(), selectedAnimal: "dog")
}

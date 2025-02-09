//
//  TranslatorView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/7/25.
//

import SwiftUI

struct TranslatorView: View {
    @StateObject var viewModel = TranslatorViewModel()
    
    var body: some View {
            NavigationStack {
                VStack {
                    Text("Translator")
                        .font(.custom("konkhmer-sleokchher", size: 32))
                        .foregroundStyle(.black)
                        .fontWeight(.bold)
                        .padding()
                    
                    // Переключатель "Человек / Животное"
                    
                    HStack(spacing: 30) {
                        Text("HUMAN")
                        Image(.arrow)
                            .frame(width: 24, height: 24)
                        Text("PET")
                    }
                    .font(.custom("konkhmer-sleokchher", size: 16))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    
                    
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
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                                .frame(width: 107, height: 176)
                                .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
                            VStack {
                                Button(action: { viewModel.selectAnimal("dog") }) {
                                    Image(.pet1)
                                        .resizable()
                                        .frame(width: 83, height: 70)
                                        .opacity(viewModel.selectedAnimal == "dog" ? 1.0 : 0.5)
                                }
                                
                                Button(action: { viewModel.selectAnimal("cat") }) {
                                    Image(.pet2)
                                        .resizable()
                                        .frame(width: 83, height: 70)
                                        .opacity(viewModel.selectedAnimal == "cat" ? 1.0 : 0.5)
                                }
                            }
                        }
                    }
                    .padding(.top, 58)
                    
                    // Большая иконка выбранного животного
                    Image(viewModel.selectedAnimal == "dog" ? "dog" : "cat")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding()
                        .padding(.top, 51)
                    
                    Spacer()
                }
                .background(GradientBackground())
            }
    }
}

#Preview {
    TranslatorView()
}


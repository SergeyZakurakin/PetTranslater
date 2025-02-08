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
        
        
        ZStack {
            
            NavigationView {
                VStack {
                    Text("Translator")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    // Переключатель "Человек / Животное"
                    
                    HStack {
                        Text("HUMAN")
                        Text("&&")
                        Text("PET")
                    }
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity)
                    
                    
                    HStack {
                        NavigationLink(destination: RecordingView(viewModel: viewModel)) {
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                                    .frame(width: 178, height: 176)
                                    .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
                                VStack {
                                    Image("microphone-2")
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .padding()
                                    Text("Start to speak")
                                        .foregroundStyle(.black)
                                        .fontWeight(.bold)
                                }
                            }
                        }
                        
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .frame(width: 107, height: 176)
                                .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
                            VStack {
                                Button(action: { viewModel.selectAnimal("dog") }) {
                                    Image("Pet1")
                                        .resizable()
                                        .frame(width: 83, height: 70)
                                        .opacity(viewModel.selectedAnimal == "dog" ? 1.0 : 0.5)
                                }
                                
                                Button(action: { viewModel.selectAnimal("cat") }) {
                                    Image("Pet2")
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
                    
                    // Кнопка "Микрофон"
                    
                    
                    Spacer()
                }
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 201/255, green: 255/255, blue: 224/255),
                            Color(red: 243/255, green: 245/255, blue: 246/255)
                        ]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    
                    .ignoresSafeArea()
                )
            }
        }
    }
}

#Preview {
    TranslatorView()
}


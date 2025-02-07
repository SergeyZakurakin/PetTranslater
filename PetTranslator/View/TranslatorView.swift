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
                            Image(systemName: "mic.fill")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .padding()
                        }
                        
                        
                        VStack {
                            Button(action: { viewModel.selectAnimal("dog") }) {
                                Image(systemName: "dog.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .opacity(viewModel.selectedAnimal == "dog" ? 1.0 : 0.5)
                            }
                            .padding()
                            
                            Button(action: { viewModel.selectAnimal("cat") }) {
                                Image(systemName: "cat.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .opacity(viewModel.selectedAnimal == "cat" ? 1.0 : 0.5)
                            }
                            .padding()
                        }
                    }
                    .padding(.top, 58)
                    
                    // Большая иконка выбранного животного
                    Image(systemName: viewModel.selectedAnimal == "dog" ? "dog.fill" : "cat.fill")
                        .resizable()
                        .frame(width: 150, height: 150)
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


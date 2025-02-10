//
//  CustomTabBar.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/9/25.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    @Binding var isSettingsActive: Bool
    
    var body: some View {
        ZStack {
            // Фон только внутри фрейма
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(radius: 5) // Тень
                .frame(width: 216, height: 82) // Размер фрейма
            
            // Контент таббара
            HStack {
                // Первая иконка
                Button(action: {
                    selectedTab = 0
                }) {
                    VStack {
                        Image(.messages)
                            .font(.system(size: 24))
                            .opacity(selectedTab == 0 ? 1.0 : 0.5) // Прозрачность для неактивной иконки
                        
                        Text("Translator")
                            .font(.custom("konkhmer-sleokchher", size: 16))
                            .opacity(selectedTab == 0 ? 1.0 : 0.5) // Прозрачность для неактивного текста
                    }
                    .foregroundStyle(.black) // Черный цвет иконки и текста
                }
                .frame(maxWidth: .infinity)
                
                // Вторая иконка
                Button(action: {
                    selectedTab = 1
                    isSettingsActive = true // Активируем переход на SettingsView
                }) {
                    VStack {
                        Image(.settings)
                            .font(.system(size: 24))
                            .opacity(selectedTab == 1 ? 1.0 : 0.5) // Прозрачность для неактивной иконки
                        
                        Text("Clicker")
                            .font(.custom("konkhmer-sleokchher", size: 16))
                            .opacity(selectedTab == 1 ? 1.0 : 0.5) // Прозрачность для неактивного текста
                    }
                    .foregroundStyle(.black) // Черный цвет иконки и текста
                }
                .frame(maxWidth: .infinity)
            }
            .frame(width: 216, height: 82) // Размер контента таббара
        }
        .background(Color.clear) // Прозрачный фон
    }
}

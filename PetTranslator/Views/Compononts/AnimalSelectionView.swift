//
//  AnimalSelectionView.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/9/25.
//

import SwiftUI

struct AnimalSelectionView: View {
    @Binding var selectedAnimal: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .frame(width: 107, height: 176)
                .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
            VStack {
                Button(action: { selectedAnimal = "dog" }) {
                    Image(.pet1)
                        .resizable()
                        .frame(width: 83, height: 70)
                        .opacity(selectedAnimal == "dog" ? 1.0 : 0.5)
                }
                
                Button(action: { selectedAnimal = "cat" }) {
                    Image(.pet2)
                        .resizable()
                        .frame(width: 83, height: 70)
                        .opacity(selectedAnimal == "cat" ? 1.0 : 0.5)
                }
            }
        }
    }
}

//#Preview {
//    AnimalSelectionView(selectedAnimal:)
//}

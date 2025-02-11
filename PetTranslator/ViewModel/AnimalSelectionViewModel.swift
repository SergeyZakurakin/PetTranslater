//
//  AnimalSelectionViewModel.swift
//  PetTranslator
//
//  Created by Sergey Zakurakin on 2/11/25.
//

import Foundation


final class AnimalSelectionViewModel: ObservableObject {
    @Published var selectedAnimal: Animal = .dog // Значение по умолчанию
}

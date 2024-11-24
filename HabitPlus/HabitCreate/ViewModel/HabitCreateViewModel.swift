//
//  HabitCreateViewModel.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 23/11/24.
//

import Foundation
import SwiftUI
import Combine

class HabitCreateViewModel: ObservableObject {
    @Published var uiState: HabitCreateUIState = .none
    @Published var name: String = ""
    @Published var label: String = ""
    
    @Published var image: Image? = Image(systemName: "camera.fill")
    @Published var imageData: Data? = nil
    @Published var shouldPresentCamera = false
    
    private var cancellable: AnyCancellable?
    var habitPublisher: PassthroughSubject<Bool, Never>?
    
    let interactor: HabitCreateInteractor
    
    init(interactor: HabitCreateInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
    }
    
}

extension HabitCreateViewModel {
    func save() {
        self.uiState = .loading
        
        cancellable = interactor.save(habitCreateRequest: HabitCreateRequest(imageData: imageData, name: name, label: label))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: {
                self.uiState = .success
                self.habitPublisher?.send(true)
            })
    }
}

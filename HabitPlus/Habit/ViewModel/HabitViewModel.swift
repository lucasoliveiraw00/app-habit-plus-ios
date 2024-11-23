//
//  HabitViewModel.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 12/11/24.
//

import Foundation
import Combine
import SwiftUI

class HabitViewModel: ObservableObject {
    
    @Published var uiState: HabitUIState = .loading
    
    @Published var title = ""
    @Published var headline = ""
    @Published var desc = ""
    
    @Published var showErrorAlert: Bool = false
    @Published var opened: Bool = false
    
    private var cancellable: AnyCancellable?
    private var cancellableNotify: AnyCancellable?
    private let interactor: HabitInteractor
    
    private let habitPublisher = PassthroughSubject<Bool, Never>()
    
    let isChart: Bool
    
    init (isChart: Bool, interactor: HabitInteractor) {
        self.isChart = isChart
        self.interactor = interactor
        
        cancellableNotify = habitPublisher.sink(
            receiveValue: { saved in
                self.onAppear()
            }
        )
    }
    
    deinit {
        cancellable?.cancel()
    }
    
}

extension HabitViewModel {
    var errorMessage: String {
        if case let HabitUIState.error(msg) = uiState {
            return msg
        }
        return "Erro desconhecido"
    }
    
    func onAppearAlert() {
        if case .error = uiState {
            showErrorAlert = true
        }
    }
    
    func resetState() {
        uiState = .emptyList
        showErrorAlert = false
    }
}


extension HabitViewModel {
    func onAppear() {
        self.uiState = .loading
        self.opened = true
        
        cancellable = interactor.fetchHabits()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: { response in
                if response.isEmpty {
                    self.uiState = .emptyList
                    
                    self.title = ""
                    self.headline = "Fique ligado!"
                    self.desc = "Você ainda não possui hábitos"
                } else {
                    self.uiState = .fullList(
                        response.map {
                            let lastDate = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss", destPattern: "dd/MM/yyyy HH:mm") ?? ""
                            let lastDateCompare = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss") ?? Date()
                            
                            var state = Color.green
                            self.title = "Muito Bom!"
                            self.headline = "Seus hábitos estão em dia"
                            self.desc = ""
                            
                            
                            if lastDateCompare < Date() {
                                state = Color.red
                                self.title = "Atenção"
                                self.headline = "Fique ligado!"
                                self.desc = "Você está atrasado nos hábitos"
                            }
                            
                            return HabitCardViewModel(
                                id: $0.id,
                                icon: $0.iconUrl ?? "",
                                date: lastDate,
                                name: $0.name,
                                label: $0.label,
                                value: "\($0.value ?? 0)",
                                state: state,
                                habitPublisher: self.habitPublisher
                            )
                        }
                    )
                }
            })
    }
}

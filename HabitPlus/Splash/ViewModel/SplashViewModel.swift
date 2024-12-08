//
//  SplashViewModel.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 19/10/24.
//

import SwiftUI
import Combine

class SplashViewModel: ObservableObject {
    
    @Published var uiState: SplashUIState = .loading
    
    private var cancellableAuth: AnyCancellable?
    private var cancellableRefresh: AnyCancellable?
    private var cancellableResetAuth: AnyCancellable?
    private let interactor: SplashInteractor
    
    private let resetAuthPublisher = PassthroughSubject<Bool, Never>()
    
    init (interactor: SplashInteractor) {
        self.interactor = interactor
        
        cancellableResetAuth = resetAuthPublisher.sink(
            receiveValue: { isReset in
                self.uiState = .goToSingInScreen
            }
        )
    }
    
    deinit {
        cancellableAuth?.cancel()
        cancellableRefresh?.cancel()
        cancellableResetAuth?.cancel()
    }
    
}

extension SplashViewModel {
    func onAppear() {
        cancellableAuth = interactor.fetchAuth()
            .receive(on: DispatchSerialQueue.main)
            .sink { userAuth in
                if userAuth == nil {
                    self.uiState = .goToSingInScreen
                }
                else if Date().timeIntervalSince1970 > Double(userAuth!.expires) {
                    self.cancellableRefresh = self.interactor.refreshToken(
                        refreshToken: RefreshRequest(
                            token: userAuth!.refreshToken
                        )
                    )
                    .receive(on: DispatchSerialQueue.main)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .failure(_):
                            break
                        default:
                            break
                        }
                    }, receiveValue: { success in
                        
                        print(success)
                        self.interactor.insertAuth(
                            userAuth: UserAuth(
                                acessToken: success.acessToken,
                                refreshToken: success.refreshToken,
                                expires: Date().timeIntervalSince1970 + Double(success.expires),
                                tokenType: success.tokenType
                            )
                        )
                        self.uiState = .goToHomeScreen
                        
                    })
                }
                else {
                    self.uiState = .goToHomeScreen
                }
            }
    }
}

extension SplashViewModel {
    func signInView() -> some View {
        return SplashViewRouter.makeSignInView(resetAuthPublisher: resetAuthPublisher)
    }
    
    func homeView() -> some View {
        return SplashViewRouter.makeHomeView(resetAuthPublisher: resetAuthPublisher)
    }
}

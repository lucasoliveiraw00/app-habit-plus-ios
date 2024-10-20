//
//  SplashView.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 19/10/24.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        Group {
            switch viewModel.uiState {
            case .loading:
                LoadingView()
            case .goToSingInScreen:
                viewModel.signInView()
            case .goToHomeScreen:
                Text("Carregar tela principal")
            case .error(let error):
                LoadingView(error: error)
            }
        }.onAppear(perform: viewModel.onAppear)
    }
}

extension SplashView {
    func LoadingView(error: String? = nil) -> some View {
        ZStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .ignoresSafeArea()
                .background(Color.white)
            
            if let error = error {
                Text("").alert(isPresented: .constant(true)) {
                    Alert(title: Text("Habit Plus"), message: Text(error), dismissButton: .default(Text("Ok")) {
                        
                    })
                }
            }
        }
    }
}

#Preview {
    SplashView(viewModel: SplashViewModel())
}

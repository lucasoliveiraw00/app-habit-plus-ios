//
//  HomeView.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 20/10/24.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}

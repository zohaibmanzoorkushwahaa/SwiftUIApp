//
//  HomeView.swift
//  SwiftUIApp
//
//  Created by Muhammad Irfan Zafar on 24/09/2024.
//

import SwiftUI

protocol HomeViewViewModel: BaseViewModel {
    
}

class HomeViewViewModelImpl: BaseViewModelImpl, HomeViewViewModel {
    
    init(with router: ScreenFactory.Router) {
        super.init(router: router)
    }
}


struct HomeView<ViewModel: HomeViewViewModel>: View {
    
    @StateObject var vm: ViewModel
    var body: some View {
        VStack(alignment: .center, content: {
            Text("Welcome to SwiftUI Fantasy")
                .foregroundColor(.black)
                .font(.title)
                .padding()
        })

    }
}

#Preview {
    HomeView(vm: HomeViewViewModelImpl(with: ScreenFactory.Router()))
}

//
//  SplashScreen.swift
//  SwiftUIApp
//
//  Created by Muhammad Irfan Zafar on 23/09/2024.
//

import SwiftUI

struct SplashScreen: View {
    
    @State private var scale = 0.7
    @Binding var isActive: Bool
    
    var body: some View {
        ZStack{
            Color.black
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    Image(systemName: "scribble.variable")
                        .font(.system(size: 100))
                    Text("Swift UI App")
                        .font(.system(size: 20).bold())
                    
                }
                .foregroundColor(.white)
                .scaleEffect(scale)
                .onAppear{
                    withAnimation(.easeIn(duration: 0.7)) {
                        self.scale = 1.4
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }

    }
}

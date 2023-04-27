//
//  SwiftfullCryptoApp.swift
//  SwiftfullCrypto
//
//  Created by Ajinkya Adole 
//

import SwiftUI

@main
struct SwiftfullCryptoApp: App {
    @StateObject private var vm = HomeViewModel() 
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}

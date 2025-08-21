//
//  BitFlowApp.swift
//  BitFlow
//
//  Created by Macbook Pro on 18/06/2025.
//

import SwiftUI


@main
struct BitFlowApp: App {
    
    @StateObject private var vm = CoinViewModel()
    
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.accent)]
    }
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

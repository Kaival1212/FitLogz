//
//  ContentView.swift
//  FitLogz
//
//  Created by Kaival Patel on 16/12/2024.
//

import SwiftUI

struct ContentView: View {
    
    var vm = AuthConnect.Singleton
    var healthKit = HealthConnect.Singleton
    
    init() {
        healthKit.requestAuthorization()
        healthKit.fetchDailyHealthData()
    }
    
    var body: some View {
        Group {
            if vm.token == nil && vm.user == nil{
                LoginView()
                
            } else {
                HomePageView()
            }
        }        
    }
}

#Preview {
    ContentView()
}

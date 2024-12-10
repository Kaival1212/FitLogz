//
//  HomePageView.swift
//  FitLogz
//
//  Created by Kaival Patel on 16/12/2024.
//

import SwiftUI

struct HomePageView: View {
    
    var vm = AuthViewModel.Singleton
    var healthKit = HealthConnect.Singleton
        
    var body: some View {
        
        ZStack {
            Color.backGround
                .ignoresSafeArea(.all)
            
            NavigationStack {
                TabView {
                    Tab("Home", systemImage: "house.fill"){
                        InfoView()
                    }
                    Tab( "Nutrition" , systemImage: "chart.pie.fill"){
                        ScannerView()
                    }
                    Tab("Log Sets" , systemImage: "book.fill"){
                        LogSetView()
                    }
                    Tab("Form" , systemImage: "figure.strengthtraining.functional"){
                        CameraView()
                    }
                    
                }
                .background(Color.gray)
                .tabViewStyle(.tabBarOnly)
            }
        }
        .onAppear {
            let appearance = UITabBarAppearance()
            AuthConnect.Singleton.getUsersHistory()
            appearance.backgroundColor = UIColor(Color.defPrimary)

            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for:.selected)
        }
    }
        
}

#Preview {
    HomePageView()
}

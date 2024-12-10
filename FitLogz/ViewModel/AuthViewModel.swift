//
//  AuthViewModel.swift
//  FitLogz
//
//  Created by Kaival Patel on 17/12/2024.
//

import Foundation
import Observation

@Observable
class AuthViewModel {
    
    private var authConnect = AuthConnect.Singleton
    
    static var Singleton = AuthViewModel()
        
    func login(email:String, password:String) {
        authConnect.login(email: email, password: password)
    }
    
    func logout() {
        authConnect.deleteToken()
    }
    
    
}

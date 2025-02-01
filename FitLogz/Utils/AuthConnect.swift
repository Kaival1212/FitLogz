//
//  AuthConnect.swift
//  FitLogz
//
//  Created by Kaival Patel on 10/12/2024.
//

import Foundation
import SwiftUICore
import UIKit



struct LoginResponse:Decodable {
    var token: String
}

struct ErrorResponse: Codable {
    let error: String
}

@Observable class AuthConnect {
    
    let baseURL: URL = ApiUrl.baseUrl   
    
    var token: String? = nil
    var error: String? = nil
    var isLoading: Bool = false
    var user:User? = nil
    var userWeightsHistory: UserWeightResponse? = nil
    
    var weights: [UserWeight] = [] {
        
        didSet {
            if let userWeightsHistory = userWeightsHistory {
                weights = userWeightsHistory.weights
            }
        }
    }
    
    static var Singleton = AuthConnect()
    
    init() {
        _ = getToken()
            getUser()
            getUsersHistory()
    }
    
    func setToken(newtoken:String){
        UserDefaults.standard.set(newtoken, forKey: "token")
        _ = getToken()
        getUser()
    }
    
    func getToken() -> String? {
        token = UserDefaults.standard.string(forKey: "token")
//        print(token)
        self.token = token ?? nil
        return token ?? nil
    }
    
    func getUsersHistory(){
        
        if self.token != nil{
 //           print("Getting Users History")
            let url = baseURL.appendingPathComponent("weights")
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(self.token!)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error {print("Error: \(error)");return}
                
                guard let data else {print("No Data");return}
                
                let decoder = JSONDecoder()
                do {
                    let his = try decoder.decode(UserWeightResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.userWeightsHistory = his
                    }
                }
                catch {print("Error: \(error)")}
            }
            .resume()
        }
    }
    
    func getUser(){
        self.isLoading = true
        
        if self.token != nil{
            let url = baseURL.appendingPathComponent("user")
                  
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(self.token!)", forHTTPHeaderField: "Authorization")
                        
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error {
                    print("Error: \(error)")
                    self.deleteToken()
                    return
                    
                }
                
                guard let data else {print("No Data");return}
                
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(User.self, from: data)
                    DispatchQueue.main.async {
                        self.user = user
                    }
                } catch {
                    print("Error decoding: \(error)")
                    self.deleteToken()
                    
                }
            }.resume()
            self.isLoading = false
        }else {
            return
        }
    }
    
    
    func deleteToken(){
        UserDefaults.standard.removeObject(forKey: "token")
        
        let url = baseURL.appendingPathComponent("logout")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(self.token!)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request).resume()
        self.user = nil
        _ = getToken()
    }
    
    func login(email: String, password: String, deviceName: String = UIDevice.current.name) {
        
        if email == "" || password == "" {
            error = "Please enter your email and password"
            return
        }
        
           let url = baseURL.appendingPathComponent("sanctum/token")

           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           
           let body: [String: String] = [
               "email": email,
               "password": password,
               "deviceName": deviceName
           ]
        
           request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
    
        
           URLSession.shared.dataTask(with: request) { data, response, error in
  
                   if let error {print("Error: \(error)");return}
                   
                   guard let data else {print("No Data");return}
                   
                   do {
                       let tokenResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                       self.setToken(newtoken: tokenResponse.token)
                   }
               catch {
                       if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                           self.error = errorResponse.error
                           print(errorResponse.error)
                       }
                   else {
                           print("Failed to decode error response: \(error)")
                       }
                   }
               
           }.resume()
           
       }
    
}
        

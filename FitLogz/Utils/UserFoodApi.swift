//
//  UserFoodApi.swift
//  FitLogz
//
//  Created by Kaival Patel on 01/02/2025.
//

import Foundation


class UserFoodApi {
    
    static let userFoodUrl = ApiUrl.baseUrl.appendingPathComponent("food")

    static func addFood(barCode:String? = nil , calories:Double , protein:Double , carb:Double , fat:Double , name:String , completion: @escaping (Result<String, Error>) -> Void){
        let url = userFoodUrl
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(AuthConnect.Singleton.token!)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "name": name,
            "barcode": barCode ?? "",
            "calories": calories,
            "protein": protein,
            "carbs": carb,
            "fat": fat,
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Failed to add food: \(error)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data returned from server.")
                return
            }
            
            print(String(data: data, encoding: .utf8) ?? "No data")
            completion(.success(""))
            
        }.resume()
    }
    
}

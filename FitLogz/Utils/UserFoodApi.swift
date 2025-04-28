//
//  UserFoodApi.swift
//  FitLogz
//
//  Created by Kaival Patel on 01/02/2025.
//

import Foundation


class UserFoodApi {
    
    static let userFoodUrl = ApiUrl.baseUrl.appendingPathComponent("food")
    static let userNutritionUrl = ApiUrl.baseUrl.appendingPathComponent("dailynutrition")
    
    static func getDailyFood(completion: @escaping (Result<[UserFood], Error>) -> Void){
        print("start")
        let url = userFoodUrl
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(AuthConnect.Singleton.token ?? "test")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
                return
            }
            
            let decoder = JSONDecoder()

            if let userFoods = try? decoder.decode(UserFoodResponse.self, from: data){
                print(userFoods)
                completion(.success(userFoods.data))
            }
            
        }.resume()
    }
    
    static func getDailyNutrients(completion: @escaping (Result<UserNutrients, Error>) -> Void){
        
        var request = URLRequest(url: userNutritionUrl)
        request.httpMethod = "GET"
        request.setValue("Bearer \(AuthConnect.Singleton.token ?? "test")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
                return
            }
            
            if let userFoods = try? JSONDecoder().decode(UserNutrients.self, from: data) {
                print(userFoods)
                completion(.success(userFoods))
            }
            
        }.resume()
    }

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
    
    static func getExercies(completion: @escaping (Result<[Exercise], Error>) -> Void){
        
        let url = ApiUrl.baseUrl.appendingPathComponent("exercises")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(AuthConnect.Singleton.token ?? "test" )", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "Empty Data", code: 1001, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            if let userExerciesData = try? JSONDecoder().decode([Exercise].self, from: data) {
                completion(.success(userExerciesData))
            } else {
                let error = NSError(domain: "Decoding Error", code: 1002, userInfo: nil)
                completion(.failure(error))
            }
        }.resume()
    
    }
    
    static func addExercise(
            name: String,
            muscleGroup: String?,
            completion: @escaping (Result<Exercise, Error>) -> Void
        ) {
            let url = ApiUrl.baseUrl.appendingPathComponent("exercises")
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Bearer \(AuthConnect.Singleton.token!)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let body: [String: Any] = [
                "name": name,
                "muscle_group": muscleGroup ?? NSNull()
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    let error = NSError(domain: "Empty Data", code: 1001, userInfo: nil)
                    completion(.failure(error))
                    return
                }
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                if let exercise = try? decoder.decode(Exercise.self, from: data) {
                    completion(.success(exercise))
                } else {
                    let error = NSError(domain: "Decoding Error", code: 1002, userInfo: nil)
                    completion(.failure(error))
                }
            }
            .resume()
        }
    
    
    static func getSets(
            for exerciseID: Int,
            completion: @escaping (Result<[WorkoutSet], Error>) -> Void
        ) {
            var comps = URLComponents(url: ApiUrl.baseUrl.appendingPathComponent("sets"),
                                      resolvingAgainstBaseURL: false)!
            comps.queryItems = [URLQueryItem(name: "exercise_id", value: String(exerciseID))]
            
            var request = URLRequest(url: comps.url!)
            print(request)
            request.httpMethod = "GET"
            request.setValue("Bearer \(AuthConnect.Singleton.token ?? "")", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error { completion(.failure(error)); return }
                guard let data = data else {
                    completion(.failure(NSError(domain: "Empty Data", code: 1001))); return
                }
                let decoder = JSONDecoder()
                print(String(data: data, encoding: .utf8) ?? "No data")

                if let list = try? decoder.decode([WorkoutSet].self, from: data) {
                    completion(.success(list))
                } else {
                    completion(.failure(NSError(domain: "Decoding Error", code: 1002)))
                }
            }.resume()
        }
        
        static func addSet(
            exerciseID: Int,
            weight: Double,
            reps: Int,
            intensity: String,
            completion: @escaping (Result<WorkoutSet, Error>) -> Void
        ) {
            let url = ApiUrl.baseUrl.appendingPathComponent("sets")
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Bearer \(AuthConnect.Singleton.token ?? "")", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let body: [String: Any?] = [
                "exercise_id": exerciseID,
                "weight": weight,
                "reps": reps,
                "intensity": intensity,
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    completion(.failure(error)); return
                }
                guard let data = data else {
                    completion(.failure(NSError(domain: "Empty Data", code: 1001))); return
                }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let set = try? decoder.decode(WorkoutSet.self, from: data) {
                    completion(.success(set))
                } else {
                    completion(.failure(NSError(domain: "Decoding Error", code: 1002)))
                }
            }
            .resume()
        }
        
        static func getRecommendation(
            exerciseID: Int,
            completion: @escaping (Result<String, Error>) -> Void
        ) {
            var components = URLComponents(url: ApiUrl.baseUrl.appendingPathComponent("sets/recommendation"),
                                           resolvingAgainstBaseURL: false)!
            components.queryItems = [URLQueryItem(name: "exercise_id", value: String(exerciseID))]
            
            var request = URLRequest(url: components.url!)
            request.httpMethod = "GET"
            request.setValue("Bearer \(AuthConnect.Singleton.token ?? "")", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    completion(.failure(error)); return
                }
                guard let data = data else {
                    completion(.failure(NSError(domain: "Empty Data", code: 1001))); return
                }
                struct RecResp: Codable { let recommendation: String }
                if let rec = try? JSONDecoder().decode(RecResp.self, from: data) {
                    completion(.success(rec.recommendation))
                } else {
                    completion(.failure(NSError(domain: "Decoding Error", code: 1002)))
                }
            }
            .resume()
        }
    
    
    static func addWeight(
            weight: Double,
            unit: String = "kg",
            completion: @escaping (Result<UserWeight, Error>) -> Void
        ) {
            let url = ApiUrl.baseUrl.appendingPathComponent("user-weights")
            var req = URLRequest(url: url)
            req.httpMethod = "POST"
            req.setValue("Bearer \(AuthConnect.Singleton.token ?? "")", forHTTPHeaderField: "Authorization")
            req.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let body: [String: Any] = [
                "weight": weight,
                "unit": unit
            ]
            req.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            
            URLSession.shared.dataTask(with: req) { data, _, error in
                if let error = error {
                    completion(.failure(error)); return
                }
                guard let data = data else {
                    completion(.failure(NSError(domain: "Empty Data", code: 1001))); return
                }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let row = try? decoder.decode(UserWeight.self, from: data) {
                    completion(.success(row))
                } else {
                    completion(.failure(NSError(domain: "Decoding Error", code: 1002)))
                }
            }
            .resume()
        }
}

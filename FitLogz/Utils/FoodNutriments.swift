//
//  FoodNutriments.swift
//  FitLogz
//
//  Created by Kaival Patel on 17/01/2025.
//

import Foundation


class FoodNutriments {
    static let baseURL = ApiUrl.baseUrl.appendingPathComponent("openfoodfacts/product")
    static let userFoodUrl = ApiUrl.baseUrl.appendingPathComponent("food")
    
    static func getData(id: String, completion: @escaping (Result<ProductNutriments, ProductNutrimentsError>) -> Void) {
        let url = baseURL.appendingPathComponent("\(id)")
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(ProductNutrimentsError(error: error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(ProductNutrimentsError(error: "No data returned from server.")))
                return
            }
            
            let decoder = JSONDecoder()
            
            if let product = try? decoder.decode(ProductNutriments.self, from: data) {
                completion(.success(product))
                return
            }
            
            if let productError = try? decoder.decode(ProductNutrimentsError.self, from: data) {
                completion(.failure(productError))
                return
            }
            
            completion(.failure(ProductNutrimentsError(error: "Product not found")))
            
        }.resume()
    }

    
    
}

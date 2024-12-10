//
//  openfoodfactsApi.swift
//  FitLogz
//
//  Created by Kaival Patel on 26/12/2024.
//

import Foundation


class OpenFoodFactsApi {
    
    let baseUrl: String = "https://api.openfoodfacts.org/api/v0/product"
    
    init(){}
    
    func getProductDetails(productId: String) async throws -> Product? {
        let urlString = baseUrl + "/\(productId).json"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
            return productResponse.product
        } catch {
            print(error)
            throw error
        }
    }

    
}

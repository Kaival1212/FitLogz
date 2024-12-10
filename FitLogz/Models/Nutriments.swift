//
//  Nutriments.swift
//  FitLogz
//
//  Created by Kaival Patel on 26/12/2024.
//

import Foundation

struct ProductResponse: Codable {
    let product: Product
}

struct Product: Codable {
    let productName: String
    let productNameEN: String?
    let productNameFR: String?
    let nutriments: Nutriments
    
    enum CodingKeys: String, CodingKey {
        case productName = "product_name"
        case productNameEN = "product_name_en"
        case productNameFR = "product_name_fr"
        case nutriments
    }
}

struct Nutriments: Codable {
    let energy: Double
    let proteins: Double
    let carbohydrates: Double
    let fat: Double
    let fiber: Double
    let sugars: Double
    let salt: Double
    
    enum CodingKeys: String, CodingKey {
        case energy
        case proteins = "proteins_100g"
        case carbohydrates = "carbohydrates_100g"
        case fat = "fat_100g"
        case fiber = "fiber_100g"
        case sugars = "sugars_100g"
        case salt = "salt_100g"
    }
}

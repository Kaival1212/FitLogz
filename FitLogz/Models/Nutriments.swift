//
//  Nutriments.swift
//  FitLogz
//
//  Created by Kaival Patel on 26/12/2024.
//

import Foundation

struct ProductNutriments: Codable {
    let id: String
    let name: String
    let name_en: String?
    let image_front_small_url: String?
    
    let carbohydrates: Double?
    let carbohydrates_100g: Double?
    let carbohydrates_serving: Double?
    let carbohydrates_unit: String?
    
    let energy: Double?
    let energy_kcal: Double?
    let energy_kcal_100g: Double?
    let energy_kcal_serving: Double?
    let energy_kcal_unit: String?
    
    let fat: Double?
    let fat_100g: Double?
    let fat_serving: Double?
    let fat_unit: String?
    
    let proteins: Double?
    let proteins_100g: Double?
    let proteins_serving: Double?
    let proteins_unit: String?
}

struct ProductNutrimentsError: Codable , Error{
    let error: String
}

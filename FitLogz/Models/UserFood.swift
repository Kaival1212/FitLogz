//
//  UserFood.swift
//  FitLogz
//
//  Created by Kaival Patel on 04/02/2025.
//

import Foundation


struct UserFood: Codable{
    let id: Int
    let name: String
    let calories: Double
    let protein: Double
    let carbs: Double
    let fat: Double
}

struct UserFoodResponse: Codable {
    let data: [UserFood]
}

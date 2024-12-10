//
//  UserWeights.swift
//  FitLogz
//
//  Created by Kaival Patel on 20/12/2024.
//

import Foundation

struct UserWeight: Codable,Identifiable{
    var id: Int
    var user_id: Int
    var weight: Double
    var unit: String
    var created_at: String
    var updated_at: String
}

struct UserWeightResponse: Codable{
    var weights: [UserWeight]
}

//
//  Exercise.swift
//  FitLogz
//
//  Created by Kaival Patel on 28/04/2025.
//

import Foundation

struct Exercise: Identifiable, Hashable , Codable {
    let id: Int
    let name: String
    let muscleGroup: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case muscleGroup = "muscle_group"
    }	
}

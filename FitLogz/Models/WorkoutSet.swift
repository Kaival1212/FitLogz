//
//  WorkoutSet.swift
//  FitLogz
//
//  Created by Kaival Patel on 28/04/2025.
//

import Foundation

struct WorkoutSet: Identifiable, Codable  {
    let id: Int
    let exerciseId: Int
    let userId: Int
    let weight: Double
    let reps: Int
    let intensity: String
    let createdAt: String
    let updatedAt: String
//    let exercise: Exercise?
    
    enum CodingKeys: String, CodingKey {
        case id, weight, reps, intensity
        case exerciseId = "exercise_id"
        case userId     = "user_id"
        case createdAt  = "created_at"
        case updatedAt  = "updated_at"
    }
}

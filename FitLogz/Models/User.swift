//
//  User.swift
//  FitLogz
//
//  Created by Kaival Patel on 17/12/2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: Int
    let name: String
    let email: String
    let height: String
    let weight: String
    let age: String
    let goal: String
    let goal_weight: String
    let activity_level: String
    let daily_calories_goal: String
    let daily_calories_limit: String
    let daily_steps_goal: String
    let email_verified_at: String?
    let remember_token: String?
    let created_at: String
    let updated_at: String
}


struct RegisterUser : Codable {
    var name: String
    var email: String
    var password: String
    var password_confirmation: String
    var height: String
    var weight: String
    var age: String
    var goal: String
    var goal_weight: String
    var activity_level: String
    var daily_calories_goal: String
    var daily_steps_goal: String
    var daily_calories_limit: String
}

    


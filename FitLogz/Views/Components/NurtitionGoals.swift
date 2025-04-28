//
//  NurtitionGoals.swift
//  FitLogz
//
//  Created by Kaival Patel on 28/01/2025.
//

import SwiftUI

struct NurtitionGoals: View {
    
    @Binding var dailyNutrients:UserNutrients?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Nutrition Goals")
                .font(.headline)
                .foregroundStyle(Color.defWhite)
            
            ForEach([
                ("Calories", 2000, dailyNutrients?.calories),
                ("Protein", 150, dailyNutrients?.protein ),
                ("Carbs", 250, dailyNutrients?.carbs),
                ("Fat", 70, dailyNutrients?.fat),
            ], id: \.0) { nutrient, goal, current in
                HStack(spacing: 12) {

                    Text(nutrient)
                        .font(.caption)
                        .foregroundStyle(Color.defWhite.opacity(0.9))
                        .frame(width: 80, alignment: .leading) // Fixed width for alignment
                    
                    ProgressView(value: Double(current ?? 0), total: Double(goal))
                        .accentColor(.green)
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                        .frame(height: 6)
                    
                    Text("\(Int(current ?? 0)) / \(goal)")
                        .font(.caption2)
                        .foregroundStyle(Color.defWhite.opacity(0.7))
                        .frame(width: 70, alignment: .trailing)
                }
            }
        }
        .padding()
        .background(Color.defPrimary)
        .cornerRadius(16)
        .shadow(radius: 8)
        .padding(.horizontal)
    }
}

#Preview {
    
    @Previewable @State var test :UserNutrients? = UserNutrients(calories: 1000, protein: 100, carbs: 100, fat: 100)
    
    NurtitionGoals(dailyNutrients: $test)
}

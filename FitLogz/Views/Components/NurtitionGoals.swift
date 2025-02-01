//
//  NurtitionGoals.swift
//  FitLogz
//
//  Created by Kaival Patel on 28/01/2025.
//

import SwiftUI

struct NurtitionGoals: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Nutrition Goals")
                .font(.headline)
                .foregroundStyle(Color.defWhite)
            
            ForEach([
                ("Calories", 2000, 1500),
                ("Protein", 150, 100),
                ("Carbs", 250, 180),
                ("Fat", 70, 50),
            ], id: \.0) { nutrient, goal, current in
                HStack(spacing: 12) {

                    Text(nutrient)
                        .font(.caption)
                        .foregroundStyle(Color.defWhite.opacity(0.9))
                        .frame(width: 80, alignment: .leading) // Fixed width for alignment
                    
                    ProgressView(value: Double(current), total: Double(goal))
                        .accentColor(.green)
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                        .frame(height: 6)
                    
                    Text("\(current) / \(goal)")
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
    NurtitionGoals()
}

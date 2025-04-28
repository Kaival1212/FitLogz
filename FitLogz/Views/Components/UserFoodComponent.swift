//
//  UserFoodComponent.swift
//  FitLogz
//
//  Created by Kaival Patel on 04/02/2025.
//

import SwiftUI

struct UserFoodComponent: View {
    
    let food: UserFood
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text(food.name)
                    .font(.headline)
                    .foregroundColor(.defWhite)
                    .frame(maxWidth: 150, alignment: .leading)
                    .fixedSize(horizontal: true, vertical: false)
                
                
                Spacer()
                
                NutritionValue(title: "Cals", value: food.calories)
                DividerView()
                NutritionValue(title: "Pro", value: food.protein)
                DividerView()
                NutritionValue(title: "Carbs", value: food.carbs)
                
                
            }
            .padding()
            .foregroundStyle(.defWhite)
            .background(.defPrimary)
            .cornerRadius(12)
            
            Divider()
        }
    }
}

struct NutritionValue: View {
    let title: String
    let value: Double
    
    var body: some View {
        VStack {
            Text("\(Int(value))")
                .font(.headline)
                .foregroundColor(.defWhite)
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
    
    }
}

struct DividerView: View {
    var body: some View {
        Divider()
            .frame(height: 30)
            .background(Color.gray.opacity(0.5))
    }
}

#Preview {
    let testFood = UserFood(id: 12, name: "Test Food dsfjkdsklfj klsdj flkdsj f;lkdasj f;lkjdslk;fj;dlsk jf;lskj;lakj", calories: 1000, protein: 100, carbs: 1000, fat: 10)
    UserFoodComponent(food: testFood)
}

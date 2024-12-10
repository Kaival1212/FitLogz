//
//  NutrimentsView.swift
//  FitLogz
//
//  Created by Kaival Patel on 26/12/2024.
//

import SwiftUI

struct NutrimentsView: View {
    
    var product: Product
    
    var body: some View {
        ZStack {
            Color.backGround
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                Text(getProductName())
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Divider()
                    .background(Color.defPrimary)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Per 100g")
                        .font(.footnote)
                        .foregroundColor(Color.secondary)
                    
                    Divider()
                        .background(Color.defPrimary)
                    
                    NutrientRow(label: "Energy", value: "\(Int(product.nutriments.energy)) kcal")
                    NutrientRow(label: "Proteins", value: "\(String(format: "%.1f", product.nutriments.proteins)) g")
                    NutrientRow(label: "Carbohydrates", value: "\(String(format: "%.1f", product.nutriments.carbohydrates)) g")
                    NutrientRow(label: "Fat", value: "\(String(format: "%.1f", product.nutriments.fat)) g")
                    NutrientRow(label: "Fiber", value: "\(String(format: "%.1f", product.nutriments.fiber)) g")
                    NutrientRow(label: "Sugars", value: "\(String(format: "%.1f", product.nutriments.sugars)) g")
                    NutrientRow(label: "Salt", value: "\(String(format: "%.1f", product.nutriments.salt)) g")

                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)
                
                Spacer()
            }
            .padding()
        }
        .foregroundColor(.white)
    }
    
    private func getProductName() -> String {
            if !product.productName.isEmpty {
                return product.productName
            }
        else if (product.productNameEN?.isEmpty == false){
            return product.productNameEN!
        }
        else if ((product.productNameFR?.isEmpty) == nil){
            return product.productNameFR!
        }
        else{
            return "Product Name not found"
        }
        }
}

struct NutrientRow: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .fontWeight(.semibold)
            Spacer()
            Text(value)
        }
    }
}

#Preview {
    
    let test = Product(
                productName: "Ratlami sev",
                productNameEN: "Ratlami sev",
                productNameFR: "Ratlami sev",
                nutriments: Nutriments(
                    energy: 2361.0,
                    proteins: 14.109347442681,
                    carbohydrates: 42.328042328042,
                    fat: 38.800705467372,
                    fiber: 7.0546737213404,
                    sugars: 0.0,
                    salt: 2.557319223986
                )
            )
    
    NutrimentsView(product: test)
}

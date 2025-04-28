//
//  NutrimentsView.swift
//  FitLogz
//
//  Created by Kaival Patel on 26/12/2024.
//

import SwiftUI

struct NutrimentsView: View {
    
    var product: ProductNutriments
    @State var selection: String = "serving"
    @Binding var isPresented: Bool
    @State var showNutriModal: Bool = false
    @State var Amount: String = "1"
    @State var success: Bool = false
    @State var error: String?
    
    var body: some View {
        ZStack {
            Color.backGround
                .ignoresSafeArea()
            
            VStack {
                if success {
                    Text("Added Successfully")
                        .font(.system(size: 18, weight: .bold))
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .animation(.easeInOut(duration: 0.5), value: success)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    success = false
                                }
                            }
                        }
                }
                Spacer()
            }
            .padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 20) {
                Text(getProductName())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                
                HStack {
                    Picker(selection: $selection, label: Text("Unit")) {
                        if product.carbohydrates_serving != nil && product.energy_kcal_serving != nil { Text("Per serving").tag("serving")}
                        if product.carbohydrates_100g != nil && product.energy_kcal_100g != nil {Text("Per 100g/ml").tag("100")}
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.trailing, 10)
                    
                    Spacer()
                    
                    TextField("Amount", text: $Amount)
                        .keyboardType(.numberPad)
                        .frame(width: 80)
                        .padding(10)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
                
                Divider().background(Color.white.opacity(0.3))
                
                VStack(spacing: 12) {
                    if selection == "serving" {
                        NutrientRow(label: "Calories", value: (product.energy_kcal_serving ?? 0) * (Double(Amount) ?? 1))
                        NutrientRow(label: "Protein", value: (product.proteins_serving ?? 0) * (Double(Amount) ?? 1))
                        NutrientRow(label: "Fat", value: (product.fat_serving ?? 0) * (Double(Amount) ?? 1))
                        NutrientRow(label: "Carbohydrates", value: (product.carbohydrates_serving ?? 0) * (Double(Amount) ?? 1))
                        
                        Button(action: {
                            addFood()
                        }) {
                            Text("Add")
                                .padding(.horizontal, 70)
                                .padding(.vertical, 7)
                                .background(Color.defSecondary)
                                .cornerRadius(10)
                        }
                    } else if selection == "100" {
                        NutrientRow(label: "Calories", value: (product.energy_kcal_100g ?? 0) * ((Double(Amount) ?? 100) / 100))
                        NutrientRow(label: "Protein", value: (product.proteins_100g ?? 0) * ((Double(Amount) ?? 100) / 100))
                        NutrientRow(label: "Fat", value: (product.fat_100g ?? 0) * ((Double(Amount) ?? 100) / 100))
                        NutrientRow(label: "Carbohydrates", value: (product.carbohydrates_100g ?? 0) * ((Double(Amount) ?? 100) / 100))
                        
                        Button(action: {
                            addFood()
                        }) {
                            Text("Add")
                                .padding(.horizontal, 70)
                                .padding(.vertical, 7)
                                .background(Color.defSecondary)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.vertical, 10)
            }
            .padding()
        }
        .foregroundColor(.white)
        .onChange(of: selection) {
            Amount = selection == "serving" ? "1" : "100"
        }
    }
    
    private func getProductName() -> String {
        if !product.name.isEmpty {
            return product.name
        } else if let nameEn = product.name_en, !nameEn.isEmpty {
            return nameEn
        } else {
            return "Product Name not found"
        }
    }
    
    private func addFood() {
        let calories = selection == "serving"
            ? (product.energy_kcal_serving ?? 0) * (Double(Amount) ?? 1)
            : (product.energy_kcal_100g ?? 0) * ((Double(Amount) ?? 100) / 100)
        
        let protein = selection == "serving"
            ? (product.proteins_serving ?? 0) * (Double(Amount) ?? 1)
            : (product.proteins_100g ?? 0) * ((Double(Amount) ?? 100) / 100)
        
        let carb = selection == "serving"
            ? (product.carbohydrates_serving ?? 0) * (Double(Amount) ?? 1)
            : (product.carbohydrates_100g ?? 0) * ((Double(Amount) ?? 100) / 100)
        
        let fat = selection == "serving"
            ? (product.fat_serving ?? 0) * (Double(Amount) ?? 1)
            : (product.fat_100g ?? 0) * ((Double(Amount) ?? 100) / 100)
        
        UserFoodApi.addFood(calories: calories, protein: protein, carb: carb, fat: fat, name: product.name) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    withAnimation {
                        success = true
                    }
                        isPresented = false
                case .failure(let error):
                    self.error = error.localizedDescription
                    print("Error: \(error)")
                }
            }
        }
    }
}


struct NutrientRow: View {
    var label: String
    var value: Double
    
    var body: some View {
        HStack {
            Text(label)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.defWhite.opacity(0.9))
            
            Spacer()
            
            Text("\(Int(value))")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.defWhite.opacity(0.8))
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color.white.opacity(0.1))
        .cornerRadius(8)
    }
}

struct NutrimentsView_Previews: PreviewProvider {
    static var previews: some View {
        let test = ProductNutriments(
            id: "cookie_001",
            name: "Biscuit",
            name_en: "Cookie",
            image_front_small_url: "https://images.openfoodfacts.org/images/products/000/000/039/6134/front_fr.13.200.jpg",
            carbohydrates: 61.7,
            carbohydrates_100g: 61.7,
            carbohydrates_serving: 61.7,
            carbohydrates_unit: "g",
            energy: 2155,
            energy_kcal: 515,
            energy_kcal_100g: 515,
            energy_kcal_serving: 515,
            energy_kcal_unit: "kcal",
            fat: 27,
            fat_100g: 27,
            fat_serving: 27,
            fat_unit: "g",
            proteins: 5.6,
            proteins_100g: 5.6,
            proteins_serving: 5.6,
            proteins_unit: "g"
        )
        
        NutrimentsView(product: test, isPresented: .constant(true))
    }
}

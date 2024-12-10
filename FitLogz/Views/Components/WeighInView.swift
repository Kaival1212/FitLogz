//
//  WeighInView.swift
//  FitLogz
//
//  Created by Kaival Patel on 24/12/2024.
//

import SwiftUI

struct WeighInView: View {
    
    @Binding var isShowingSheet : Bool
    @State var weight:Double?
    @State var selectedUnit:String = "kg"
    @State var errorMessage:String?
    
    var body: some View {
        ZStack {
            Color.backGround
                .ignoresSafeArea(.all)
            VStack {
                Text("Weigh In 📈")
                    .font(.custom("LilitaOne", size: 34))
                    .fontWeight(.semibold)
                    .foregroundColor(.defWhite)
                    .padding(.top)
                
                HStack {
                    TextField("Enter your current weight", value: $weight , format: .number)
                        .padding()
                        .background(Color.defPrimary)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .keyboardType(.decimalPad)
                    
                    Menu {
                        Button {
                            selectedUnit = "kg"
                        } label: {
                            Label("Kilograms", systemImage: "scalemass")
                                .font(.title3)
                                .foregroundColor(.blue)
                        }
                        Button {
                            selectedUnit = "lbs"
                        } label: {
                            Label("Pounds", systemImage: "figure.strengthtraining.traditional")
                                .font(.title3)
                                .foregroundColor(.blue)
                        }
                    } label: {
                        HStack {
                            Text("\(selectedUnit)")
                                .font(.custom("LilitaOne", size: 16))
                                .foregroundColor(.defWhite)
                            Image(systemName: "arrow.down")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.defPrimary)
                        .cornerRadius(10)

                    }
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                
                if errorMessage != nil {
                    Text(errorMessage!)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                
                Button("Submit") {
                    print("loged Weight: \(weight ?? 0)")
                    isShowingSheet = false
                }
                .disabled(weight == nil || weight == 0 || errorMessage != nil)
                .padding()
                .background(Color.defSecondary)
                .foregroundColor(.white)
                .cornerRadius(10)
                .fontWeight(.semibold)
                .padding(10)
                .opacity(weight == nil || weight == 0 || errorMessage != nil ? 0.5 : 1)

                
            }
        }
    }
}

#Preview {
    @Previewable @State var isShowingSheet: Bool = true
    WeighInView(isShowingSheet: $isShowingSheet)
}

//
//  WeighInView.swift
//  FitLogz
//
//  Created by Kaival Patel on 24/12/2024.
//

import SwiftUI

struct WeighInView: View {
    
    @Binding var isShowingSheet: Bool
    var  onSaved: (() -> Void)? = nil
    
    @State private var weightText = ""
    @State private var isSaving   = false
    @State private var errorMsg   : String?
    
    private var weightValue: Double? {
        Double(weightText.replacingOccurrences(of: ",", with: "."))
    }
    
    var body: some View {
        ZStack {
            Color.backGround.ignoresSafeArea()
            
            VStack(spacing: 24) {
                Text("Weigh In 📈")
                    .font(.custom("LilitaOne", size: 34))
                    .foregroundColor(.defWhite)
                
                TextField("Current weight (kg)", text: $weightText)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.defPrimary)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                
                Button(isSaving ? "Saving…" : "Submit") { save() }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.defSecondary)
                    .cornerRadius(12)
                    .foregroundColor(.white)
                    .padding(.horizontal)
            }
        }
    }
    

    
    private func save() {
        guard let kg = weightValue else { return }
        print("🌍 posting \(kg) kg")
        isSaving = true
        errorMsg = nil
        
        UserFoodApi.addWeight(weight: kg, unit: "kg") { result in
            print("📬 got response:", result)
            DispatchQueue.main.async {
                isSaving = false
                switch result {
                case .success:
                    onSaved?()
                    isShowingSheet = false        // should dismiss here
                case .failure(let err):
                    errorMsg = err.localizedDescription
                }
            }
        }
    }

}

#Preview {
    @Previewable @State var show = true
    WeighInView(isShowingSheet: $show)
}

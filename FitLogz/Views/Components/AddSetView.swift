//
//  AddSetView.swift
//  FitLogz
//
//  Created by Kaival Patel on 28/04/2025.
//

import SwiftUI

struct AddSetView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let exercise: Exercise
    var onSaved: () -> Void
    
    @State private var weightText = ""
    @State private var repsText   = ""
    @State private var intensity  = "Easy"
    
    @State private var isSaving   = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(exercise.name)) {
                    TextField("Weight (kg)", text: $weightText)
                        .keyboardType(.decimalPad)
                    TextField("Reps", text: $repsText)
                        .keyboardType(.numberPad)
                    Picker("Intensity", selection: $intensity) {
                        ForEach(["Easy","Moderate","Hard","Failure"], id: \.self) {
                            Text($0)
                        }
                    }
                }
            }
            .navigationTitle("Add Set")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(isSaving ? "Saving…" : "Save") { save() }
                        .disabled(isSaving || !formIsValid)
                }
            }

        }
        .tint(Color.defSecondary)
    }
    
    private var formIsValid: Bool {
        Double(weightText) != nil && Int(repsText) != nil
    }
    
    private func save() {
        guard let weight = Double(weightText),
              let reps   = Int(repsText) else { return }
        
        isSaving = true
        
        UserFoodApi.addSet(
            exerciseID: exercise.id,
            weight: weight,
            reps: reps,
            intensity: intensity
        ) { result in
            DispatchQueue.main.async {
                isSaving = false
                switch result {
                case .success:
                    onSaved()   // ask SetsView to refresh
                    dismiss()
                case .failure(let err):
                        print("Error saving set: \(err)")
                        dismiss()
                    }
            }
        }
    }
}

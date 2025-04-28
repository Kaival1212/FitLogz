//
//  AddExerciseView.swift
//  FitLogz
//
//  Created by Kaival Patel on 28/04/2025.
//

import Foundation
import SwiftUI

struct AddExerciseView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var muscleGroup: String = ""
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercise")) {
                    TextField("Name (e.g. Bench Press)", text: $name)
                }
                
                Section(header: Text("Muscle Group")) {
                    TextField("e.g. Chest", text: $muscleGroup)
                }
            }
            .navigationTitle("Add Exercise")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                        .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }

        }
    }
    
    private func save() {
        
        UserFoodApi.addExercise(name: name, muscleGroup: muscleGroup.isEmpty ? nil : muscleGroup) { result in
            switch result {
            case .success:
                dismiss()                
            case .failure(let err):
                    dismiss()
                    print("Error: \(err)")
            }
        }
        dismiss()
    }
}

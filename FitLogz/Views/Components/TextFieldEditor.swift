//
//  TextFieldEditor.swift
//  FitLogz
//
//  Created by Kaival Patel on 17/12/2024.
//

import SwiftUI

struct TextFieldEditor:View {
    
    @Binding var text: String
    var placeholder: String
    var isSecure: Bool
    var label: String = ""
    @FocusState private var isTextFieldFocused: Bool  // Track focus state
    
    var body: some View {
        VStack(alignment: .leading , spacing: 10){
            Text("\(label)")
                .font(.custom("Lilita One", size: 25))
                .foregroundColor(Color.white)

            if isSecure {
                SecureField(placeholder, text: $text)
                    .frame(height: 50)
                    .padding(.horizontal)
                    .background(Color.defPrimary)
                    .foregroundStyle(Color.white)
                    .cornerRadius(20)
                    .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(isTextFieldFocused ? Color.orange : Color.clear, lineWidth: 1)
                     )
                    .focused($isTextFieldFocused)
                    
            } else {
                TextField(placeholder, text: $text)
                    .frame(height: 50)
                    .padding(.horizontal)
                    .background(Color.defPrimary)
                    .foregroundStyle(Color.white)
                    .cornerRadius(20)
                    .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(isTextFieldFocused ? Color.orange : Color.clear, lineWidth: 1)
                     )
                    .focused($isTextFieldFocused)
                    
            }
                
        }
    }
    
}

#Preview {
    @Previewable @State var sampleText = "" // Provide a sample binding variable

    TextFieldEditor( text: $sampleText, placeholder: "String", isSecure: false , label: "test")
}

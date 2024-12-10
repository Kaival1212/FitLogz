//
//  FormFields.swift
//  FitLogz
//
//  Created by Kaival Patel on 28/12/2024.
//

import SwiftUICore
import SwiftUI


struct FormFields:View {
    @Binding var text: String
    var label: String
    @FocusState var isFocused: Bool
    var autocapitalization: Bool = false
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("\(label)")
                .font(.custom("Lilita One", size: 25))
                .foregroundColor(Color.defWhite)

            TextField("", text : $text )
                .padding(.vertical)
                .padding(.horizontal , 10)
                .background(Color.defPrimary)
                .cornerRadius(20)
                .overlay(content: { RoundedRectangle(cornerRadius: 20).stroke(Color.defSecondary, lineWidth: isFocused ? 1 : 0) })
                .focused($isFocused)
                .autocorrectionDisabled(true)
                .autocapitalization(autocapitalization ? .none : .words)
                .keyboardType(keyboardType)
        }
        .padding(.horizontal)
        .padding(.bottom , 10)
    }
}

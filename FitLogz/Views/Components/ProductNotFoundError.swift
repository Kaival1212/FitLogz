//
//  ProductNotFoundError.swift
//  FitLogz
//
//  Created by Kaival Patel on 25/01/2025.
//

import SwiftUI

struct ProductNotFoundError: View {
    
    let scannedCode: String
    let error: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            VStack(spacing: 20) {
                Text("Oops! Something Went Wrong")
                    .font(.custom("LilitaOne", size: 24))
                    .foregroundColor(Color.red)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                
                Text("Error: \(error)")
                    .font(.custom("LilitaOne", size: 18))
                    .foregroundColor(Color.red.opacity(0.9))
                    .multilineTextAlignment(.center)
                
                Text("Scanned Barcode: \(scannedCode)")
                    .font(.custom("LilitaOne", size: 18))
                    .foregroundColor(Color.blue)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.red.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.red.opacity(0.6), lineWidth: 1)
            )
            
            // Explanation Section
            VStack(alignment: .leading, spacing: 12) {
                Text("Why did this happen?")
                    .font(.custom("LilitaOne", size: 20))
                    .foregroundColor(Color.defWhite)
                
                Text("This might have happened because the dataset is limited, or the barcode might be incorrect.")
                    .font(.custom("LilitaOne", size: 18))
                    .foregroundColor(Color.defWhite.opacity(0.8))
                    .lineSpacing(4)
                
                Text("Want to add this product?")
                    .font(.custom("LilitaOne", size: 20))
                    .foregroundColor(Color.defWhite)
                    .padding(.top, 8)
                
                Text("""
If you'd like to add this product, please contact us at:
kaival225@gmail.com

Include a photo of the barcode and the product's nutrition information.
""")
                    .font(.custom("LilitaOne", size: 18))
                    .foregroundColor(Color.defWhite.opacity(0.8))
                    .lineSpacing(4)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.blue.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.blue.opacity(0.6), lineWidth: 1)
            )
        }
        .padding()
    }
}

#Preview {
    ProductNotFoundError(scannedCode: "1122121", error: "Product not found")
}

//
//  ProgessActivityCircle.swift
//  FitLogz
//
//  Created by Kaival Patel on 24/12/2024.
//

import SwiftUI

struct ProgessActivityCircle:View {
 
    @State var percentage:Double = 0
    var heading : String = "Error"
    var goal : String
    var actual : Int
    var color : Color = Color.red
    var symbol : String = "shoeprints.fill"
    var symbolColor : Color = Color.red
    
    func percentageCalculation() {
        
        withAnimation(.spring(duration: 1.5)) {
            percentage = max(CGFloat(actual) / CGFloat(Double(goal) ?? 0), 0)
        }
    }
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.defPrimary)
                .frame(height: 200)
                .cornerRadius(20)
            
            
            VStack(alignment:.leading) {
                Text("\(heading) : \(actual)")
                    .foregroundColor(Color.white)
                    .font(.custom("Lilita One", size: 15))
                
                ZStack {
                    Circle()
                        .stroke(Color.defWhite,style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    
                    Circle()
                        .trim(from: 0, to: percentage)
                        .stroke(color,style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    
                    Image(systemName: symbol)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(symbolColor)
                    
                }
                .padding(5)
            }.padding()
        }
        .onChange(of: actual) {
            percentageCalculation()
        }
        .onChange(of: goal) {
            percentageCalculation()
        }
    }
    
}
#Preview {
    ProgessActivityCircle(goal: "20", actual: 2)
}

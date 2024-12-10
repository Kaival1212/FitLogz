//
//  RegisterForms.swift
//  FitLogz
//
//  Created by Kaival Patel on 28/12/2024.
//

import SwiftUI

struct RegisterForms<Content : View>: View {
    
    let content: Content
    var onSubmit: () -> Void = {}
    var formLabel: String 
    var buttonLabel: String
    var currentTab: Int
    
    init(onSubmit: @escaping ()->Void, @ViewBuilder content: () -> Content , formLabel: String = "Log on your Details 📝", buttonLabel: String = "Next" , currentTab: Int) {
            self.content = content()
            self.onSubmit = onSubmit
            self.formLabel = formLabel
            self.buttonLabel = buttonLabel
            self.currentTab = currentTab
        }
    
    var body: some View {
        ZStack {
            Color.backGround
                .ignoresSafeArea(.all)
            
            VStack {
                                
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 20)
                        .foregroundColor(.gray.opacity(0.3))
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: UIScreen.main.bounds.width * 0.8 * CGFloat(Float(currentTab) / 2), height: 20)
                        .foregroundColor(.blue)
                        .animation(.spring, value: currentTab)

                }.frame(width: UIScreen.main.bounds.width * 0.8, height: 20)
                
                Text("\(formLabel)")
                    .font(.custom("lilitaOne", size: 30))
                    .foregroundColor(Color.defWhite)
                    .padding()
                    .padding(.top,40)
                                
                content
                
                Button("\(buttonLabel)") {onSubmit()}
                    .padding(10)
                    .padding(.horizontal,70)
                    .background(Color.defPrimary)
                    .cornerRadius(20)
                    .shadow(color: Color.black, radius: 100 , x: 0 , y: 0)
                    .foregroundStyle(Color.defSecondary)
                    .font(.custom("lilitaOne", size: 25))
                    .padding(.vertical,10)
                Spacer()
            }
        }
    }
}




#Preview {
    RegisterForms(onSubmit: { print("Form Submitted") }, content: {
        FormFields(text: .constant("John Doe"), label: "Name")
        FormFields(text: .constant("john.doe@example.com"), label: "Email")
    }, formLabel: "Log on your Details 📝", buttonLabel: "Next", currentTab: 1)

}


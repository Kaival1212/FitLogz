//
//  RegisterProgess.swift
//  FitLogz
//
//  Created by Kaival Patel on 28/12/2024.
//

import SwiftUI

struct RegisterProgess: View {
    
    @State var selectedTab: Int = 1
    
    @State var tempUser: RegisterUser = RegisterUser(
        name: "",
        email: "",
        password: "",
        password_confirmation: "",
        height: "",
        weight: "",
        age: "",
        goal: "",
        goal_weight: "",
        activity_level: "",
        daily_calories_goal: "",
        daily_steps_goal: "",
        daily_calories_limit: ""
    )

    
    var body: some View {
        
        NavigationStack {
            ZStack{
                Color.backGround
                    .edgesIgnoringSafeArea(.all)
                
                TabView(selection: $selectedTab) {
                    NormalInfo(TempUser: $tempUser, selectedTab: $selectedTab)
                        .tag(1)
                    WeightInfo(TempUser: $tempUser, selectedTab: $selectedTab)
                        .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.bouncy, value: selectedTab)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct NormalInfo : View {
    
    @Binding var TempUser: RegisterUser
    @Binding var selectedTab: Int
    @State var date: Date = Date()
    
    func dateToAge() {
        let age = Calendar.current.dateComponents([.year], from: date , to:Date()).year ?? 0
        TempUser.age = String(age)
    }
    
    var body: some View {
        RegisterForms(onSubmit:{
            print(TempUser)
            selectedTab = 2
        }, content: {
            FormFields(text: $TempUser.name, label: "Name")
            FormFields(text: $TempUser.email, label: "Email" , autocapitalization: true , keyboardType: .emailAddress)
            VStack(alignment:.leading,spacing: 10) {
                DatePicker("Date of birth", selection: $date, displayedComponents: .date)
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity)
                    .font(.custom("Lilita One", size: 25))
                    .foregroundColor(Color.defWhite)
                    .onChange(of: date) {
                        dateToAge()
                    }

            }.padding(.horizontal)
                
        }, currentTab: 1)
        
    }
}

struct WeightInfo : View {
    @Binding var TempUser: RegisterUser
    @Binding var selectedTab: Int
    @State var tempweight: Double = 0
    @State var selectedWeight: Double = 0
    
    var body: some View {
        RegisterForms(onSubmit:{
            print(TempUser)
            selectedTab = 3
        },content: {
            FormFields(text: $TempUser.height, label: "Height", keyboardType: .numberPad)
            FormFields(text: $TempUser.weight, label: "Weight", keyboardType: .numberPad)
            FormFields(text: $TempUser.goal_weight, label: "Desired Weight", keyboardType: .numberPad)
            
            VStack(alignment: .leading) {
                Text("Activity Level")
                    .font(.custom("Lilita One", size: 25))
                    .foregroundColor(Color.defWhite)
                VStack{
                    Picker("Activity Level", selection: $TempUser.activity_level) {
                        Text("Sedentary").tag("Sedentary")
                        Text("Lightly Active").tag("Lightly Active")
                        Text("Active").tag("Active")
                        Text("Very Active").tag("Very Active")
                    }
                    .pickerStyle(.navigationLink)
                    .tint(Color.defSecondary)
                }
            }
            .padding(.horizontal)
            .onChange(of: TempUser.weight) {
                tempweight = Double(TempUser.weight) ?? 50
                selectedWeight = tempweight
        }
        
        }, currentTab: 2)
    }
}

#Preview {
    RegisterProgess(selectedTab: 1)
}


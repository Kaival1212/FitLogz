//
//  HeaderView.swift
//  FitLogz
//
//  Created by Kaival Patel on 25/12/2024.
//

import SwiftUI

struct HeaderView: View {
    
    let User: User? = AuthConnect.Singleton.user
    
    var body: some View {
        HStack {
            HStack{
                Text("Welcome,")
                    .font(.custom("LilitaOne", size: 20))
                
                Text("\(User?.name ?? "Error")")
                    .font(.custom("LilitaOne", size: 20))
                    .fontWeight(.bold)
            }
            .padding(.horizontal)
            .foregroundStyle(Color.defWhite)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: {
                AuthConnect.Singleton.deleteToken()
            }){
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .foregroundStyle(Color.defSecondary)
                    .frame(width: 30, height: 30)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    HeaderView()
}

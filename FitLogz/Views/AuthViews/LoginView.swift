//
//  LoginView().swift
//  FitLogz
//
//  Created by Kaival Patel on 16/12/2024.
//

import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    var vm = AuthViewModel.Singleton
    var error : String? = AuthConnect.Singleton.error
//    var error = "Invalid credentials"
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color.backGround
                    .edgesIgnoringSafeArea(.all)
                
                VStack(){
                    
                    Text("Login 🏋️")
                        .font(.custom("Lilita One", size: 40))
                        .padding(.vertical , 80)
                        .foregroundStyle(.white)
                    
                    TextFieldEditor(text: $email, placeholder: "Enter your email", isSecure: false , label: "Email")
                        .autocapitalization(.none)
                    
                    if error != nil && !error!.isEmpty{
                        Text(error!)
                            .foregroundStyle(.red)
                            .italic()
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    TextFieldEditor(text: $password, placeholder: "Enter your password", isSecure: true , label: "Password")
                        .padding(.top)
                    
                    VStack{
                        NavigationLink(destination: RegisterProgess()){
                            Text("Forgot password?")
                                .font(.footnote)
                                .foregroundStyle(Color.blue)
                                .frame(maxWidth: .infinity , alignment: .trailing)
                        }
                    }.padding(.bottom)
                    
                    NavigationLink(destination: RegisterProgess()){
                        Text("Dont have an account? Register")
                            .font(.footnote)
                            .foregroundStyle(Color.blue)
                            .underline()
                    }
                    
                    Button(action: {
                        vm.login(email: email, password: password)
                    }){
                        Text("Login")
                            .frame(width: 150, height: 30)
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color.defSecondary)
                            .cornerRadius(25)
                            .shadow(color: Color.primary.opacity(0.1), radius: 10, x: 0, y: 10)
                    }
                    
                    Spacer()
                    
                }
                .padding(.horizontal,30)
                
            }
        }
    }
}


#Preview {
    LoginView()
}

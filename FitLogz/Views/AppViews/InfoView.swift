//
//  InfoView.swift
//  FitLogz
//
//  Created by Kaival Patel on 17/12/2024.
//

import SwiftUI
import Charts
import Observation

struct InfoView: View {
    
    var quotes: [Quote] = [
        Quote(text: "All progress takes place outside the comfort zone.", author: "Chris Bumstead"),
        Quote(text: "The mind is the limit. When you're ready, your body will follow.", author: "David Goggins"),
        Quote(text: "Discipline equals freedom.", author: "Jocko Willink"),
        Quote(text: "You're one workout away from a better mood.", author: "Jeff Nippard"),
        Quote(text: "Focus on progress, not perfection.", author: "Whitney Simmons"),
        Quote(text: "The only person you should try to be better than is the person you were yesterday.", author: "Mike O'Hearn"),
        Quote(text: "What hurts today makes you stronger tomorrow.", author: "Jay Cutler"),
        Quote(text: "Your only limit is you.", author: "Bradley Martyn"),
        Quote(text: "Small daily improvements are the key to long-term success.", author: "Jeremy Ethier"),
        Quote(text: "Consistency over intensity.", author: "Athlean-X"),
        Quote(text: "Mental toughness is built through physical challenges.", author: "David Goggins"),
        Quote(text: "Every rep counts. Make them all quality.", author: "Ronnie Coleman"),
        Quote(text: "The hardest lift of the day is lifting yourself out of bed.", author: "Noel Deyzel"),
        Quote(text: "Stop wishing, start doing.", author: "Pamela Reif"),
        Quote(text: "The pain of discipline weighs ounces, but the pain of regret weighs tons.", author: "Rich Piana")
    ]
    
    @State var isShowingSheet:Bool = false
    @State var weight:Double? = nil
    var User : User? = AuthConnect.Singleton.user
    @State private var currentQuote: Quote

    
    init() {
        _currentQuote = State(initialValue: quotes.randomElement()!)
    }
    
    var body: some View {
        ZStack() {
            Color.backGround
                .ignoresSafeArea(.all)
            
            ScrollView {
                
                HeaderView()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(currentQuote.text)
                        .font(.custom("LilitaOne", size: 18))
                        .foregroundStyle(Color.defWhite)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(4)
                    
                    HStack(spacing: 4) {
                        Text("-")
                            .font(.custom("Ligconsolata", size: 12))
                            .foregroundStyle(Color.defSecondary)
                        Text(currentQuote.author)
                            .font(.custom("Ligconsolata", size: 12))
                            .foregroundStyle(Color.defSecondary)
                            .fontWeight(.medium)
                    }
                }
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.defPrimary)
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
                )
                .padding(.horizontal)
                
                VStack {
                    
                    HStack(spacing: 20) {
                        ProgessActivityCircle(
                            heading: "Steps",
                            goal:AuthConnect.Singleton.user?.daily_steps_goal ?? "0",
                            actual: HealthConnect.Singleton.stepCount,
                            color: .green, symbol: "shoeprints.fill",
                            symbolColor: .defSecondary
                        )
                        
                        ProgessActivityCircle(
                            heading:"Calories",
                            goal: AuthConnect.Singleton.user?.daily_calories_goal ?? "0",
                            actual: HealthConnect.Singleton.activeEnergyBurned,
                            color: .orange,
                            symbol: "flame.fill",
                            symbolColor: .red
                        )
                    }
                    .padding()
                    
                    
                    VStack{
                        
                        ZStack {
                            
                            if (AuthConnect.Singleton.userWeightsHistory != nil)
                            {
                                ChartView(dataList: AuthConnect.Singleton.userWeightsHistory!.weights)
                                
                            }
                            else {
                                Text("No Weight History , Please Add Weight")
                                    .font(.headline)
                                    .foregroundColor(Color.red)
                            }
                        }
                        .frame(width: 340,height: 240)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.defPrimary)
                                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                        )
                        .accentColor(Color.defSecondary)
                        
                        
                        Button(action: {
                            isShowingSheet.toggle()
                        }) {
                            HStack {
                                Image(systemName: "plus")
                                Text("Weigh In")
                            }
                            .foregroundStyle(Color.white)
                            .padding(.vertical, 15)
                            .padding(.horizontal, 50)
                            .background(Color.defSecondary)
                            .cornerRadius(20)
                        }
                        //.padding(.horizontal,10)
                        .sheet(isPresented: $isShowingSheet , onDismiss: {
                            AuthConnect.Singleton.getUsersHistory()

                        }) {
                            WeighInView(isShowingSheet: $isShowingSheet)
                        }
                    }
                }
            }.refreshable {
                HealthConnect.Singleton.fetchDailyHealthData()
                AuthConnect.Singleton.getUsersHistory()
                currentQuote = quotes.randomElement()!
            }
        }
    }
}

#Preview {
    InfoView()
}

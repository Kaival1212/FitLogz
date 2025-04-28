//
//  LogSetView.swift
//  FitLogz
//
//  Created by Kaival Patel on 17/12/2024.
//

import SwiftUI



struct LogSetView: View {
    
    @State private var exercises: [Exercise] = []
    
    
    private var groupedExercises: [(group: String, items: [Exercise])] {
        Dictionary(grouping: exercises, by: { $0.muscleGroup })
            .map { key, value in
                (key, value.sorted { $0.name < $1.name })
            }
            .sorted { $0.0 < $1.0 }
    }
    
    @State private var showingAddSheet = false
    
    var body: some View {
        ZStack {
            Color.backGround.ignoresSafeArea()
            
            ScrollView {
                HeaderView()

                
                LazyVStack(spacing: 14, pinnedViews: []) {
                    
                    ForEach(groupedExercises, id: \.group) { group in
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text(group.group)
                                .font(.custom("LilitaOne", size: 22))
                                .foregroundStyle(Color.defSecondary)
                                .padding(.horizontal, 8)
                            
                            ForEach(group.items) { exercise in
                                NavigationLink {
                                                                        SetsView(exercise: exercise)
                                } label: {
                                    HStack {
                                        Text(exercise.name)
                                            .font(.custom("Ligconsolata", size: 16))
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundStyle(Color.defSecondary)
                                    }
                                    .padding(12)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.defPrimary)
                                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                                    )
                                }                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 80)
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        showingAddSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(Color.white)
                            .padding(20)
                            .background(Color.defSecondary)
                            .clipShape(Circle())
                            .shadow(radius: 6)
                    }
                    .padding(.trailing, 24)
                    .padding(.bottom, 20)
                    .sheet(isPresented: $showingAddSheet , onDismiss: {
                        fetchExercises()
                    }) {
                        AddExerciseView()
                    }
                }
            }
        }
        .onAppear() {
            fetchExercises()
        }
        
    }
    
    private func fetchExercises() {
        UserFoodApi.getExercies { result in
            switch result {
            case .success(let list):
                exercises = list
            case .failure(let err):
                print("API error:", err)
            }
        }
    }

}

#Preview {
    LogSetView()
}

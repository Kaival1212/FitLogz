//
//  SetsView.swift
//  FitLogz
//
//  Created by Kaival Patel on 28/04/2025.
//

import SwiftUI

struct SetsView: View {
    let exercise: Exercise
    @State private var sets: [WorkoutSet] = []
    @State private var recommendation: String? = nil
    @State private var showingAddSheet = false

    var body: some View {
        ZStack {
            Color.backGround.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {

                    if let recommendation {
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "lightbulb.fill")
                                .font(.title2)
                                .foregroundStyle(.yellow)
                            Text(recommendation)
                                .font(.custom("LilitaOne", size: 16))
                                .foregroundStyle(.defWhite)
                                .multilineTextAlignment(.leading)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.defSecondary)
                                .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 3)
                        )
                        .padding(.horizontal)
                    }

                    ForEach(sets) { set in
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text("Weight")
                                Spacer()
                                Text("\(set.weight, specifier: "%.1f") kg")
                            }
                            HStack {
                                Text("Reps")
                                Spacer()
                                Text("\(set.reps)")
                            }
                            HStack {
                                Text("Intensity")
                                Spacer()
                                Text(set.intensity)
                            }
                            
                            Text(String(set.createdAt.prefix(10)))   // ➜ "2025-04-28"
                                .font(.custom("Ligconsolata", size: 13))
                                .foregroundStyle(Color.defSecondary)
                            
                            
                        }
                        .font(.custom("Ligconsolata", size: 15))
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.defPrimary)
                                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                        )
                        .padding(.horizontal)
                    }

                    Spacer(minLength: 100)
                }
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
                            .padding(22)
                            .background(Color.defSecondary)
                            .clipShape(Circle())
                            .shadow(radius: 6)
                    }
                    .padding(.trailing, 24)
                    .padding(.bottom, 20)
                    .sheet(isPresented: $showingAddSheet , onDismiss: {
                        Task {
                            await fetchSets()
                            await fetchRecommendation()
                        }
                    }) {
                        AddSetView(
                            exercise: exercise,
                            onSaved: {
                                Task {
                                    await fetchSets()
                                    await fetchRecommendation()
                                }
                            }
                        )
                        .presentationDetents([.medium])
                    }
                }
            }
        }
        .navigationTitle(exercise.name)
        .toolbarBackground(Color.backGround, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .task {
            await fetchSets()
            await fetchRecommendation()
        }
    }

    private func fetchSets() async {
        UserFoodApi.getSets(for: exercise.id) { result in
            switch result {
            case .success(let list): sets = list
            case .failure(let err):  print("API error:", err)
            }
        }
    }

    private func fetchRecommendation() async {
        UserFoodApi.getRecommendation(exerciseID: exercise.id) { result in
            switch result {
            case .success(let text): recommendation = text
            case .failure(let err):  print("API error:", err)
            }
        }
    }
}

#Preview {
    SetsView(
        exercise: Exercise(id: 1, name: "Bench Press", muscleGroup: "Chest")
    )
}

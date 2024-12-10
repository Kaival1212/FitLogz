//
//  ChartView.swift
//  FitLogz
//
//  Created by Kaival Patel on 24/12/2024.
//

import SwiftUI
import Charts


struct ChartView: View {
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_GB")
        return formatter
    }()
    
    var dataList: [UserWeight]
    
    private func formatDate(_ dateString: String) -> Date {
        dateFormatter.date(from: dateString) ?? Date()
    }
    
    var body: some View {
        
        Chart(dataList) {
            LineMark(
                x: .value("Date", formatDate($0.created_at)),
                y: .value("Weight (kg)", $0.weight)
            )
            .interpolationMethod(.catmullRom) // Smooths out the line
            .foregroundStyle(Color.green.gradient)
            .lineStyle(StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        }
        .padding()

    }
}

#Preview{
    
    let list: [UserWeight] = [
        UserWeight(id: 1, user_id: 101, weight: 85.2, unit: "kg", created_at: "2024-09-01T08:00:00.000Z", updated_at: "2024-09-01T08:00:00.000Z"),
        UserWeight(id: 2, user_id: 101, weight: 84.8, unit: "kg", created_at: "2024-09-08T08:00:00.000Z", updated_at: "2024-09-08T08:00:00.000Z"),
        UserWeight(id: 3, user_id: 101, weight: 84.3, unit: "kg", created_at: "2024-09-15T08:00:00.000Z", updated_at: "2024-09-15T08:00:00.000Z"),
        UserWeight(id: 4, user_id: 101, weight: 84.5, unit: "kg", created_at: "2024-09-22T08:00:00.000Z", updated_at: "2024-09-22T08:00:00.000Z"),
        UserWeight(id: 5, user_id: 101, weight: 84.1, unit: "kg", created_at: "2024-09-29T08:00:00.000Z", updated_at: "2024-09-29T08:00:00.000Z"),
        UserWeight(id: 6, user_id: 101, weight: 83.7, unit: "kg", created_at: "2024-10-06T08:00:00.000Z", updated_at: "2024-10-06T08:00:00.000Z"),
        UserWeight(id: 7, user_id: 101, weight: 83.9, unit: "kg", created_at: "2024-10-13T08:00:00.000Z", updated_at: "2024-10-13T08:00:00.000Z"),
        UserWeight(id: 8, user_id: 101, weight: 83.4, unit: "kg", created_at: "2024-10-20T08:00:00.000Z", updated_at: "2024-10-20T08:00:00.000Z"),
        UserWeight(id: 9, user_id: 101, weight: 83.0, unit: "kg", created_at: "2024-10-27T08:00:00.000Z", updated_at: "2024-10-27T08:00:00.000Z"),
        UserWeight(id: 10, user_id: 101, weight: 82.8, unit: "kg", created_at: "2024-11-03T08:00:00.000Z", updated_at: "2024-11-03T08:00:00.000Z"),
        UserWeight(id: 11, user_id: 101, weight: 82.5, unit: "kg", created_at: "2024-11-10T08:00:00.000Z", updated_at: "2024-11-10T08:00:00.000Z"),
        UserWeight(id: 12, user_id: 101, weight: 82.7, unit: "kg", created_at: "2024-11-17T08:00:00.000Z", updated_at: "2024-11-17T08:00:00.000Z"),
        UserWeight(id: 13, user_id: 101, weight: 82.2, unit: "kg", created_at: "2024-11-24T08:00:00.000Z", updated_at: "2024-11-24T08:00:00.000Z"),
        UserWeight(id: 14, user_id: 101, weight: 81.9, unit: "kg", created_at: "2024-12-01T08:00:00.000Z", updated_at: "2024-12-01T08:00:00.000Z"),
        UserWeight(id: 15, user_id: 101, weight: 81.7, unit: "kg", created_at: "2024-12-08T08:00:00.000Z", updated_at: "2024-12-08T08:00:00.000Z"),
        UserWeight(id: 16, user_id: 101, weight: 81.4, unit: "kg", created_at: "2024-12-15T08:00:00.000Z", updated_at: "2024-12-15T08:00:00.000Z"),
        UserWeight(id: 17, user_id: 101, weight: 81.6, unit: "kg", created_at: "2024-12-22T08:00:00.000Z", updated_at: "2024-12-22T08:00:00.000Z")
    ]

    ChartView(dataList: list)
}

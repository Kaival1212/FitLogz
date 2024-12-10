//
//  HealthConnect.swift
//  FitLogz
//
//  Created by Kaival Patel on 12/12/2024.
//

import Foundation
import HealthKit
import UIKit
import SwiftUICore


class HealthConnect:ObservableObject{
    
    var healthStore: HKHealthStore = HKHealthStore()
    var stepCount : Int = 0
    var activeEnergyBurned : Int = 0
    var isAuthorized: Bool = false
    
    static var Singleton = HealthConnect()
    
    init() {
        healthStore = HKHealthStore()
        requestAuthorization()
        fetchDailyHealthData()
    }
    
    
    func requestAuthorization() {
        let typesToRead: Set<HKObjectType> = [HKObjectType.quantityType(forIdentifier: .stepCount)!,HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!]
        healthStore.requestAuthorization(toShare: [], read: typesToRead) { success, error in
            if success{
                self.isAuthorized = true
            }
            if let error{print(error)}
        }
    }
    
    func fetchDailyHealthData()  {
             getStepCount()
             getActiveEnergyBurned()
        }
    
    func getStepCount(){
        guard let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount) else { return }
        
        let startOfDay = Calendar.current.startOfDay(for: Date())
        let endOfDay = Date()

        let stepsPredicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
        
        let stepsQuery = HKStatisticsQuery(quantityType: stepCountType,quantitySamplePredicate: stepsPredicate , options: .cumulativeSum) { query, result, error in
        
            if let error{
                print(error)
                return
            }
            
            guard let result=result , let sum=result.sumQuantity() else { return }
            
            let steps = Int(sum.doubleValue(for: HKUnit.count()))
            self.stepCount = steps
                    
        }
        healthStore.execute(stepsQuery)
    }
    
    func getActiveEnergyBurned() {
        guard let activeEnergyBurnedType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else { return }
        
        let startOfDay = Calendar.current.startOfDay(for: Date())
        let endOfDay = Date()
        let activeEnergyBurnedPredicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
        
        let activeEnergyBurnedQuery = HKStatisticsQuery(quantityType: activeEnergyBurnedType,quantitySamplePredicate: activeEnergyBurnedPredicate , options: .cumulativeSum) { query, result, error in
            
            if let error {
                print("Error: \(error)")
                return
            }
            
            guard let result else { return }
            
            let activeEnergyBurned = Int(result.sumQuantity()!.doubleValue(for: HKUnit.kilocalorie()))
            self.activeEnergyBurned = activeEnergyBurned
            
        }
        healthStore.execute(activeEnergyBurnedQuery)
    }
    
    
}

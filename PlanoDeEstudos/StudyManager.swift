//
//  StudyManager.swift
//  PlanoDeEstudos
//
//  Created by administrator on 4/6/22.
//  Copyright © 2022 Eric Brito. All rights reserved.
//

import Foundation

class StudyManager {
    static let shared = StudyManager()
    private let studyPlanKey: String = "studyPlans"
    
    let ud = UserDefaults.standard
    var studyPlans: [StudyPlan] = []
    
    private init(){
        if let data = ud.data(forKey: studyPlanKey), let plans = try? JSONDecoder().decode([StudyPlan].self, from: data) {
            self.studyPlans = plans
        }
    }
    
    func savePlans(){
        if let data = try? JSONEncoder().encode(studyPlans) {
            ud.set(data, forKey: studyPlanKey)
        }
    }
    
    func addPlan(_ plan: StudyPlan){
        studyPlans.append(plan)
        savePlans()
    }
    
    func removePlan(at indexPlan: Int){
        studyPlans.remove(at: indexPlan)
        savePlans()
    }
}
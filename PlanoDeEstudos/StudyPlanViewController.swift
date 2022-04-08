//
//  StudyViewController.swift
//  PlanoDeEstudos
//
//  Created by administrator

import UIKit
import UserNotifications

class StudyPlanViewController: UIViewController {

    @IBOutlet weak var tfCourse: UITextField!
    @IBOutlet weak var tfSection: UITextField!
    @IBOutlet weak var dpDate: UIDatePicker!
    
    let studyManager = StudyManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func schedule(_ sender: UIButton) {
        let id = String(Date().timeIntervalSince1970)
        
        let studyPlan = StudyPlan(course: tfCourse.text!, section: tfSection.text!, date: dpDate.date, done: false, id:  id)
        
        let content = UNMutableNotificationContent()
        content.title = "Lembrete"
        content.subtitle = "Materia: \(studyPlan.course)"
        content.body = "Estudar \(studyPlan.section)"
        
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dpDate.date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        studyManager.addPlan(studyPlan)
        navigationController?.popViewController(animated: true)
    }
    
}

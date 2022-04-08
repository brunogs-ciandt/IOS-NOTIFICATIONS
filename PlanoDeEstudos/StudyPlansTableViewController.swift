//
//  NotificationsTableViewController.swift
//  PlanoDeEstudos
//
//  Created by administrator
//

import UIKit

class StudyPlansTableViewController: UITableViewController {

    let studyManager = StudyManager.shared
    
    let dateFormater: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy HH:mm"
        return df
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onReceived(notification:)), name: NSNotification.Name(rawValue: "StudyReceived"), object: nil)
    }
    
    @objc func onReceived(notification: Notification){
        if let userInfo = notification.userInfo, let id = userInfo["id"] {
            let study = studyManager.studyPlans.first(where: { $0.id == id as! String })
            study?.done = true
            
            tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyManager.studyPlans.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let studyPlan = studyManager.studyPlans[indexPath.row]
        cell.textLabel?.text = studyPlan.section
        cell.detailTextLabel?.text = dateFormater.string(from: studyPlan.date)
        
        cell.backgroundColor = studyPlan.done ? .green : .white
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            studyManager.studyPlans.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }


}

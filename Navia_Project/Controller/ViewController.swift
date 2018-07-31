//
//  ViewController.swift
//  Navia_Project
//
//  Created by Arinjay on 26/07/18.
//  Copyright © 2018 Arinjay. All rights reserved.
//

import UIKit
import UserNotifications


// MARK:- Extenstion
extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    // MARK:- Variables
    let val:NSData? = nil
    var notificationsList:NSArray = NSArray()
    var localNotification:UILocalNotification?
    var hero = [Health]()
    var currentCount = 0
    var getValue = false
    var currentArray = [String]()
    var cheatDay = ["Cheat Day !!!  Eat Anything"]
    var dayPresent = false
    var getCurrenDay = ""
    
    @IBOutlet weak var tableview: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.navigationItem.title = Date().dayOfWeek()
        self.getCurrenDay = (Date().dayOfWeek()?.lowercased())!
        
        if cheatDay.contains(getCurrenDay){
            print("yes")
        }
       
        downloadJSON {
            //print(self.getCurrenDay)
            self.getValue = true
            
            // Checking dayCount of the dayArray in API
            if self.getCurrenDay == "wednesday"{
                self.currentCount = self.hero[0].week_diet_data.wednesday.count
            } else if self.getCurrenDay == "monday"{
                self.currentCount = self.hero[0].week_diet_data.monday.count
            } else if self.getCurrenDay == "thursday" {
                self.currentCount = self.hero[0].week_diet_data.thursday.count
            }
            self.tableview.reloadData()
            print("success parsed JSON Data")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name(rawValue: "reloadData"), object: nil)
       
       
    }
    
    // MARK:- JSON downloading
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "http://naviadoctors.com/dummy/")
        //let url = URL(string: "https://api.coinmarketcap.com/v1/ticker/?limit=10")
        
        //URLSession.shared.dataTask(with: url!) { (data, response, error) in
        URLSession.shared.dataTask(with: url!) { [weak self](data, response, error) in
            if error == nil {
                do
                {
                    self?.hero = [try JSONDecoder().decode(Health.self, from: data!)]
                    DispatchQueue.main.async {
                        completed()
                        self?.printf()
                    }
                }catch {
                    print(error)
                }
            }
        }.resume()
    }
    

    // MARK:- TableView DataSource Functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if getValue {
            return currentCount
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    

        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        if getValue {
            
            // Checking current day and displaying relevant data of that day
            if getCurrenDay == "monday"{
                cell.notificationTitleLabel.text = hero[0].week_diet_data.monday[indexPath.row].food
            } else if getCurrenDay == "wednesday" {
              cell.notificationTitleLabel.text = hero[0].week_diet_data.wednesday[indexPath.row].food
            } else {
                cell.notificationTitleLabel.text = hero[0].week_diet_data.wednesday[indexPath.row].food
            }
        } else {
            cell.notificationTitleLabel.text = cheatDay[0]
        }
        
        return cell
    }
    
    // MARK:- TableView Delegate Functions
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let app = UIApplication.shared
        var eventArray: [Any]? = app.scheduledLocalNotifications
        let oneEvent = eventArray?[indexPath.row] as? UILocalNotification
        
        app.cancelLocalNotification(oneEvent!)
        self.tableview.reloadData()
        
        
        
    }
    
    // MARK:- Helper Functions
    
    func printf() {
        //print(self.currentArray[0])
        print(hero[0].week_diet_data.thursday[2].food)
        self.tableview.reloadData()
    }
    
    func reloadTableView(){
        self.tableview.reloadData()
    }
    
   
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        UIApplication.shared.cancelAllLocalNotifications()
        self.tableview.reloadData()
        
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "AddNotification", sender: self)
    }
    
}



//
//  AddViewController.swift
//  Navia_Project
//
//  Created by Arinjay on 26/07/18.
//  Copyright © 2018 Arinjay. All rights reserved.
//

import UIKit
import UserNotifications
class AddViewController: UIViewController {

    @IBOutlet weak var remainderTextfield: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        let pickerDate:Date = self.datePicker.date
        let time:TimeInterval = floor((pickerDate.timeIntervalSinceReferenceDate)/60.0 * 60.0)
        let notificationFireDate:Date = Date.init(timeIntervalSinceReferenceDate: time)
        let localNotification:UILocalNotification = UILocalNotification()
        localNotification.fireDate = notificationFireDate
        localNotification.repeatInterval = .day
        localNotification.alertBody = self.remainderTextfield.text
        localNotification.timeZone = NSTimeZone.default
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber+1
        UIApplication.shared.scheduleLocalNotification(localNotification)
        NotificationCenter.default.post(name: Notification.Name("reloadData"), object: self)
        self.dismiss(animated: false, completion: nil)
    }
}

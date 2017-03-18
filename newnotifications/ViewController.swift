//
//  ViewController.swift
//  newnotifications
//
//  Created by Joy on 3/18/17.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            if granted {
                print("Notification access granted")
            } else {
                print(error?.localizedDescription)
            }
            
        })
    }


    @IBAction func sendNotification(_ sender: Any) {
        scheduleNotification(inSecond: 5, compeletion: { success in
            if success {
                print("Successfully")
            } else {
                print("error")
            }
            })
    }
    
    func scheduleNotification(inSecond: TimeInterval, compeletion: @escaping (_ Success: Bool) -> ()) {
        
        
        let notif = UNMutableNotificationContent()
        notif.title = "New Notification"
        notif.subtitle = "There are great!"
        notif.body = "The new notification in iOS 10 is what I always dreamed"
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSecond, repeats: false)
        
        let request = UNNotificationRequest(identifier: "my notificatio", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print (error)
                compeletion(false)
            } else {
                compeletion(true)
            }
        })
    }


}


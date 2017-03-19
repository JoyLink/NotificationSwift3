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
                print(error?.localizedDescription )
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
    
    func a(inSecond: TimeInterval, compeletion: (_ success: Bool) -> ()) {
        print("HI")
    }
    
    func scheduleNotification(inSecond: TimeInterval, compeletion: @escaping (_ Success: Bool) -> ()) {
        
        let myImage = "play"
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "png") else {
            compeletion(false)
            return
        }
        
        var attchmetn : UNNotificationAttachment
        
        attchmetn = try! UNNotificationAttachment(identifier: "my notification", url: imageUrl, options: .none)
        
        let notif = UNMutableNotificationContent()
        
        
        notif.categoryIdentifier = "myNotificationCategory"
            
        
        
        notif.title = "New Notification"
        notif.subtitle = "There are great!"
        notif.body = "The new notification in iOS 10 is what I always dreamed"
        notif.attachments = [attchmetn]
        
        
        
        
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


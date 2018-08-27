//
//  ViewController.swift
//  LocalNotificationDemo
//
//  Created by le.huu.dung on 8/27/18.
//  Copyright © 2018 le.huu.dung. All rights reserved.
//

import UIKit
import  UserNotifications
class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    var messageSubtitle = "Staff meeting in 20 minutes"
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            
        }
        UNUserNotificationCenter.current().delegate = self
        
    }
    
    @IBAction func buttonPress(_ sender: Any) {
        sendNotification()
    }
    
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Meeting Remider"
        content.subtitle = messageSubtitle
        content.body = "Don't forget to bring coffe"
        content.badge = 1
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let requestIdentifier = "demoNotification"
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            
        }
        
        let repeatAction = UNNotificationAction(identifier:"repeat",
                                                title:"Repeat",options:[])
        
        let changeAction = UNTextInputNotificationAction(identifier: "change",
                                                         title: "Change Message", options: [])
        
        let category = UNNotificationCategory(identifier: "actionCategory",
                                              actions: [repeatAction, changeAction],
                                              intentIdentifiers: [], options: [])
        
        content.categoryIdentifier = "actionCategory"
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
}


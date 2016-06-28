//
//  ViewController.swift
//  HabitsUnderGoodOrder
//
//  Created by MAC1 on 30/05/16.
//  Copyright © 2016 BTS. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    var numberOfNotifications = 0

    @IBOutlet weak var todaysDate: UILabel!
    
    @IBOutlet weak var yesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set today´s date in todaysDate label
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Day, fromDate: date)
        let day = components.day
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        dateFormatter.dateFormat = "MMMM"
        let monthName = dateFormatter.stringFromDate(date)
    
        self.todaysDate.text = String(monthName) + " " + String(day)
        
        // self.todaysDate.text = day + " " + month + " " + year
        
        // Use Realm to get the number of tasks
        // instantiate a Realm database. This object will access the database and let us query for number of objects
        let realm = try! Realm()
        // Get all the objects of type Task, and return the count
        if (realm.objects(Habit).count == 0) {
            editButton.title = "Done"
            self.habitCompletionQueryView.alpha = 0
            self.reminderSettingsView.alpha = 1
            
            // Get the task name from the alert field
            //let habitName = ""
            // Create a new Habit object
            let habit = Habit()
            // set the habit name to the one entered by the user
            //habit.name = self.habitName.text!
            // The Task object is created, we need to save it to the database
            let realm = try! Realm()
            // Open a write transaction: we're telling Realm that we're going to write some stuff to the DB
            try! realm.write {
                // Inside the brackets is part of the transaction, we need to save the objects in here
                // The app crashes if you try realm.add() outside a "write { }"
                realm.add(habit)
            }
        } else {
            editButton.title = "Edit"
            self.reminderSettingsView.alpha = 0
            self.habitCompletionQueryView.alpha = 1
            // Lock habit name editor
            habitName.enabled = false
        }
        
        let habit = realm.objects(Habit).first
        habitName.text = habit!.name
        
        didYouHabitTodayQuestion.text = "Did you \(habit!.name) today?"
        
        goodHabitQuestionChange()
    }
    
    func goodHabitQuestionChange() {
        // instantiate a Realm database. This object will access the database and let us query for number of objects
        let realm = try! Realm()
        
        let habit = realm.objects(Habit).first
        habitName.text = habit!.name
        
        // Check if the last event in the database is already for today
        if let existingEvent = realm.objects(Event).last {
            if NSCalendar.currentCalendar().isDateInToday(existingEvent.date) {
                yesButton.hidden = true
                didYouHabitTodayQuestion.text = "Good habit completed for today\n\nTo \(habit!.name) everyday is beneficial to your well being :)\n\nCheck back tomorrow!"
            } else {
                yesButton.hidden = false
            }
        } else {
            yesButton.hidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBOutlet weak var habitName: UITextField!

    @IBOutlet weak var reminderSettingsView: UIView!
    @IBOutlet weak var habitCompletionQueryView: UIView!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    @IBAction func doneButtonPressed(sender: UIButton) {
        saveHabitDetails()
    }
    
    @IBAction func editButtonPressed(sender: UIBarButtonItem) {
        
        if (sender.title == "Edit") {
            habitName.enabled = true
            // Click edit to display the reminders settings view and change the button title to done
            sender.title = "Done"
            UIView.animateWithDuration(0.3, animations: { 
                self.habitCompletionQueryView.alpha = 0
                self.reminderSettingsView.alpha = 1
            })
        } else {
            saveHabitDetails()
        }
    }
    
    func saveHabitDetails() {
        editButton.title = "Edit"
        UIView.animateWithDuration(0.3, animations: {
            self.reminderSettingsView.alpha = 0
            self.habitCompletionQueryView.alpha = 1
        })
        
        habitName.enabled = false
        
        // The Task object is created, we need to save it to the database
        let realm = try! Realm()
        
        // Create a new Habit object
        let habit = realm.objects(Habit).first
        
        // Open a write transaction: we're telling Realm that we're going to write some stuff to the DB
        
        try! realm.write {
            // Inside the brackets is part of the transaction, we need to save the objects in here
            // The app crashes if you try realm.add() outside a "write { }"
            //realm.add(habit)
            // set the habit name to the one entered by the user
            habit!.name = self.habitName.text!
        }
        
        didYouHabitTodayQuestion.text = "Did you \(habit!.name) today?"
        
        // Unschedule any previously set notifications
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        // Create a local notification to schedule it
        let notification = UILocalNotification()
        // Set the notification for 10 seconds from now
        notification.fireDate = datePicker.date
        // Set the title of the notification
        notification.alertBody = "You need to \(habit!.name) today :) Done?"
        // Set the badge number that will show in the app icon
        numberOfNotifications = 1
        notification.applicationIconBadgeNumber = numberOfNotifications
        // Use the notification identifier to get the Yes/No acitons
        notification.category = "YesNoNotification"
        // Repeat the notifiation to a specified schedule
        notification.repeatInterval = .Day
        // Tell the UIApplication (main global object for the current app)
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        goodHabitQuestionChange()

    }
    
    @IBOutlet weak var didYouHabitTodayQuestion: UILabel!
    
    @IBAction func yesButtonPressed(sender: UIButton) {

        // Create a new event object
        let event = Event()
        // set whether the event is completed or not
        event.completed = true
        // The Task object is created, we need to save it to the database
        let realm = try! Realm()
        
        // Check if the last event in the database is already for today
        if let existingEvent = realm.objects(Event).last {
            if NSCalendar.currentCalendar().isDateInToday(existingEvent.date) {
                return
            }
        }
        
        // Open a write transaction: we're telling Realm that we're going to write some stuff to the DB
        try! realm.write {
            // Inside the brackets is part of the transaction, we need to save the objects in here
            // The app crashes if you try realm.add() outside a "write { }"
            realm.add(event)
        }
        
        goodHabitQuestionChange()
        
        performSegueWithIdentifier("goToHabitHistory", sender: nil)
    }
    
    /*@IBAction func noButtonPressed(sender: UIButton) {
        // Create a new event object
        let event = Event()
        // set whether the event is completed or not
        event.completed = false
        // The Task object is created, we need to save it to the database
        let realm = try! Realm()
        // Open a write transaction: we're telling Realm that we're going to write some stuff to the DB
        try! realm.write {
            // Inside the brackets is part of the transaction, we need to save the objects in here
            // The app crashes if you try realm.add() outside a "write { }"
            realm.add(event)
        }
        
        performSegueWithIdentifier("goToHabitHistory", sender: nil)
    } */
    
    @IBAction func habitHistoryButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("goToHabitHistory", sender: nil)
    }
}


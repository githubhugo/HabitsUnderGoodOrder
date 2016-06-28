//
//  Habit.swift
//  HabitsUnderGoodOrder
//
//  Created by MAC1 on 30/05/16.
//  Copyright © 2016 BTS. All rights reserved.
//

import UIKit
import RealmSwift

// This is our model class. Every object of type Task will be a Realm Object, and can be saved to the database.
// It's a regular object but we subclass from "Object" which is Realm's base class
class Habit: Object {
    // We need to add dynamic, otherwise it's regular properties
    // The name of the task (e.g. run, yoga)
    dynamic var name = ""

    // Start date of the habit
    dynamic var startDate = NSDate()
    
    // Time of the daily reminder alarm
    dynamic var notificationTime = NSDate()
    
    //Daily notification, every 1 day
    dynamic var frequency = 1
    
    // A Habit has an array of commits and each commit only has one Habit
    let commits = List<Event>()
    
    //let someCommits = realm.objects(Commit).filter
}


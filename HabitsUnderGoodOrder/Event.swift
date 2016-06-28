//
//  Event.swift
//  HabitsUnderGoodOrder
//
//  Created by MAC1 on 30/05/16.
//  Copyright © 2016 BTS. All rights reserved.
//

import UIKit
import RealmSwift

class Event: Object {
    
    // When the event happened
    dynamic var date = NSDate()
    
    //Whether the user complete the commitment or not
    dynamic var completed = false
    
}
//
//  EventsTableViewController.swift
//  HabitsUnderGoodOrder
//
//  Created by MAC1 on 08/06/16.
//  Copyright © 2016 BTS. All rights reserved.
//

import UIKit
import RealmSwift

class EventsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let realm = try! Realm()
        
        completedHabitCount.text = "Good habit completed for \(realm.objects(Event).count) days"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    @IBOutlet weak var completedHabitCount: UILabel!
    
    
    
    // Since we set this controller as the tableView delegate, the tableView asks us how many rows it needs to display
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Use Realm to get the number of tasks
        // instantiate a Realm database. This object will access the database and let us query for number of objects
        let realm = try! Realm()
        // Get all the objects of type event, and return the count
        return realm.objects(Event).count
    }
    
    // This controller is the tableView dataSource, so the tableView will ask us every time it needs to display a row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Instantiate a cell from the prototype in the Storyboard
        // the identifier is the same one we specify in the Table View Cell properties in the storyboard
        let cell = tableView.dequeueReusableCellWithIdentifier("EventView")!
        
        // Instantiate Realm database
        let realm = try! Realm()
        
        // Get the correct Task from the Database so we can configure the row
        let event = realm.objects(Event).sorted("date", ascending: false)[indexPath.row]
        
        // Set the left-side text to the task name
        let date = event.date
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Day, fromDate: date)
        let day = components.day
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        dateFormatter.dateFormat = "MMMM"
        let monthName = dateFormatter.stringFromDate(date)
        
        cell.textLabel!.text = String(monthName) + " " + String(day)
        
        // Set the right side text depending on if the task is completed or not
        if event.completed {
            // If the task is completed we show the checkmark on the left
            cell.detailTextLabel!.text = "✓"
            cell.textLabel!.alpha = 1
        } else {
            // If it's not completed we don't show anything on the left
            cell.detailTextLabel!.text = ""
            cell.textLabel!.alpha = 1
        }
        
        return cell
    }

    
    
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

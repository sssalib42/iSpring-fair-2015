//
//  InterviewsTableViewController.swift
//  iTech Fair 2015
//
//  Created by Samer Salib on 2/21/15.
//  Copyright (c) 2015 Samer Salib. All rights reserved.
//

import UIKit
import CoreData

class InterviewsTableViewController: UITableViewController {

    var myInterviews: Array<AnyObject> = []
    var accessoryIndex : NSIndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(animated: Bool) {
            //create instance of the app delegate
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            //retrive NSMContext
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
            // instance of our NS fetch request
        let fetchRequest = NSFetchRequest(entityName: "Interview")
        
            //populate the array from the database
        myInterviews = context.executeFetchRequest(fetchRequest, error: nil)!
        
            //reload the data everytime the table is presented
        tableView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myInterviews.count
    }

    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("interviewCell", forIndexPath: indexPath) as UITableViewCell

        
        cell.textLabel?.text = (myInterviews[indexPath.row] as Interview).company
        
        var locDetails: String = (myInterviews[indexPath.row] as Interview).location
        
        var formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .ShortStyle
        var dateDetails: String =  formatter.stringFromDate((myInterviews[indexPath.row] as Interview).date )
        
        cell.detailTextLabel?.text! = locDetails + " on " + dateDetails
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            //create instance of the app delegate
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            //retrive NSMContext
            let context: NSManagedObjectContext = appDelegate.managedObjectContext!
                // Delete the row from the data source
            context.deleteObject(myInterviews[indexPath.row] as NSManagedObject)
            //save our context
            context.save(nil)
            myInterviews.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        //accessoryIndex = indexPath
        //performSegueWithIdentifier("notesSegue", sender: indexPath)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
            //if an interview cell is selected
        if segue.identifier == "interviewSegue"{
            
                //refrence the selcted interview
            let selectedInterview: NSManagedObject = myInterviews[self.tableView.indexPathForSelectedRow()!.row] as NSManagedObject
                //refrence the destination view
            let interviewAddingViewController: InterviewDatePickerViewController = segue.destinationViewController as InterviewDatePickerViewController
            
                //prepopulate the picker view with the chosen interview
            interviewAddingViewController.company       = selectedInterview.valueForKey("company")  as String
            interviewAddingViewController.location      = selectedInterview.valueForKey("location") as String
            interviewAddingViewController.date          = selectedInterview.valueForKey("date")     as NSDate
            interviewAddingViewController.existingInterview = selectedInterview
        }
            
            
            //if the detail accessory is tapped (interview notes)
        else if segue.identifier == "notesSegue"{
            
                //refrence the selcted interview
            if let myIndexPath = tableView.indexPathForCell(sender as UITableViewCell){
                let selectedInterview: NSManagedObject = myInterviews[myIndexPath.row] as NSManagedObject
            
                    //create instance of the app delegate
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
                    //retrive NSMContext
                let context: NSManagedObjectContext = appDelegate.managedObjectContext!
                    // instance of our NS fetch request
                let fetchRequest = NSFetchRequest(entityName: "Interview")
                var fetched = context.executeFetchRequest(fetchRequest, error: nil)
            
                    //refrence the destination view
                if let notesViewController: NotesViewController = segue.destinationViewController as? NotesViewController{
                        //prepopulate the picker view with notes of the chosen interview
                    notesViewController.existingNote  = selectedInterview.valueForKey("notes") as String
                    notesViewController.existingInterview = selectedInterview
                }
                else {
                    println("Error referencing NotesViewController")
                }
            
            }
            else{
                println("Error referencing indexpath")
            }
                //prepopulate the picker view with notes of the chosen interview
            //notesViewController.existingNote  = selectedInterview.valueForKey("notes") as String
            
            //notesViewController!.existingInterview!    = (selectedInterview as Interview)
            
            //println(segue.destinationViewController.description)
                //prepopulate the picker view with the chosen interview notes
        }
    }
    

}

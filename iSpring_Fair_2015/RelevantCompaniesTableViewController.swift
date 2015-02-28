//
//  RelevantCompaniesTableViewController.swift
//  iTech Fair 2015
//
//  Created by Samer Salib on 2/18/15.
//  Copyright (c) 2015 Samer Salib. All rights reserved.
//

import UIKit
import CoreData

class RelevantCompaniesTableViewController: CareerFairTableViewController {
    var allCompanies: Array<AnyObject> = []
    var accessoryIndex : NSIndexPath!
    var relevantToAMajor: [AnyObject] = []
    var selectedMajor: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            //create instance of the app delegate
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            //retrive NSMContext
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
            // instance of our NS fetch request
        let fetchRequest = NSFetchRequest(entityName: "Company")
        
        //populate the array from the database
        allCompanies = context.executeFetchRequest(fetchRequest, error: nil)!
    }
    
    /*func updateRelevantCompaniesMajor(newMajor: String){
        //search through the list of companies for companies recruiting major
        relevantToAMajor = []
        for company in relevantToAMajor{
            if contains(company.majors!, newMajor){
                appendACompanyToAnArray(&relevantToAMajor, company: company)
            }
        }
    }*/

    override func viewWillAppear(animated: Bool){
        if(selectedMajor != nil){
            for company in allCompanies{
                var majorsText: String? = ( (company as NSManagedObject).valueForKey("majors") as String)
                if ( majorsText!.rangeOfString(selectedMajor) != nil) {
                        appendACompanyToAnArray( &relevantToAMajor, company: company as NSManagedObject)
                }
            }
        }
        else{println("error at reading selected major")}
        
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
        if let relevantComps : [NSManagedObject] = relevantToAMajor as? [NSManagedObject]{
            return relevantComps.count}
            //return 1}
        else{
            return 0
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("relevantCompanyCell", forIndexPath: indexPath) as UITableViewCell
        
        if let companies: [NSManagedObject] = relevantToAMajor as? [NSManagedObject]{
            cell.textLabel?.text = (relevantToAMajor[indexPath.row] as NSManagedObject).valueForKey("name") as? String
            cell.detailTextLabel?.text = (relevantToAMajor[indexPath.row] as NSManagedObject).valueForKey("majors") as? String
        }
        else{
            cell.textLabel?.text = "Empty!"
            cell.detailTextLabel?.text = "Search for a Major"
            cell.imageView?.image = UIImage(named: "checked_checkbox-26.png")
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("relevantCompanyCell", forIndexPath: indexPath) as UITableViewCell
        cell.imageView?.image = UIImage(named: "unchecked_checkbox-26.png")
    }

    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "companyPickerSegue"{
            var relevantCompsPickerViewController: searchRelevantViewController = (segue.destinationViewController as searchRelevantViewController)
            
            relevantCompsPickerViewController.myParentViewController = self
        }
        else {println("Error in segue")}
    }
    
    func setSelectedMajor(searchedMajor: String){
        selectedMajor = searchedMajor
        relevantToAMajor = Array<AnyObject>()
        println("selected major: \(selectedMajor)")
    }

}

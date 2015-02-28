//
//  MyCompaniesViewController.swift
//  iTech Fair 2015
//
//  Created by Samer Salib on 2/15/15.
//  Copyright (c) 2015 Samer Salib. All rights reserved.
//

import UIKit
import CoreData

class MyCompaniesViewController: UITableViewController{
    var allCompanies: Array<AnyObject> = []
    var myCompanies: [AnyObject] = []
    //myCompanies = companiesInfo
    
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
        
        
        //cloneCompaniesInfoArray(&myCompanies)
        //appendACompanyToAnArray(&myCompanies, company: companiesInfo[0])
        //appendACompanyToAnArray(&myCompanies, company: companiesInfo[1])

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return myCompanies.count
    }
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCompanyCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        let company: Company = myCompanies[indexPath.row] as Company
        cell.textLabel?.text = company.name
        //cell.detailTextLabel?.text = company.toSeperatedByCommas(company.workType!)
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
            // Delete the row from the data source
            myCompanies.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //var compDetailViewController: CompanyViewController = segue.destinationViewController as CompanyViewController
        //compDetailViewController.detailTextOutlet.text =
        
        
        /*if segue.identifier == "companyDetailView"{
            var selectedRow = self.tableView.indexPathForSelectedRow()
            var companyDetail: CompanyViewController = segue.destinationViewController as CompanyViewController
            companyDetail.company = myCompanies[selectedRow!.row]
        }*/
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

    


    

}

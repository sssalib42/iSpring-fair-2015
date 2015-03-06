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
    var myCompanies: [Company] = []
    //myCompanies = companiesInfo
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("my companies view did load")
            //create instance of the app delegate
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            //retrive NSMContext
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
            // instance of our NS fetch request
        let fetchRequest = NSFetchRequest(entityName: "Company")
            //populate the array from the database
        allCompanies = context.executeFetchRequest(fetchRequest, error: nil)!
        println("number of companies: " + "\(allCompanies.count)")
        
        
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

    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
        myCompanies = []
        println("myCompanies view did appear")
        var company: Company!
        for aCompany in allCompanies{
            company = Company(companyObj: aCompany as NSManagedObject)
            if let targeted = aCompany.valueForKey("targeted") as? Bool{
                if targeted{
                    //debugging
                    println("found a targeted company")
                    let name = aCompany.valueForKey("name") as String
                    println("Targeted: \(name)")//
                    myCompanies += [company]
                    println("my companies: \(myCompanies)")
                }
            }
        }
    }
    
    
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
        cell.detailTextLabel?.text   = company.valueForKey("number") as? String
        cell.detailTextLabel?.text! += ", "
        cell.detailTextLabel?.text! += company.valueForKey("location") as String
        return cell
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "myCompaniesDetailSegue"{
            if let myIndexPath = self.tableView.indexPathForCell(sender as UITableViewCell){
                let selectedCompany = myCompanies[myIndexPath.row]
                    //refrence the destination view
                if let detailViewController: CompanyViewController = segue.destinationViewController as? CompanyViewController{
                    //send the companies detail text
                    detailViewController.passedCompanyDetail = selectedCompany.valueForKey("detail") as String
                }
            }
        }
    }
    
    
    //MARK: Editing Style
    
    
        // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
            // Return NO if you do not want the specified item to be editable.
        return true
    }
    
        
    
        // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
        
    
        // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
    }
    
        
    
        // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }


}

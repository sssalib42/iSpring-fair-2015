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
                    var detail = selectedCompany.valueForKey("name") as String
                    detail += "\r"
                    detail += selectedCompany.valueForKey("website") as String
                    detail += "\r\rMajors: \r"
                    detail += selectedCompany.valueForKey("majors") as String
                    detail += "\r\rDesired degrees: \r"
                    detail += selectedCompany.valueForKey("desiredDegrees") as String
                    detail += "\r\rWork Type:\r"
                    detail += selectedCompany.valueForKey("workType") as String
                    detail += "\r\rDescription:\r"
                    detail += selectedCompany.valueForKey("detail") as String
                    detailViewController.passedCompanyDetail = detail
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
            if let name = myCompanies[indexPath.row].name{
                println("The relevant company's name is \(name)")
                for aCompany in allCompanies{
                    if aCompany.valueForKey("name") as String == name{
                        println("\(name) was found in the companies list.")
                        var targeted: Bool!
                        if (aCompany.valueForKey("targeted") as? Bool) != nil{
                            targeted = aCompany.valueForKey("targeted") as? Bool
                            print("The \(name) targetted state ")
                            if targeted!{
                                aCompany.setValue(false, forKey: "targeted")
                                myCompanies[indexPath.row].targeted = false
                                myCompanies.removeAtIndex(indexPath.row)
                                print(name)
                                println(" is no longer targetted now")
                            } else{
                                println(": error setting up the targetted value to false!")
                            }
                        } else{
                          println("The company has no set \"targeted\" value.")
                        }
                    }
                }
                    // Delete the row from the data source
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
        }
        else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
        
    
        /*/ Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCompanyCell", forIndexPath: fromIndexPath) as UITableViewCell
        let replacementCell = tableView.dequeueReusableCellWithIdentifier("myCompanyCell", forIndexPath: toIndexPath) as UITableViewCell
        
        let company: Company = myCompanies.removeAtIndex(fromIndexPath.row) as Company
        myCompanies.insert(company, atIndex: toIndexPath.row)
        cell.textLabel?.text = company.name
        cell.detailTextLabel?.text   = company.valueForKey("number") as? String
        cell.detailTextLabel?.text! += ", "
        cell.detailTextLabel?.text! += company.valueForKey("location") as String
        return cell
    }
    
        
    
        // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }*/


}

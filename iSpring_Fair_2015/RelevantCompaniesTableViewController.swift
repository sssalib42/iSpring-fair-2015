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
    var relevantToAMajor: [Company]!
    var selectedMajor: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("view loaded")
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
        allCompanies.sort( {$0.name < $1.name} )
        var company: Company!
        var companyMajors: [String]!
        println("View appeared")
        if(selectedMajor != nil){
            if relevantToAMajor == nil{
                relevantToAMajor = []
            }
            self.tableView.reloadData()
            for aCompany in allCompanies{
                company = Company(companyObj: aCompany as NSManagedObject)
                companyMajors = company.listOf(company.majors!)
                //println("name: \(company.name!)")
                //println(companyMajors!)
                for aMajor in companyMajors{
                    //println(aMajor)
                    if ( aMajor == selectedMajor) {
                        //println("\(company.name) was choosen")
                        relevantToAMajor! += [company]
                    }
                }
            }
        selectedMajor = nil
        }
        else{println("No newly selected major was found.")}
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("relevantCompanyCell", forIndexPath: indexPath) as UITableViewCell
        println("A relevant company was selected")
        if let name = relevantToAMajor[indexPath.row].name{
            println("The relevant company's name is \(name)")
            for aCompany in allCompanies{
                if aCompany.valueForKey("name") as String == name{
                    println("\(name) was found in the companies list.")
                    var targeted: Bool!
                    if (aCompany.valueForKey("targeted") as? Bool) != nil{
                    }
                    else{
                        aCompany.setValue(false, forPasteboardType: "false")
                    }
                    
                    targeted = aCompany.valueForKey("targeted") as? Bool
                    print("The \(name) targetted state ")
                    if !(targeted!){
                        aCompany.setValue(true, forKey: "targeted")
                        relevantToAMajor[indexPath.row].targeted = true
                        print(name)
                        println(" is targeted now")
                        self.tableView.reloadData()
                    } else if targeted!{
                        aCompany.setValue(false, forKey: "targeted")
                        relevantToAMajor[indexPath.row].targeted = false
                        print(name)
                        println(" is no longer targetted now")
                        self.tableView.reloadData()
                    } else{
                        println(": error setting up the targetted value!")
                    }
                    
                }
            }
        }
    }
    
    
    /*override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("relevantCompanyCell", forIndexPath: indexPath) as UITableViewCell
        if let name = relevantToAMajor[indexPath.row].name{
            for aCompany in allCompanies{
                if aCompany.valueForKey("name") as String == name{
                    aCompany.setValue(false, forKey: "targeted")
                    if let targeted = aCompany.valueForKey("targeted") as? Bool{
                        if targeted{
                            println("It's no longer targeted")
                        }
                        else {
                            println("The company is still targeted!")
                        }
                    }
                    cell.textLabel?.text = relevantToAMajor[indexPath.row].name!
                    cell.detailTextLabel?.text = relevantToAMajor[indexPath.row].workType!
                    cell.imageView?.image = UIImage(contentsOfFile: "checked_checkbox-26.png")
                }
            }
        }
    }*/
   

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
        if let relevantComps = relevantToAMajor as [Company]? {
            return relevantComps.count}
            //return 1}
        else{
            return 0
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("relevantCompanyCell", forIndexPath: indexPath) as UITableViewCell
        
        if relevantToAMajor != nil{
            let company = relevantToAMajor[indexPath.row]
            if (company.targeted != nil)&&(company.targeted!){
                cell.textLabel?.text = company.name!
                cell.detailTextLabel?.text = company.workType!
                cell.imageView?.image = UIImage(named: "checked_checkbox-26.png")
            }
            else{ //company is not targeted
                cell.textLabel?.text = company.name!
                cell.detailTextLabel?.text = company.workType!
                cell.imageView?.image = UIImage(named: "unchecked_checkbox-26.png")
            }
        }
        else{
            cell.textLabel?.text = "Empty!"
            cell.detailTextLabel?.text = "Search for a Major"
            cell.imageView?.image = UIImage(named: "unchecked_checkbox-26.png")
        }
        return cell
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
            
            
        else if segue.identifier == "relevantCompanyDetailSegue"{
            if let myIndexPath = tableView.indexPathForCell(sender as UITableViewCell){
                let selectedCompany = relevantToAMajor[myIndexPath.row]
                    //refrence the destination view
                if let detailViewController: CompanyViewController = segue.destinationViewController as? CompanyViewController{
                        //send the companies detail text
                    detailViewController.passedCompanyDetail = selectedCompany.valueForKey("detail") as String
                }
                else {
                    println("Error referencing CompanyViewController")
                }
            }
    
            
        else {println("Error in segue")}
        }
    }
    
    func setSelectedMajor(searchedMajor: String){
        selectedMajor = searchedMajor
        println("selected major: \(selectedMajor)")
        relevantToAMajor=[]
    }

}

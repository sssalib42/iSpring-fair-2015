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
    var relevantToAMajor: [AnyObject]!
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

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Tap to add to Favorites:"
    }
    override func viewWillAppear(animated: Bool){
        allCompanies.sort( {$0.name < $1.name} )
        var company: NSManagedObject!
        var tempCompany: Company!
        var companyMajors: [String]!
        println("relevantView appeared")
        if(selectedMajor != nil){
            if relevantToAMajor == nil{
                relevantToAMajor = []
            }
            self.tableView.reloadData()
            for aCompany in allCompanies{
                tempCompany = Company(companyObj: aCompany as NSManagedObject)
                companyMajors = tempCompany.listOf(tempCompany.majors!)
                //println("name: \(company.name!)")
                //println(companyMajors!)
                for aMajor in companyMajors{
                    //println(aMajor)
                    if ( aMajor == selectedMajor) {
                        //println("\(company.name) was choosen")
                        relevantToAMajor! += [aCompany]
                    }
                }
            }
        selectedMajor = nil
        }
        else{
            self.tableView.reloadData() //to sync changes of myCompanies view
            println("No newly selected major was found.")
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("relevantCompanyCell", forIndexPath: indexPath) as UITableViewCell
        println("A relevant company was selected")
        if let company : NSManagedObject = relevantToAMajor[indexPath.row] as? NSManagedObject{
            let name = company.valueForKey("name") as String
            println("The relevant company's name is \(name)")
            
            var targeted: Bool!
            if (company.valueForKey("targeted") as? Bool) != nil{
            }
            else{
                company.setValue(false, forKey: "targeted")
            }
            
            targeted = company.valueForKey("targeted") as? Bool
            print("The \(name) targetted state ")
            if !(targeted!){
                company.setValue(true, forKey: "targeted")
                print(name)
                println(" is targeted now")
                self.tableView.reloadData()
            } else if targeted!{
                company.setValue(false, forKey: "targeted")
                print(name)
                println(" is no longer targetted now")
                self.tableView.reloadData()
            } else{
                println(": error setting up the targetted value!")
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
        
        let company: NSManagedObject = relevantToAMajor![indexPath.row] as NSManagedObject
        if company.valueForKey("targeted") != nil{
            if company.valueForKey("targeted")! as Bool == true{
                cell.textLabel?.text = company.valueForKey("name") as? String
                cell.detailTextLabel?.text = company.valueForKey("workType") as? String
                cell.imageView?.image = UIImage(named: "checked_checkbox-26.png")
            }
            else{ //company is not targeted
                cell.textLabel?.text = company.valueForKey("name") as? String
                cell.detailTextLabel?.text = company.valueForKey("workType") as? String
                cell.imageView?.image = UIImage(named: "unchecked_checkbox-26.png")
            }
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
            
            
        else if segue.identifier == "majorRelevantDetailSegue"{
            if let myIndexPath = tableView.indexPathForCell(sender as UITableViewCell){
                let selectedCompany: NSManagedObject = relevantToAMajor[myIndexPath.row] as NSManagedObject
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

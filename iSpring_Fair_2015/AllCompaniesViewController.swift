//
//  CompaniesViewController.swift
//  iTech Fair 2015
//
//  Created by Samer Salib on 2/15/15.
//  Copyright (c) 2015 Samer Salib. All rights reserved.
//

import UIKit
import CoreData

class AllCompaniesViewController: CareerFairTableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    var allCompaniesArray = companiesInfo
    var allCompanies: Array<AnyObject>!
    var sections: Array<[AnyObject]> = []
    let currentCollation = UILocalizedIndexedCollation.currentCollation() as UILocalizedIndexedCollation
    var filteredCompanies: [AnyObject]?
    var recentSearch: String = "" //used to display a section header of search results
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCompaniesToDB()
        displayCompaniesFromDB()
        // example: read file.txt
        //................
        
        
        //var tableSections: Array<Section> = []
            //create an empty sections array
        sections = Array<[AnyObject]>(count: currentCollation.sectionTitles.count, repeatedValue: [])
        populateSections(&self.sections )

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
    }
    
    func populateSections(inout sections: Array<[AnyObject]>){
        
            let selector: Selector = "name"
            
            for company in allCompanies!{
                var secIndexOfCompany = currentCollation.sectionForObject(company as NSManagedObject, collationStringSelector: selector)
                appendACompanyToAnArray(&(sections[secIndexOfCompany]), company: company as NSManagedObject)
            }
        for index in 0..<sections.count{
            let sortedSection = currentCollation.sortedArrayFromArray(sections[index], collationStringSelector: selector) as [NSManagedObject]
            sections[index] = sortedSection
        }
            /*let sortedCompanies = currentCollation.sortedArrayFromArray(!, collationStringSelector: selector) as [Company]
            for company in sortedCompanies {
                let sectionNumber = currentCollation.sectionForObject(allCompanies!, collationStringSelector: selector)
                sections[sectionNumber].append(company)
            }*/
    }
    
    //MARK: the search bar functions
    
    func filterContentForSearchText(searchText: String) {
        recentSearch = searchText
        // Filter the array using the filter method
        self.filteredCompanies = self.allCompanies!.filter({( company: AnyObject) -> Bool in
            //let categoryMatch = (scope == "All") || (company.category == scope)
            let stringMatch = ( (company as NSManagedObject).valueForKey("name") as String).lowercaseString.hasPrefix(searchText.lowercaseString)
            //return categoryMatch && (stringMatch != nil)
            return stringMatch
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    //use this function if you need search bar scopes
    /*func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        return true
    }*/
    
    //old unused func!
    /*override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        if showingSearch {
            return self.collation.sectionForSectionIndexTitleAtIndex(index)
        }
        else {
            return super.tableView(tableView, sectionForSectionIndexTitle:title atIndex:Index)
        }
    }*/
    
    //MARK: documentation collation class functions
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return "Results of:  \(recentSearch)"
        }
        else{
            let currentCollation = UILocalizedIndexedCollation.currentCollation() as UILocalizedIndexedCollation
            let sectionTitles = currentCollation.sectionTitles as NSArray
            return sectionTitles.objectAtIndex(section) as String
        }
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) ->  [AnyObject]!{
        let currentCollation = UILocalizedIndexedCollation.currentCollation() as UILocalizedIndexedCollation
        return currentCollation.sectionIndexTitles as NSArray
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        let currentCollation = UILocalizedIndexedCollation.currentCollation() as UILocalizedIndexedCollation
        return currentCollation.sectionForSectionIndexTitleAtIndex(index)
    }
    
    
    
    
    //MARK: built in functions

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return 1
        }
        else{// Return the number of sections.
            return sections.count
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.searchDisplayController!.searchResultsTableView {
            if let filtered = self.filteredCompanies{
            return self.filteredCompanies!.count
            }else {return 0}
        } else {
            return sections[section].count
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        /*if let storyboardCell = tableView.dequeueReusableCellWithIdentifier("companyCell", forIndexPath: indexPath) as? UITableViewCell{
            cell = storyboardCell
        }
        else{*///create a dynamic cell!
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "companyCell")
        //}
        
        // Check to see whether the normal table or search results table is being displayed, and set the Company object from the appropriate array
        var company: AnyObject
        if tableView == self.searchDisplayController!.searchResultsTableView {
            company = filteredCompanies![indexPath.row] as NSManagedObject
        } else {
            company = sections[indexPath.section][indexPath.row] as NSManagedObject
        }
        

        // Configure the cell...
        cell!.textLabel?.text = company.valueForKey("name") as? String
        cell!.detailTextLabel?.text = company.valueForKey("workType") as? String
        return cell!
    }
    
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return false
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    func addCompaniesToDB(){
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        // ref to NS management context
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        let entity = NSEntityDescription.entityForName("Company", inManagedObjectContext: context)

        for company in allCompaniesArray{
            var newCompany = CompanyData(entity: entity!, insertIntoManagedObjectContext: context)
            
            newCompany.name           = company.name!
            newCompany.number         = company.number!
            newCompany.location       = company.location!
            newCompany.detail         = company.detail!
            newCompany.majors         = company.majorsAsString()
            newCompany.desiredDegrees = company.desiredDegreesAsString()!
            newCompany.workType       = company.workTypeAsString()!
            newCompany.websiteName    = company.website!
        }
        context.save(nil)
    }
    
    func displayCompaniesFromDB(){
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        //retrive NSMContext
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        // instance of our NS fetch request
        let fetchRequest = NSFetchRequest(entityName: "Company")
        
        //populate the array from the database
        allCompanies = context.executeFetchRequest(fetchRequest, error: nil)
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
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //refrence the selcted company
        let selectedCompanyDetail: NSManagedObject = sections[self.tableView.indexPathForSelectedRow()!.section][tableView.indexPathForSelectedRow()!.row] as NSManagedObject
        performSegueWithIdentifier("myDetailSegue", sender: tableView.cellForRowAtIndexPath(indexPath))
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("you got segue")
        if segue.identifier == "myDetailSegue"{
            var message = tableView.indexPathForSelectedRow()!.row
            println("hey I'm here: \(message)")
                //refrence the selcted company
            let selectedCompanyDetail: NSManagedObject = sections[self.tableView.indexPathForSelectedRow()!.section][tableView.indexPathForSelectedRow()!.row] as NSManagedObject
            
                //refrence the destination view
            let companyDetailViewController: CompanyViewController = segue.destinationViewController as CompanyViewController
            
                //prepopulate the textView
            companyDetailViewController.passedCompanyDetail = selectedCompanyDetail.valueForKey("detail") as String
        }
    }
    

}

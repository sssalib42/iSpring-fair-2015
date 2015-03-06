//
//  CareerFairTableViewController.swift
//  iTech Fair 2015
//
//  Created by Samer Salib on 2/16/15.
//  Copyright (c) 2015 Samer Salib. All rights reserved.
//

import UIKit
import CoreData

class CareerFairTableViewController: UITableViewController {
    var tableCompanies: [Company] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        cloneCompaniesInfoArray(&tableCompanies)
        
        //cloneCompaniesInfoArray(&tableCompanies)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - CareerFair views helper functions
    
    //********************************************************
    // func cloneCompaniesInfoArray creates a local mutable array
    //********************************************************
    func cloneCompaniesInfoArray(inout companiesArrayVar: Array<Company>){
        var counterToAvoidAppendWhichNeverAddsAnItem = 0
        for companyVar in companiesInfo{
            //appendACompanyToAnArray(&companiesArrayVar, company: companyVar)
            counterToAvoidAppendWhichNeverAddsAnItem++
        }
    }
    
    
    //*********************************************************
    // func: Search through the companiesInfo array
    //      and find the companies recruiting specific majors
    // helper method: findOneMajorSectionEntries
    //*********************************************************
    func findAllMajorsSectionsEntries (companiesList: [Company], inout allSections: [(str: String,cmp: [Company])], listOfMajors: [String]){
        //loop through each major and find the companies associated with it
        for majorIndex in 0..<listOfMajors.count{
            //use a helper method to find the list (array) of a major's relevent companies (which is one table section)
            // first create an empty array for a section
            var tmpTupleCompaniesArray: [Company]=[]
            
            //find all companies related to this one major
            
            //creat the section of the main major's-companies
            for aCompany in companiesList{
                let companyMajors = aCompany.listOf(aCompany.majors!)
                for  aMajor in companyMajors{
                    if aMajor == listOfMajors[majorIndex]{
                        //appendACompanyToAnArray(&tmpTupleCompaniesArray, company: aCompany)
                    }
                }
            }

            //to the passed in array, add the list of all the table sections/majors/companies' lists
            
            var companiesListOfOneSection: (str: String,cmp: [Company]) = (listOfMajors[majorIndex], tmpTupleCompaniesArray )
            allSections.insert(companiesListOfOneSection, atIndex: majorIndex)
        }
    }
    
    //*********************************************************
    // func: Appends a company to a mutable array by reference
    //*********************************************************
    func appendACompanyToAnArray (inout companiesList: [AnyObject], company: AnyObject){
        companiesList.append(company as NSManagedObject)
    }
 
    //*********************************************************
    // func: Appends a company to a mutable array by reference
    //*********************************************************
    func appendACompanyToAnArray (inout companiesList: [Company], company: Company){
        companiesList.append(company)
    }
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

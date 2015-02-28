//
//  searchRelevantViewController.swift
//  iTech Fair 2015
//
//  Created by Samer Salib on 2/18/15.
//  Copyright (c) 2015 Samer Salib. All rights reserved.
//
/*  Source (tutorial): http://makeapppie.com/tag/uipickerview-in-swift/ */
//

import UIKit

class searchRelevantViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var selectedMajor:String = ""
        //set in the parent view segue call
    var myParentViewController: RelevantCompaniesTableViewController!
    
    var allMajorsList = ["EE", "CSC", "CE", "ECE", "Comp. Eng.", "ET", "Finance", "Mktg.", "ME", "Acct.", "Ag.", "Agribusiness Mgmt.", "Bus.", "Math", "Bio-Mol. Eng.", "Chem. Eng.", "Civil Eng.", "Chem. E.", "Business"]
    
    @IBOutlet weak var majorsPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        
        /*/empty old list
        println("relevant list: \(myParentViewController.relevantToAMajor)")
        myParentViewController.relevantToAMajor = nil
        println("selected major= \(selectedMajor)")
        println("relevant list: \(myParentViewController.relevantToAMajor)")
        for company in myParentViewController.allCompanies{
            println("companies name= \(company.name)")
            println("companies majors= \(company.majors)")
            if contains(company.majors!, selectedMajor){
                appendACompanyToAnArray(&myParentViewController.relevantToAMajor!, company: company)
                println("company: \(company.name) was appended!")
                println("relevant list: \(myParentViewController.relevantToAMajor)")            }
        }
        self.myParentViewController = nil*/
        
        myParentViewController.setSelectedMajor(self.selectedMajor)        //myParentViewController.updateRelevantCompaniesMajor(selectedMajor)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allMajorsList.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return allMajorsList[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMajor = allMajorsList[row]
        
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        var relevantCompsViewController: RelevantCompaniesTableViewController = segue.destinationViewController as RelevantCompaniesTableViewController
        
        // Pass the selected object to the new view controller.
        relevantCompsViewController.updateRelevantCompaniesMajor(selectedMajor!)
        
    }*/
    
    //*********************************************************
    // func: Appends a company to a mutable array by reference
    //*********************************************************
    func appendACompanyToAnArray (inout companiesList: [Company], company: Company){
        companiesList.append(company)
    }
}

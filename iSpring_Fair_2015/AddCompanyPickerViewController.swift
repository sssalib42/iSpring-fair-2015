//
//  AddCompanyPickerViewController.swift
//  iTech Fair 2015
//
//  Created by Samer Salib on 2/22/15.
//  Copyright (c) 2015 Samer Salib. All rights reserved.
//

import UIKit
import CoreData

class AddCompanyPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var allCompanies = Array<AnyObject>()
    var pickerSelectedCompanyRow: Int?
    @IBOutlet var pickerResult: AddCompanyPickerView!
    
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
        allCompanies.sort( {$0.name < $1.name} )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        if (pickerSelectedCompanyRow != nil) {
            if let company: NSManagedObject = allCompanies[pickerSelectedCompanyRow!] as? NSManagedObject
            {
                if let targeted: Bool = company.valueForKey("targeted") as? Bool{
                    company.setValue(true, forKey: "targeted")
                }
            }
            
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
        //println("selected : \(allCompanies[pickerSelectedCompanyRow!])")
        
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    
    
    //MARK: Picker- Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        println(allCompanies.count)
        return allCompanies.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return allCompanies[row].name
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //myCompanies.append(allCompanies[row])
        pickerSelectedCompanyRow = row
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

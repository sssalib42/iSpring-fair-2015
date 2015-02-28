//
//  InterviewDatePickerViewController.swift
//  iTech Fair 2015
//
//  Created by Samer Salib on 2/22/15.
//  Copyright (c) 2015 Samer Salib. All rights reserved.
//

import UIKit
import CoreData

class InterviewDatePickerViewController: ResponsiveTextFieldViewController, UIPickerViewDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet var datePickerOutlet  : UIDatePicker!
    @IBOutlet var companyNameOutlet: UITextField!
    @IBOutlet var locationOutlet: UITextField!
    
    var company  : String = ""
    var location : String = ""
    var date     : NSDate!
    
    var existingInterview: NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyNameOutlet.delegate = self
        locationOutlet.delegate = self
        
        if (existingInterview != nil){
            datePickerOutlet.date  = date
            companyNameOutlet.text = company
            locationOutlet.text    = location
        }
    }


    //03 textfield func for the return key
func textFieldShouldReturn(textField: UITextField) -> Bool {
    companyNameOutlet.resignFirstResponder()
    locationOutlet.resignFirstResponder()
    return true;
}
    
    //textfield func for the touch on BG
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        companyNameOutlet.resignFirstResponder()
        locationOutlet.resignFirstResponder()
    self.view.endEditing(true)
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func saveButton(sender: AnyObject) {
            //refrence to app delegate
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
            // ref to NS management context
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        let entity = NSEntityDescription.entityForName("Interview", inManagedObjectContext: context)
        
        
        if (existingInterview != nil){
            existingInterview.setValue(datePickerOutlet.date , forKey: "date")
            existingInterview.setValue(locationOutlet.text   , forKey: "location")
            existingInterview.setValue(companyNameOutlet.text, forKey: "company")
        }else{
                // new instance of data model
            var newInterview = Interview(entity: entity!, insertIntoManagedObjectContext: context)
                //map our properties
            newInterview.date        = datePickerOutlet.date
            newInterview.location    = locationOutlet.text
            newInterview.company     = companyNameOutlet.text
            newInterview.notes       = "Notes: \r"
        }
        
            //save our context
        context.save(nil)
        
            //Navigate back
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }

    @IBAction func canelButton(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    //MARK: Picker- Delegates and data sources
    /*/MARK: Data Sources (not needed here)
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        println(allCompanies.count)
        return allCompanies.count
    }*/
    
    //MARK: Delegates
    /*func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return allCompanies[row].name
    }*/
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //myCompanies.append(allCompanies[row])
        //pickerSelectedCompanyRow = row
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

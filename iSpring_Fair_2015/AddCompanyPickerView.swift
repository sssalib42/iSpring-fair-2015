//
//  AddCompanyPickerView.swift
//  iTech Fair 2015
//
//  Created by Samer Salib on 2/22/15.
//  Copyright (c) 2015 Samer Salib. All rights reserved.
//

import UIKit

class AddCompanyPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate  {
    var allCompanies = []
    var pickerSelectedCompanyRow: Int?
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    //MARK: Picker- Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
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

}

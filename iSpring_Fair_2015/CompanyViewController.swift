//
//  CompanyViewController.swift
//  iTech Fair 2015
//
//  Created by Samer Salib on 2/15/15.
//  Copyright (c) 2015 Samer Salib. All rights reserved.
//

import UIKit

class CompanyViewController: UIViewController {
    
    
    @IBOutlet var companyDetailTextView: UITextView!
    
    
    
    var passedCompanyDetail: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if passedCompanyDetail != nil{
            companyDetailTextView.text = passedCompanyDetail
        }else{
            println("error in the passed company detail")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

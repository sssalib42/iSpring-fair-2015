//
//  CompanyData.swift
//  iTech Fair 2015
//
//  Created by Samer Salib on 2/22/15.
//  Copyright (c) 2015 Samer Salib. All rights reserved.
//

import UIKit
import CoreData

@objc(CompanyData)
class CompanyData: NSManagedObject {
    @NSManaged var name           :  String
    @NSManaged var number         :  String
    @NSManaged var location       :  String
    @NSManaged var detail         :  String
    @NSManaged var majors         :  String
    @NSManaged var desiredDegrees :  String
    @NSManaged var workType       :  String
    @NSManaged var website        :  String
    @NSManaged var targeted       :  Bool
    @NSManaged var visited        :  Bool
    
        //interview properties
    //@NSManaged var interviewDate  :  NSDate?
    //@NSManaged var interviewLoc   :  String?
    //@NSManaged var interviewNotes   :  String?
    
    //var websiteUrl     :  NSURL?
    
}

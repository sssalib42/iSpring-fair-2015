//
//  Interview.swift
//  iSpring_Fair_2015
//
//  Created by Samer Salib on 2/23/15.
//  Copyright (c) 2015 Samer Salib. All rights reserved.
//

import UIKit
import CoreData

@objc(Interview)
class Interview: NSManagedObject {
    
    @NSManaged var company   : String
    @NSManaged var location  : String
    @NSManaged var date      : NSDate
    @NSManaged var notes     : String
}

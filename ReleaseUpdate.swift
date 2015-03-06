//
//  ReleaseUpdates.swift
//  iSpring_Fair_2015
//
//  Created by Samer Salib on 3/3/15.
//  Copyright (c) 2015 Samer Salib. All rights reserved.
//

import UIKit
import CoreData

@objc(ReleaseUpdate)
class ReleaseUpdate: NSManagedObject {
    @NSManaged var version : String
    @NSManaged var date    : NSDate
    @NSManaged var detail  : String
    
}
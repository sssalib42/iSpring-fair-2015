//
//  Company.swift
//  iTech Fair 2015
//
//  Created by Samer Salib on 2/12/15.
//  Copyright (c) 2015 Samer Salib. All rights reserved.
//

import Foundation
import CoreData

class Company: NSObject {
    var name           :  String?
    var number         :  String?
    var location       :  String?
    var detail         :  String?
    var majors         :  String?
    var desiredDegrees :  String?
    var workType       :  String?
    var website        :  String?
    var targeted       :  Bool?
    var visited        :  Bool?
    var urlWebsite     :  NSURL?

    
    
    init (cmpName: String,cmpNumber: String, cmpLocation: String, cmpDetail: String, cmpMajors: String,cmpDesiredDegreees: String, cmpWorkType: String, cmpWebsite: String){
        
        super.init()
        
        name            = cmpName
        number          = cmpNumber
        location        = cmpLocation
        detail          = cmpDetail
        majors          = cmpMajors
        desiredDegrees  = cmpDesiredDegreees
        workType        = cmpWorkType
        website         = cmpWebsite
        targeted        = false
        visited         = false
        
        if website != nil{
            urlWebsite = NSURL(string: website!)
        }
        
    }
    
    
    init (companyObj: NSManagedObject ){
        super.init()
        
        name            = companyObj.valueForKey( "name"          ) as? String
        number          = companyObj.valueForKey( "number"        ) as? String
        location        = companyObj.valueForKey( "location"      ) as? String
        detail          = companyObj.valueForKey( "detail"        ) as? String
        majors          = companyObj.valueForKey( "majors"        ) as? String
        desiredDegrees  = companyObj.valueForKey( "desiredDegrees") as? String
        workType        = companyObj.valueForKey( "workType"      ) as? String
        website         = companyObj.valueForKey( "website"       ) as? String
        targeted        = companyObj.valueForKey( "targeted"      ) as? Bool
        visited         = companyObj.valueForKey( "visited"       ) as? Bool
        if website != nil{
            urlWebsite = NSURL(string: website!)
        }
    }

    func informationString() ->String{
        var infoStr: String = ""
        
        infoStr += name! + "\r\r"
        //will text hyperlink to the website (if one is provided)
        
        if let desiredMajors = majors{
            infoStr += "Desired Majors:" + "\r"
            infoStr += desiredMajors + "\r"
        }
        if let degrees = desiredDegrees{
            infoStr += "Desired Degrees:" + "\r"
            infoStr += degrees + "\r"
        }
        if let type = workType{
            infoStr += "Work Type:" + "\r"
            infoStr += type + "\r"
        }
        infoStr += detail!
        
        return infoStr
    }
    
    
    func listOf(items: String)->[String]{
        let list = items.componentsSeparatedByString( ", " )
        if list[0].substringToIndex(list[0].startIndex) == " "{
            list[0].substringFromIndex(list[0].startIndex)
        }
        return list
    }
    
    
    /*OLD
    
    func workTypeAsString()->String?{
        return toSeperatedByCommas(workType!)
    }
    
    func desiredDegreesAsString()->String?{
        return toSeperatedByCommas(desiredDegrees!)
    }
    func majorsAsString()->String{
        return toSeperatedByCommas(majors!)
    }
    func toSeperatedByCommas ( items: [String]) ->String{
        var resultStr = ""
        for item in items{
            resultStr += ,  + item
        }
        resultStr.removeAtIndex(resultStr.startIndex)
        return resultStr
    }*/
    

    
    /*func addInterview (interview: Interview){
        self.interview = interview
    }
    func addInterview (cn: String, loc: String, date: NSDate){
        self.interview = Interview(cmpName: cn, loc: loc, date: date)
    }*/
}
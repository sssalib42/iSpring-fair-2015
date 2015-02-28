//
//  Company.swift
//  iTech Fair 2015
//
//  Created by Samer Salib on 2/12/15.
//  Copyright (c) 2015 Samer Salib. All rights reserved.
//

import Foundation

extension NSDate
{
    convenience
    init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = dateStringFormatter.dateFromString(dateString)
        self.init(timeInterval:0, sinceDate:d!)
    }
}
//NSDate(dateString:"2014-06-06")

    /*class Interview{
        var companyName: String?
        var location: String?
        var date: NSDate
        init (cmpName: String, loc: String, date: NSDate){
            companyName = cmpName
            location = loc
            self.date = date
        }
    }*/

class Company: NSObject {
    var name           :  String?
    var number         :  String?
    var location       :  String?
    var detail         :  String?
    var majors         : [String]?
    var desiredDegrees : [String]?
    var workType       : [String]?
    var website        :  String?
    var urlWebsite     :  NSURL?
    
    //var interview: Interview?
    
    
    init (cmpName: String,cmpNumber: String, cmpLocation: String, cmpDetail: String, cmpMajors: [String],cmpDesiredDegreees: [String], cmpWorkType: [String], cmpWebsite: String){
        
        name            = cmpName
        number          = cmpNumber
        location        = cmpLocation
        detail          = cmpDetail
        majors          = cmpMajors
        desiredDegrees  = cmpDesiredDegreees
        workType        = cmpWorkType
        website         = cmpWebsite
        
        if website != nil{
            urlWebsite = NSURL(string: website!)
        }
        
        super.init()
    }
    
    
    override init (){
        super.init()
    }

    func informationString() ->String{
        var infoStr: String = ""
        
        infoStr += name! + "\r\r"
        //will text hyperlink to the website (if one is provided)
        
        infoStr += "Desired Majors:" + "\r"
        infoStr += toSeperatedByCommas(majors!) + "\r"
        
        if let degrees:[String] = desiredDegrees{
        infoStr += "Desired Degrees:" + "\r"
        infoStr += desiredDegreesAsString()! + "\r"
        }
        
        infoStr += "Work Type:" + "\r"
        infoStr += workTypeAsString()! + "\r"
        
        infoStr += detail!
        
        return infoStr
    }
    
    
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
            resultStr += ", " + item
        }
        resultStr.removeAtIndex(resultStr.startIndex)
        return resultStr
    }
    

    
    /*func addInterview (interview: Interview){
        self.interview = interview
    }
    func addInterview (cn: String, loc: String, date: NSDate){
        self.interview = Interview(cmpName: cn, loc: loc, date: date)
    }*/
}
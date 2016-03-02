//
//  Task.swift
//  ToDoList
//
//  Created by Lucas de Matos Figueredo on 3/1/16.
//  Copyright © 2016 Lucas de Matos Figueredo. All rights reserved.
//

import Foundation

class Task : NSObject, NSCoding {
    
    var name: String = ""
    var isDone: Bool = false
    var date: NSDate?
    
    required init(coder aCoder: NSCoder) {
        name = aCoder.decodeObjectForKey("name") as! String
        isDone = aCoder.decodeObjectForKey("isDone") as! Bool
        date = aCoder.decodeObjectForKey("date") as? NSDate
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(isDone, forKey: "isDone")
        aCoder.encodeObject(date, forKey: "date")
    }
    
    //var dateOfConclusion: NSDate
    init(newName:String) {
        name = newName
        isDone = false
    }
    
    func toggleTask() {
        if(isDone) {
            isDone = false
            date = nil
        }
        else {
            self.date = NSDate()
            isDone = true
        }
    }
    
    func shouldDelete() -> Bool {
        print(date?.timeIntervalSinceNow)
        return date != nil && date?.timeIntervalSinceNow < -86400
    }
    
    /*deinit {
    
    }*/
    
}

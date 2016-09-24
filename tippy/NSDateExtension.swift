//
//  NSDateExtension.swift
//  tippy
//
//  Created by SangHoon Lee on 9/19/16.
//  http://stackoverflow.com/questions/26198526/nsdate-comparison-using-swift
//
//  Copyright © 2016 SangHoon Lee. All rights reserved.
//

import Foundation

extension NSDate {
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        var isGreater = false
        
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending {
            isGreater = true
        }

        return isGreater
    }
    
    func isLessThanDate(dateToCompare: NSDate) -> Bool {
        var isLess = false
        
        if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending {
            isLess = true
        }
        
        return isLess
    }
    
    func equalToDate(dateToCompare: NSDate) -> Bool {
        var isEqualTo = false
        
        if self.compare(dateToCompare) == NSComparisonResult.OrderedSame {
            isEqualTo = true
        }
        
        return isEqualTo
    }
    
    func addDays(daysToAdd: Int) -> NSDate {
        return self.dateByAddingTimeInterval(NSTimeInterval(Double(daysToAdd) * 60 * 60 * 24))
    }
    
    func addHours(hoursToAdd: Int) -> NSDate {
        return self.dateByAddingTimeInterval(NSTimeInterval(Double(hoursToAdd) * 60 * 60))
    }
    
    func addMinutes(minutesToAdd: Int) -> NSDate {
        return self.dateByAddingTimeInterval(NSTimeInterval(Double(minutesToAdd) * 60))
    }
    
    func addSeconds(secondsToAdd: Int) -> NSDate {
        return self.dateByAddingTimeInterval(NSTimeInterval(Double(secondsToAdd)))
    }
}
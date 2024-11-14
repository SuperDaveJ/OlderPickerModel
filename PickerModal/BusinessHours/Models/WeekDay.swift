//
//  DayOfTheWeek.swift
//  PickerModal
//
// Created by David Johnson on 11/30/17.
//  Copyright © 2017 Dave J. All rights reserved.
//

import Foundation

struct WeekDay {
    var name = ""
    var startDate = ""
    var endDate = ""
    var index = 0
    
    func abbreviation() -> String {
        let index = self.name.index(self.name.startIndex, offsetBy: 3)
        return self.name.substring(to: index)
    }
}

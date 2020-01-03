//
//  Weekday.swift
//  sberservice
//
//  Created by User on 10/9/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

enum Weekday: Int, CaseIterable, Titlable {
    case monday = 0
    case tuesday = 1
    case wednesday = 2
    case thursday = 3
    case friday = 4
    case saturday = 5
    case sunday = 6
    
    var title: String {
        switch self {
        case .monday:
            return "monday"
            
        case .tuesday:
            return "tuesday"
            
        case .wednesday:
            return "wednesday"
            
        case .thursday:
            return "thursday"
            
        case .friday:
            return "friday"
            
        case .saturday:
            return "saturday"
            
        case .sunday:
            return "sunday"
        }
    }
}


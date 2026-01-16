//
//  SlackingSession.swift
//  moleme
//
//  Created by qin on 2026/1/16.
//

import SwiftData
import Foundation

@Model
class SlackingSession {
    var startTime: Date
    var endTime: Date?
    var earnings: Double
    
    init(startTime: Date, earnings: Double = 0.0) {
        self.startTime = startTime
        self.earnings = earnings
    }
}

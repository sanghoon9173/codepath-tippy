//
//  Tip.swift
//  tippy
//
//  Created by SangHoon Lee on 9/16/16.
//  Copyright © 2016 SangHoon Lee. All rights reserved.
//

import Foundation

struct Tip {
    static let DEFAULT_TIP = TIP_OPTIONS[0]
    static let TIP_OPTIONS = [
        Tip(label: "18%", percentage: 0.18),
        Tip(label: "20%", percentage: 0.20),
        Tip(label: "25%", percentage: 0.25)
    ]
    
    let label: String
    let percentage: Double
    
    init(label: String, percentage: Double) {
        self.label = label
        self.percentage = percentage
    }
}
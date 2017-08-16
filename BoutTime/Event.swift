//
//  Event.swift
//  BoutTime
//
//  Created by James Mulholland on 16/08/2017.
//  Copyright © 2017 JamesMulholland. All rights reserved.
//

import Foundation

protocol Event {
    var description: String { get }
    var date: Date { get }
    var url: String { get }
}

struct CompanyFounding: Event {
    var description: String
    let date: Date
    let url: String
    
    init(company: String, date: Date, url: String) {
        self.description = "\(company) is founded"
        self.date = date
        self.url = url
    }
}

extension CompanyFounding: Comparable {
    static func == (lhs: CompanyFounding, rhs: CompanyFounding) -> Bool {
        return lhs.date == rhs.date
    }
    
    static func < (lhs: CompanyFounding, rhs: CompanyFounding) -> Bool {
        return lhs.date < rhs.date
    }
}

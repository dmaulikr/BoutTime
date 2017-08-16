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
    var url: URL { get }
}

struct CompanyFounding: Event {
    var description: String
    let date: Date
    let url: URL
    
    init(description: String, date: Date, url: URL) {
        self.description = description
        self.date = date
        self.url = url
    }
    
    init(company: String, date: Date, url: URL) {
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

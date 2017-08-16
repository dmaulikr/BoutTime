//
//  Round.swift
//  BoutTime
//
//  Created by James Mulholland on 16/08/2017.
//  Copyright © 2017 JamesMulholland. All rights reserved.
//

import Foundation

class Round {
    // ordered list of (4) events to display
    var events: [Event]
    
    init(events: [Event]) {
        self.events = events
    }
    
    func generateEvents() {
        
    }
    
    func checkAnswers() -> Bool {
        return true
    }
}

enum RoundError: Error {
    case invalidResource
    case conversionFailure
}

class PListConverter {
    static func array(fromFile name: String, ofType type: String) throws -> [[String: AnyObject]] {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw RoundError.invalidResource
        }
        guard let array = NSArray(contentsOf: URL(string: path)!) as? [[String: AnyObject]] else {
            throw RoundError.conversionFailure
        }
        
        return array
    }
}

class EventListUnarchiver {
    static func eventList(fromArray array: [[String: AnyObject]]) -> [Event] {
        var eventList: [Event] = []
        
        // item corresponds to an event
        // keys and values corresponds to event properties
        for eventDictionary in array {
            if let description = eventDictionary["description"] as? String, let date = eventDictionary["date"] as? Date, let url = eventDictionary["url"] as? URL {
                let event = CompanyFounding(company: description, date: date, url: url)
                eventList.append(event)
            }
        }
        return eventList
    }
}
























































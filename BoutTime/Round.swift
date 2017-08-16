//
//  Round.swift
//  BoutTime
//
//  Created by James Mulholland on 16/08/2017.
//  Copyright © 2017 JamesMulholland. All rights reserved.
//

import Foundation
import GameKit

class Round {
    // ordered list of (4) events to display
    var events: [Event]
    
    init(events: [Event]) {
        self.events = events
    }
    
    convenience init() {
        // Get events from plist file
        var allEvents: [Event] = []
        do {
            let array = try PListConverter.array(fromFile: "EventList", ofType: "plist")
            allEvents = try EventListUnarchiver.eventList(fromArray: array)
        } catch let error {
            fatalError("\(error)")
        }
        
        // shuffle events array
        allEvents = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allEvents) as! [Event]
        
        // select first 4 events in shuffled array
        var shortEvents: [Event] = []
        for i in 0...3 {
            shortEvents.append(allEvents[i])
        }

        self.init(events: shortEvents)
    }
    
    func checkAnswers() -> Bool {
        // generate ordered list
        let sortedEvents = events.sorted(by: { $0.date < $1.date })
        
        // Goes through consecutive pairs in the sorted and user-attempted lists of events
        // Compares the dates on each to check that the attempted order is correct
        for i in 0...3 {
            if sortedEvents[i].date != events[i].date {
                return false
            }
        }
        return true
    }
}

enum RoundError: Error {
    case invalidResource
    case conversionFailure
    case eventListCreationFail
}

class PListConverter {
    static func array(fromFile name: String, ofType type: String) throws -> [[String: Any]] {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw RoundError.invalidResource
        }
        
        guard let array = NSArray(contentsOfFile: path) as? [[String: AnyObject]] else {
            throw RoundError.conversionFailure
        }
        
        return array
    }
}

class EventListUnarchiver {
    static func eventList(fromArray array: [[String: Any]]) throws -> [Event] {
        // Takes an array and converts to [Event] format
        
        var eventList: [Event] = []
        
        for eventDictionary in array {
            if let description = eventDictionary["description"] as? String, let date = eventDictionary["date"] as? Date, let url = eventDictionary["url"] as? String {
                let event = CompanyFounding(company: description, date: date, url: url)
                eventList.append(event)
            } else {
                throw RoundError.eventListCreationFail
            }
        }
        return eventList
    }
}
























































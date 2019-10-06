//
//  Email.swift
//  Quarantine
//
//  Created by Volodymyr on 10/6/19.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation

enum EmailPeriod {
    case today, yesterday, lastWeek, lastMonth
    
    // MARK: - Public properties
    var string: String {
        switch self {
        case .today: return "Tuday"
        case .yesterday: return "Yesterday"
        case .lastWeek: return "Last Week"
        case .lastMonth: return "Last Month"
        }
    }
    
    // MARK: - Public static methods
    static func create(for date: Date) -> EmailPeriod {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return .today
        } else if calendar.isDateInYesterday(date) {
            return .yesterday
        } else {
            let differenceDays = Date().days(sinceDate: date).default
            if differenceDays > 1 && differenceDays < 7 {
                return .lastWeek
            }
            return .lastMonth
        }
    }
}

enum TypeEmail: String, Decodable {
    case inbox, outbox
    
    var string: String {
        switch self {
        case .inbox: return "From"
        case .outbox: return "To"
        }
    }
}

protocol EmailProtocol {
    var type: TypeEmail { get }
    var avatarUrl: String? { get }
    var authorName: String { get }
    var body: String? { get }
    var timestamp: Double { get }
    var dateString: String { get }
    var period: EmailPeriod { get }
}

struct Email: EmailProtocol, Decodable {
    let type: TypeEmail
    let avatarUrl: String?
    let authorName: String
    let body: String?
    let timestamp: Double
}

extension Email {
    
    // MARK: - Public properties
    var date: Date {
        return Date(timeIntervalSince1970: timestamp)
    }
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self.dateFormat()
        
        return dateFormatter.string(from: date)
    }
    
    var period: EmailPeriod {
        return EmailPeriod.create(for: date)
    }
    
    
    // MARK: - Private methods
    private func dateFormat() -> String {
        if [EmailPeriod.today, .yesterday].contains(self.period)  {
            return "HH:mm a"
        } else if self.period == .lastWeek {
            return "E"
        } else {
            return "MMM dd"
        }
    }
}

extension Email: Equatable {
    static func ==(lhs: Email, rhs: Email) -> Bool {
        return lhs.type == rhs.type
            && lhs.authorName == rhs.authorName
            && lhs.timestamp == rhs.timestamp
    }
}

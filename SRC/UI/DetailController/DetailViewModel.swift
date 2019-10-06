//
//  DetailViewModel.swift
//  Quarantine
//
//  Created by Volodymyr on 10/6/19.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation

fileprivate var siteUrls = [
    "https://designcode.io/",
    "https://www.appcoda.com/",
    "https://cocoa.tumblr.com/post/173296518813/staff-its-the-great-tumblr-bug-hunt-ios",
    "https://www.objc.io/",
    "http://petersteinberger.com/",
    "https://iosdevtips.co/"
]

class DetailViewModel: ViewModel {
    
    // MARK: - Properties
    var title: String? = "Detail"
    var email: Email?
    
    
    // MARK: - Initializations
    init(email: Email?) {
        self.email = email
    }

    
    // MARK: - Public methods
    func rundomUrl() -> URL {
        return URL(string: siteUrls.randomElement().default) ?? URL(fileURLWithPath: "")
    }
    
    func updateEmail(_ email: Email?) {
        self.email = email
    }
}

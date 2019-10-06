//
//  MainViewModel.swift
//  Quarantine
//
//  Created by Volodymyr on 10/6/19.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation
import UIKit

protocol EmailSectionProtocol {
    var type: EmailPeriod { get }
    var emails: [EmailProtocol] { get }
}

class EmailSection: EmailSectionProtocol {
    var type: EmailPeriod
    var emails: [EmailProtocol] = []
    
    init(type: EmailPeriod, emails: [EmailProtocol] ) {
        self.type = type
        self.emails.append(contentsOf: emails)
    }
}

class MasterViewModel: ViewModel {
    
    // MARK: - Properties
    var title: String? = "Quarantine"
    private (set) var emails: [Email]
    var sections: [EmailSection] = []
    
    
    // MARK: -  Initializations
    init(emails: [Email]) {
        self.emails = emails
        self.fillSections()
    }
    
    
    // MARK: - Public methods
    func dataSource(with tableView: UITableView?) -> MasterDataSource {
        return MasterDataSource(tableView, viewModel: self)
    }
    
    func indexPath(for email: Email) -> IndexPath? {
        return sections
            .firstIndex { $0.type.string == email.period.string }
            .flatMap { section in
                if let row = sections[section].emails.firstIndex(where: { ($0 as? Email) == email }) {
                    return IndexPath(row: row, section: section)
                }
                return nil
        }
    }
    
    func removeEmail(_ email: Email) {
        guard let index = emails.firstIndex(where: { $0 == email })  else { return }
        emails.remove(at: index)
        fillSections()
    }
    
    func email(at: IndexPath) -> Email? {
        return self.sections[at.section].emails[at.row] as? Email
    }
    
    func nextEmail(for indexPath: IndexPath?) -> Email? {
        guard let indexPath = indexPath, sections.count > 0 else { return nil }
        
        let section = min(sections.count - 1, indexPath.section)
        let row = min(sections[section].emails.count, max(indexPath.row - 1, 0))
        
        return self.sections[section].emails[row] as? Email
    }
        
    
    // MARK: - Private methods
    private func sortSectionsByAscending() {
        sections.sort { (lht, rht) -> Bool in
            (lht.emails.first?.timestamp).default > (rht.emails.first?.timestamp).default
        }
    }
    
    private func fillSections() {
        self.sections.removeAll()
        self.emails
            .forEach { (email) in
                if let section = sections.filter({ $0.type == email.period }).first {
                    section.emails.append(email)
                } else {
                    let section = EmailSection(type: email.period, emails: [email])
                    sections.append(section)
                    //cast(section).map(addSection)
                }
        }
        self.sortSectionsByAscending()
    }
}

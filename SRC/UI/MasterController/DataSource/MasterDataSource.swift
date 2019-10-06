//
//  MasterDataSource.swift
//  Quarantine
//
//  Created by Volodymyr on 10/6/19.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation
import UIKit

extension MasterDataSource: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].emails.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let email = viewModel.email(at: indexPath)
        let typeCell = email?.type == .inbox ? EmailCellFrom.self : EmailCellTo.self
       
        let cell = tableView.reusableCell(typeCell, for: indexPath)
 
        return configure(cell, for: indexPath)
    }
}

class MasterDataSource: NSObject {
    
    // MARK: -  Properties
    fileprivate var viewModel: MasterViewModel
    
    
    // MARK: -  Initializations
    init(_ table: UITableView?, viewModel: MasterViewModel) {
        self.viewModel = viewModel
    }
    
    
    // MARK: -  Public methods
    func configure(_ cell: EmailCell, for indexPath: IndexPath) -> UITableViewCell {
        let email = self.viewModel.sections[indexPath.section].emails[indexPath.row]
        cell.fill(with: email)
        
        return cell
    }
    
    func configureHeader(_ cell: EmailHeaderView?, for section: Int) -> UIView? {
        let sectionName = viewModel.sections[section].type.string
        cell?.fill(with: sectionName)
        
        return cell
    }
    
}

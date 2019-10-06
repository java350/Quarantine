//
//  EmailCell.swift
//  Quarantine
//
//  Created by Volodymyr on 10/6/19.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class EmailCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        authorImageView.roundAllCorners(Float(authorImageView.frame.width / 2))
        authorImageView.addBorder(color: .green, thickness: 2)
    }
    
    
    // MARK: - Public methods
    func fill(with email: EmailProtocol) {
        self.authorImageView.setImage(with: email.avatarUrl)
        self.authorNameLabel.text = email.authorName
        self.bodyLabel.text = email.body
        self.dateLabel.text = email.dateString
    }
}

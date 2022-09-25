//
//  PostListTableViewCell.swift
//  3in1
//
//  Created by Medet Dönmez on 22.09.2022.
//

import UIKit

class PostListTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet private(set) weak var postTitleLabel: UILabel!
    @IBOutlet private(set) weak var postDescLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        
        containerView.backgroundColor = .lightGray.withAlphaComponent(0.3)
        containerView.layer.cornerRadius = 8
    }
}

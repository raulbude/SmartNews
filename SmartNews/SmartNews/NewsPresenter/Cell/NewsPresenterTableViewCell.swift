//
//  NewsPresenterTableViewCell.swift
//  SmartNews
//
//  Created by Raul Bude on 21/04/2018.
//  Copyright © 2018 Raul Bude. All rights reserved.
//

import UIKit

class NewsPresenterTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var vm: NewsPresenterCellVM? {
        didSet{
            titleLabel.text = vm?.title
            descriptionLabel.text = vm?.description
        }
    }
}

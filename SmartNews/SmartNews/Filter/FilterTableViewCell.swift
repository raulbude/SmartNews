//
//  FilterTableViewCell.swift
//  SmartNews
//
//  Created by Raul Bude on 19/06/2018.
//  Copyright © 2018 Raul Bude. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var switchFilter: UISwitch? 
    @IBOutlet weak var filterLabel: UILabel?
    @IBAction func switchChanged(_ sender: Any) {
        guard let text = filterLabel?.text,
            let switchValue = switchFilter?.isOn else {
                return
        }
        delegate?.changeSwitch(forCellWithText: text, withValue: switchValue)
    }
    var index: Int = 0
    weak var delegate: FilterTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

protocol FilterTableViewCellDelegate: class {
    func changeSwitch(forCellWithText text: String, withValue bool: Bool)
}

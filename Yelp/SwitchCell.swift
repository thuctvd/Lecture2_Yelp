//
//  SwitchCell.swift
//  Yelp
//
//  Created by Truong Vo Duy Thuc on 10/22/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    @objc func switchCell(switchCell: SwitchCell, didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var switchBtn: UISwitch!
    
    weak var delegate: SwitchCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func changeValue(_ sender: UISwitch) {
        delegate.switchCell(switchCell: self, didChangeValue: switchBtn.isOn)
    }
}

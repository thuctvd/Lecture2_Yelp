//
//  ComboBoxCell.swift
//  Yelp
//
//  Created by Truong Vo Duy Thuc on 10/22/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit

@objc protocol ComboBoxCellDelegate {
    @objc func ComboBoxCell(comboBoxCell: ComboBoxCell, didSelectValue value: UIImage)
}
class ComboBoxCell: UITableViewCell {

    weak var delegate: ComboBoxCellDelegate!
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if delegate != nil {
            delegate.ComboBoxCell(comboBoxCell: self, didSelectValue: imgView.image!)
        }
    }

}

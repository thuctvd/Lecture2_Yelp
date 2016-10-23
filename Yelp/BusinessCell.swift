//
//  BusinessCell.swift
//  Yelp
//
//  Created by Truong Vo Duy Thuc on 10/21/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit
import AFNetworking

class BusinessCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var reviewImg: UIImageView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
  
    var business: Business! {
      didSet {
        nameLabel.text = business.name
        if business.imageURL != nil{
            avatarImg.setImageWith(business.imageURL!)
        } else {
            avatarImg.image = nil
        }
        categoryLabel.text = business.categories
        addressLabel.text = business.address
        reviewLabel.text = "\(business.reviewCount!) Reviews"
        reviewImg.setImageWith(business.ratingImageURL!)
        distanceLabel.text = business.distance
      }
    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
      
        avatarImg.layer.cornerRadius = 6
        avatarImg.clipsToBounds = true
        avatarImg.layer.borderWidth = 1
        avatarImg.layer.borderColor = UIColor.darkGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

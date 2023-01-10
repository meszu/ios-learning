//
//  OffersTableViewCell.swift
//  TestTest
//
//  Created by Mészáros Kristóf on 2023. 01. 08..
//

import UIKit

class OfferCell: UITableViewCell {
    public static let reuseIdentifier = "OfferCell"
    
    @IBOutlet weak var offerTitle: UILabel!
    @IBOutlet weak var offerDescription: UILabel!
    @IBOutlet weak var redArrowImage: UIImageView!
    @IBOutlet weak var cardBackground: UIView!
    
    public func configureWith(_ offer: Offer) {
        offerTitle.text = offer.name
        offerTitle.font = UIFont.preferredFont(forTextStyle: .title3).withWeight(.semibold)
        
        offerDescription.text = offer.shortDescription
        redArrowImage.image = UIImage(named: "redArrow")
        
        cardBackground.layer.cornerRadius = 10
        cardBackground.layer.masksToBounds = false
        cardBackground.backgroundColor = UIColor(named: "cellCardBackground")
        cardBackground.layer.shadowColor = UIColor.black.cgColor
        cardBackground.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardBackground.layer.shadowOpacity = 0.25
        
        contentView.backgroundColor = UIColor(named: "cellBackground")
    }
}

//
//  PlacementTableViewCell.swift
//  display.io Sample App
//
//  Created by akrat on 7/23/18.
//  Copyright © 2018 akrat. All rights reserved.
//

import UIKit

class PlacementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var removeButtonContainerView: UIView!
    @IBOutlet weak var removeButtonContainerViewWidthConstraint: NSLayoutConstraint!
    
    var removePlacementDelegate: RemovePlacementDelegateProtocol?
    
    private let removeButtonWidth: CGFloat = 32
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup(placenentName: String?, placementType: String?, isRemovable: Bool) {
        titleLabel.text = placenentName ?? "N/A"
        typeLabel.text = placementType ?? "N/A"
        removeButtonContainerView.isHidden = !isRemovable
        removeButtonContainerViewWidthConstraint.constant = isRemovable ? removeButtonWidth : 0.0
        containerView.backgroundColor = isRemovable ? UIColor(hex: ColorScheme.colorDarkGrey) : UIColor(hex: ColorScheme.colorLightGrey)
    }
    
    @IBAction func removeButtonPressed(_ sender: UIButton) {
        removePlacementDelegate?.removePlacement(placementCell: self)
    }
}

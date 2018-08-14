//
//  NavigationView.swift
//  display.io Sample App
//
//  Created by akrat on 7/23/18.
//  Copyright © 2018 akrat. All rights reserved.
//

import UIKit

enum PageType {
    case main
    case show
    case add
    
    var pageName: String {
        return StringConstants.pageTitle
    }
    
}

class NavigationView: UIView {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var pageSubtitleLabel: UILabel!
    @IBOutlet weak var pageIconImageView: UIImageView!
    
    weak var viewControllerDelegate: ViewControllerDelegateProtocol?
    
    static let navigationHeight: CGFloat = 64
    
    class func instanceFromNib() -> NavigationView {
        return UINib(nibName: "NavigationView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! NavigationView
    }
    
    func setup(type: PageType, delegate: ViewControllerDelegateProtocol?) {
        pageTitleLabel.text = type.pageName
        pageTitleLabel.textColor = UIColor(hex: ColorScheme.colorPrimary)
        pageSubtitleLabel.text = "SDK v1.0.5"
        pageSubtitleLabel.textColor = UIColor(hex: ColorScheme.colorPrimary)
        backButton.isHidden = type == .main
        self.viewControllerDelegate = delegate
    }
    
    @IBAction func onBackPressed(_ sender: UIButton) {
        viewControllerDelegate?.onBackPressed()
    }
}

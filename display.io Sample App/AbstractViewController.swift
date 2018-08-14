//
//  AbstractViewController.swift
//  display.io Sample App
//
//  Created by akrat on 8/2/18.
//  Copyright © 2018 akrat. All rights reserved.
//

import UIKit
import DisplayIOFramework

class AbstractViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DioController.sharedInstance.initialize(withAppId: "6552")
        DioController.sharedInstance.eventDelegate = self
    }
    
    func showAd(placemetnId: String) {
        DioController.sharedInstance.showAd(presentingViewController: self, placementId: "3353")
    }
}

extension AbstractViewController: DioEventDelegate {
    
    func onInit(placementIds: [String]) {
        
    }
    
    func onInitError(message: String) {
        
    }
    
    func onNoAds(placementId: String) {
        
    }
    
    func onAdReady(placementId: String) {
        
    }
    
    func onAdShown(placementId: String) {
        
    }
    
    func onAdFailedToShow(placementId: String) {
        
    }
    
    func onAdClose(placementId: String) {
        
    }
    
    func onAdClick(placementId: String) {
        
    }
}

//
//  ShowPlacementViewController.swift
//  display.io Sample App
//
//  Created by akrat on 7/25/18.
//  Copyright © 2018 akrat. All rights reserved.
//

import UIKit
import DisplayIOFramework

class ShowPlacementViewController: AbstractViewController {
    
    @IBOutlet weak var navigationContainer: UIView!
    @IBOutlet weak var placementNameLabel: UILabel!
    @IBOutlet weak var placementTypeLabel: UILabel!
    @IBOutlet weak var buttonsContainer: UIView!
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var navigationHeightConstraint: NSLayoutConstraint!
    
    var appId: String?
    var placementId: String?
    
    var placementName: String?
    var placementType: String?
    
    private var adIsLoaded = false
    private var adIsLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationView()
        setupPlacementView()
        setupLoadingView()
    }
    
    override func onAdReady(placementId: String) {
        if placementId != self.placementId { return }
        
        adIsLoading = false
        adIsLoaded = true
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        AlertUtil.showAlert(parent: self, message: StringConstants.messageAdWasLoaded)
        showButton.backgroundColor = loadButton.backgroundColor
        showButton.isEnabled = true
    }
    
    override func onInitError(message: String) {
        adIsLoading = false
        adIsLoaded = false
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        AlertUtil.showAlert(parent: self, message: StringConstants.errAppInactive)
    }
    
    override func onNoAds(placementId: String) {
        if placementId != self.placementId { return }
        
        adIsLoading = false
        adIsLoaded = false
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        AlertUtil.showAlert(parent: self, message: StringConstants.errNoFill)
    }
    
    private func setupNavigationView() {
        navigationHeightConstraint.constant = UIApplication.shared.statusBarFrame.height + NavigationView.navigationHeight
        
        let navigationView = NavigationView.instanceFromNib()
        navigationView.setup(type: .show, delegate: self)
        navigationContainer.backgroundColor = UIColor(hex: ColorScheme.colorBody)
        navigationContainer.addSubview(navigationView)
        navigationView.matchParent()
    }
    
    private func setupPlacementView() {
        placementNameLabel.text = placementName ?? "N/A"
        placementTypeLabel.text = placementType ?? "N/A"
    }
    
    private func setupLoadingView() {
        loadingIndicator.isHidden = true
    }
    
    @IBAction func loadButtonPressed(_ sender: UIButton) {
        if adIsLoaded, !adIsLoading {
            AlertUtil.showAlert(parent: self, message: StringConstants.messageAdWasLoaded)
            return
        } else if adIsLoading, !adIsLoaded {
            AlertUtil.showAlert(parent: self, message: StringConstants.messageAdIsLoading)
            return
        }
        guard let appId = self.appId else { return }
        adIsLoading = true
        adIsLoaded = false
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        DioController.sharedInstance.isInitialized = false
        DioController.sharedInstance.initialize(withAppId: appId)
        DioController.sharedInstance.eventDelegate = self
    }
    
    @IBAction func showButtonPressed(_ sender: UIButton) {
        guard let placementId = self.placementId else { return }
        showAd(placemetnId: placementId)
    }
}

extension ShowPlacementViewController: ViewControllerDelegateProtocol {
    func onBackPressed() {
        navigationController?.popViewController(animated: true)
    }
}

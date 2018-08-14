//
//  AddPlacementViewController.swift
//  display.io Sample App
//
//  Created by akrat on 7/25/18.
//  Copyright © 2018 akrat. All rights reserved.
//

import UIKit
import DisplayIOFramework

class AddPlacementViewController: UIViewController {

    @IBOutlet weak var navigationContainer: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var appIdTextFieldContainer: UIView!
    @IBOutlet weak var appIdTextField: UITextField!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var navigationHeightConstraint: NSLayoutConstraint!
    
    weak var refreshPlacementsDelegate: RefreshPlacementsDelegateProtocol?
    
    private var placementWrappers = [PlacementWrapper]()
    private var appId: String?
    
    private let textFieldBorderWidth: CGFloat = 1
    private let textFieldCornerRadius: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationView()
        setupTableView()
        setupAddIdTextField()
        setupLoadingView()
        
        DioController.sharedInstance.placements = [:]
    }
    
    private func setupNavigationView() {
        navigationHeightConstraint.constant = UIApplication.shared.statusBarFrame.height + NavigationView.navigationHeight
        
        let navigationView = NavigationView.instanceFromNib()
        navigationView.setup(type: .show, delegate: self)
        navigationContainer.backgroundColor = UIColor(hex: ColorScheme.colorBody)
        navigationContainer.addSubview(navigationView)
        navigationView.matchParent()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: PlacementTableViewCell.identifier(), bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: PlacementTableViewCell.identifier())
    }
    
    private func setupAddIdTextField() {
        appIdTextFieldContainer.border(colorHex: ColorScheme.colorPrimary, width: textFieldBorderWidth)
        appIdTextFieldContainer.corner(radius: textFieldCornerRadius)
    }
    
    private func setupLoadingView() {
        loadingIndicator.isHidden = true
    }
    
    @IBAction func getPlacementsPressed(_ sender: UIButton) {
        if let appId = appIdTextField.text {
            if appId.isEmpty {
                AlertUtil.showAlert(parent: self, message: StringConstants.errAppIdIsNotDefined)
                return
            }
            
            if appId.count < 2 {
                AlertUtil.showAlert(parent: self, message: StringConstants.errAppIdIsTooShort)
                return
            }
            
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
            DioController.sharedInstance.placements = [:]
            tableview.reloadData()
            DioController.sharedInstance.isInitialized = false
            DioController.sharedInstance.eventDelegate = self
            DioController.sharedInstance.initialize(withAppId: appId)
            self.appId = appId
            view.endEditing(true)
        }
    }
}

extension AddPlacementViewController: DioEventDelegate {
    
    func onInit(placementIds: [String]) {
        for placementId in placementIds {
            if let placement = DioController.sharedInstance.placements[placementId], let name = placement.name, let type = StringConstants.adTypes[(placement.data?[StringConstants.adsKey].array?.first?[StringConstants.adKey][StringConstants.typeKey].string) ?? StringConstants.noFillKey], let appId = self.appId {
                loadingIndicator.stopAnimating()
                loadingIndicator.isHidden = true
                self.placementWrappers = [PlacementWrapper]()
                self.placementWrappers.append(PlacementWrapper(id: placement.id, name: name, type: type, appId: appId))
            }
        }
        tableview.reloadData()
    }
    
    func onInitError(message: String) {
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        AlertUtil.showAlert(parent: self, message: StringConstants.errAppInactive)
    }
    
    func onNoAds(placementId: String) {
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        AlertUtil.showAlert(parent: self, message: StringConstants.errNoFill)
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

extension AddPlacementViewController: ViewControllerDelegateProtocol {
    func onBackPressed() {
        navigationController?.popViewController(animated: true)
    }
}

extension AddPlacementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PlacementsStorage.addNewPlacement(placementWrapper: placementWrappers[indexPath.row])
        refreshPlacementsDelegate?.refreshPlacements()
        navigationController?.popViewController(animated: true)
    }
}

extension AddPlacementViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placementWrappers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let placementCell = tableView.dequeueReusableCell(withIdentifier: PlacementTableViewCell.identifier()) as! PlacementTableViewCell
        
        if !placementWrappers.isEmpty {
            let placementWrapper = placementWrappers[indexPath.row]
            placementCell.setup(placenentName: placementWrapper.name, placementType: placementWrapper.type, isRemovable: false)
        }
        
        return placementCell
    }
}


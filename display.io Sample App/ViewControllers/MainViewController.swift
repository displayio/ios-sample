//
//  MainViewController.swift
//  display.io Sample App
//
//  Created by akrat on 7/23/18.
//  Copyright © 2018 akrat. All rights reserved.
//

import UIKit
import DisplayIOFramework

protocol ViewControllerDelegateProtocol : class {
    func onBackPressed ()
}

protocol RemovePlacementDelegateProtocol : class {
    func removePlacement(placementCell: PlacementTableViewCell)
}

protocol RefreshPlacementsDelegateProtocol: class {
    func refreshPlacements()
}

enum PlacementSection: Int{
    case preDefined
    case userDefined
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var navigationContainer: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var addPlacementButton: UIButton!
    @IBOutlet weak var navigationHeightConstraint: NSLayoutConstraint!
    
    private let headerHeight: CGFloat = 40
    private let footerHeight: CGFloat = 16
    private let headerFontSize: CGFloat = 16
    
    var removeClosure: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationView()
        setupTableView()
    }
    
    private func setupNavigationView() {
        navigationHeightConstraint.constant = UIApplication.shared.statusBarFrame.height + NavigationView.navigationHeight
        
        let navigationView = NavigationView.instanceFromNib()
        navigationView.setup(type: .main, delegate: nil)
        navigationContainer.backgroundColor = UIColor(hex: ColorScheme.colorBody)
        navigationContainer.addSubview(navigationView)
        navigationView.matchParent()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: PlacementTableViewCell.identifier(), bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: PlacementTableViewCell.identifier())
    }
    
    @IBAction func onAddPressed(_ sender: UIButton) {
        let addViewController = UIStoryboard(.add).instantiateViewController(withIdentifier: AddPlacementViewController.identifier()) as! AddPlacementViewController
        addViewController.refreshPlacementsDelegate = self
        navigationController?.pushViewController(addViewController, animated: true)
    }
}

extension MainViewController: RefreshPlacementsDelegateProtocol {
    func refreshPlacements() {
        tableview.reloadData()
    }
}

extension MainViewController: RemovePlacementDelegateProtocol {
    func removePlacement(placementCell: PlacementTableViewCell) {
        if let position = tableview.indexPath(for: placementCell)?.row {
            removeClosure = {
                PlacementsStorage.removePlacement(index: position)
                self.tableview.deleteRows(at: [IndexPath(row: position, section: PlacementSection.userDefined.rawValue)], with: .automatic)
            }
            AlertUtil.showDialog(parent: self, title: StringConstants.dialogTitleRemovePlacement, message: String(format: StringConstants.dialogMessageRemovePlacement, PlacementsStorage.getUserDefinedPlacements()[position].name ?? "N/A"))
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showViewController = UIStoryboard(.show).instantiateViewController(withIdentifier: ShowPlacementViewController.identifier()) as! ShowPlacementViewController
        if indexPath.section == 0 {
            showViewController.appId = PlacementsStorage.predefinedPlacements[indexPath.row].appId
            showViewController.placementId = PlacementsStorage.predefinedPlacements[indexPath.row].id
            showViewController.placementName = PlacementsStorage.predefinedPlacements[indexPath.row].name
            showViewController.placementType = PlacementsStorage.predefinedPlacements[indexPath.row].type
        } else {
            showViewController.appId = PlacementsStorage.getUserDefinedPlacements()[indexPath.row].appId
            showViewController.placementId = PlacementsStorage.getUserDefinedPlacements()[indexPath.row].id
            showViewController.placementName = PlacementsStorage.getUserDefinedPlacements()[indexPath.row].name
            showViewController.placementType = PlacementsStorage.getUserDefinedPlacements()[indexPath.row].type
        }
        
        navigationController?.pushViewController(showViewController, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == PlacementSection.preDefined.rawValue ? footerHeight : 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView, let textLabel = headerView.textLabel {
            headerView.contentView.backgroundColor = UIColor(hex: ColorScheme.colorAccent)
            textLabel.font = UIFont(name: FontScheme.MontserratRegular, size: headerFontSize)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == PlacementSection.preDefined.rawValue ? StringConstants.predefinedPlacementsTitle : StringConstants.userDefinedPlacementsTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == PlacementSection.preDefined.rawValue ? PlacementsStorage.predefinedPlacements.count : PlacementsStorage.getUserDefinedPlacements().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let placementCell = tableView.dequeueReusableCell(withIdentifier: PlacementTableViewCell.identifier()) as! PlacementTableViewCell
        
        let removable = indexPath.section == PlacementSection.userDefined.rawValue
        
        if removable {
            placementCell.removePlacementDelegate = self
            let placement = PlacementsStorage.getUserDefinedPlacements()[indexPath.row]
            placementCell.setup(placenentName: placement.name, placementType: placement.type, isRemovable: removable)
        } else {
            let placement = PlacementsStorage.predefinedPlacements[indexPath.row]
            placementCell.setup(placenentName: placement.name, placementType: placement.type, isRemovable: removable)
        }
    
        return placementCell
    }
}


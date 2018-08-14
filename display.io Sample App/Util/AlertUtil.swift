//
//  AlertUtil.swift
//  display.io Sample App
//
//  Created by akrat on 8/9/18.
//  Copyright © 2018 akrat. All rights reserved.
//

import UIKit
import Foundation

class AlertUtil {
//    static func showAlert(parent: UIViewController, title: String?, message: String?, isError: Bool = false) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alertController.view.backgroundColor = UIColor(hex: isError ? ColorScheme.colorLightRed : ColorScheme.colorLightGreen)
//
//        parent.present(alertController, animated: true, completion: nil)
//    }
    
    static func showAlert(parent: UIViewController, message: String?) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: StringConstants.okKey, style: .default) { (action: UIAlertAction) in
            alertController.dismiss(animated: true, completion: nil)
        })
        
        parent.present(alertController, animated: true)
        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
//            alertController.dismiss(animated: true)
//        }
    }
    
    static func showDialog(parent: UIViewController, title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: StringConstants.dialogButtonRemovePlacementCancel, style: .cancel) { (action: UIAlertAction) in
            alertController.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(UIAlertAction(title: StringConstants.dialogButtonRemovePlacementRemove, style: .destructive) { (action: UIAlertAction) in
            if let mainViewController = parent as? MainViewController, let closure = mainViewController.removeClosure {
                closure()
            }
        })
        
        parent.present(alertController, animated: true, completion: nil)
    }
}

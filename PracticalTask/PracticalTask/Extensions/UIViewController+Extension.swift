//
//  UIViewController+Extension.swift
//  PracticalTask
//
//  Created by Hitesh Mistri on 8/14/19.
//  Copyright © 2019 Taykun. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

enum AppStoryBoardString: String {
    case main     = "Main"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiateFromAppStoryboard(appStoryboard: AppStoryBoardString) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    
    // Show Alert
    func showAlert(message:String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { (action: UIAlertAction!) in
            alert.dismiss(animated: false, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithConditionalDialog(title:String = "",message:String,buttonCancelTitle:String = "Cancel",buttonOkTitle:String = "Ok", completion:@escaping(Bool) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: buttonCancelTitle, style: .cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
            completion(false)
        }
        let ok = UIAlertAction(title: buttonOkTitle, style: .default) { (action) in
            alertController.dismiss(animated: true, completion: nil)
            completion(true)
        }
        alertController.addAction(cancel)
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK:- Member Function
    func setIQKeyboardManager(isEnable:Bool) {
        IQKeyboardManager.shared.enable = isEnable
        IQKeyboardManager.shared.shouldResignOnTouchOutside = isEnable
        IQKeyboardManager.shared.enableAutoToolbar = isEnable
    }
}


//
//  ViewControllerExtension.swift
//  Asteroid
//
//  Created by Nitin Bhatia on 10/02/23.
//

import UIKit

extension UIViewController {
    func showAlert(title:String, message:String,btnTitle:String,shouldShowCancelButton:Bool = false,completion:@escaping(_ alertAction:UIAlertAction)->Void) {
        let alertController = UIAlertController(title: title , message: message , preferredStyle: .alert)
        
        let btn = UIAlertAction(title: btnTitle, style: .default) { action in
            completion(action)
        }
        let btnCancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            completion(action)
        }
        
        if shouldShowCancelButton {
            alertController.addAction(btnCancel)
        }
        
        alertController.addAction(btn)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

//
//  AlertViews.swift
//  vypeNative
//
//  Created by Jake Flaten on 6/26/18.
//  Copyright © 2018 Fanreact. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    public func presentDefaultAlertView(title: String?, message: String, dismissalMessage: String?, completion: @escaping () -> Void = {}) {
        let errorTitle = title ?? "An Error Occured"
        let dismissal = dismissalMessage ?? "OK"
        let alert = UIAlertController(title: errorTitle, message: message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: dismissal, style: .default, handler: {_ in
            alert.dismiss(animated: true, completion: completion)
            
        })
        alert.addAction(dismissButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    public func presentPreviewAlertView(completion: @escaping () -> Void = {}) {
        let title = "Preview Mode"
        let message = "The functionality of the page has been disabled for preview mode"
        let dismissal = "OK"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: dismissal, style: .default, handler: {_ in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(dismissButton)
        self.present(alert, animated: true, completion: completion)
    }
    
    public func presentFireJakeAlertView(completion: @escaping () -> Void = {}) {
        let title = "It Doesn't Work Yet"
        let message = "This funcionality hasn't been built!"
        let dismissal = "Fire Jake"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: dismissal, style: .default, handler: {_ in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(dismissButton)
        self.present(alert, animated: true, completion: completion)
    }
    
    public func presentNoNetworkErrorView(completion: @escaping () -> Void = {}) {
        let title = "No Network Detected"
        let message = "We couldn't access the internet via wifi or data. please try again when you have a connection"
        let dismissal = "OK"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: dismissal, style: .default, handler: {_ in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(dismissButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showChooseAlert(email: String, phone: String) {
        let alert = UIAlertController(title: "Please choose a contact method", message: nil, preferredStyle: .alert)
        let phoneAction = UIAlertAction(title: "Phone", style: .default) { _ in
            if let url = URL(string: "sms:+1\(phone)") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                return
            }
        }
        let emailAction = UIAlertAction(title: "Email", style: .default) { _ in
            if let url = URL(string: "mailto:\(email)") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                return
            }
        }
        let dismissButton = UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
            alert.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(phoneAction)
        alert.addAction(emailAction)
        alert.addAction(dismissButton)
        self.present(alert, animated: true)
    }
    
    public func presentDismissingAlertView(title: String?, message: String, dismissalMessage: String?, completion: @escaping () -> Void = {}) {
        let errorTitle = title ?? "An Error Occured"
        let dismissal = dismissalMessage ?? "OK"
        let alert = UIAlertController(title: errorTitle, message: message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: dismissal, style: .default, handler: {_ in
            alert.dismiss(animated: true, completion: nil)
            if self.parent != nil {
                self.parent!.dismiss(animated: true, completion: nil)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        })
        alert.addAction(dismissButton)
        self.present(alert, animated: true, completion: completion)
    }
    
    public func presentPoppingAlertView(title: String?, message: String, dismissalMessage: String?, completion: @escaping () -> Void = {}) {
        let errorTitle = title ?? "An Error Occured"
        let dismissal = dismissalMessage ?? "OK"
        let alert = UIAlertController(title: errorTitle, message: message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: dismissal, style: .default, handler: {_ in
            alert.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(dismissButton)
        self.present(alert, animated: true, completion: completion)
    }
    
    class PickerHelper: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        
        let items: [String]
        public var selected: Int = -1
        
        override init() {
            items = []
            super.init()
        }
        
        init(items: [String]) {
            self.items = items
            super.init()
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return items.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return items[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selected = row
        }
    }

}

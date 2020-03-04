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
}

//
//  Extensions.swift
//  trussChatiOS
//
//  Created by Jake Flaten on 9/12/19.
//  Copyright © 2019 professionil. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UIImageView

extension UIImageView {
    public func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                guard let self = self else {return}
                self.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}


// MARK: - UIView

extension UIView {

    func addSubviewWithAutoLayout(_ vw: UIView) {
        vw.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(vw)
    }
    
    public func roundAllCorners(withShadow: Bool = true) {
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        if withShadow {
            self.layer.shadowColor = UIColor.lightGray.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            self.layer.shadowRadius = 2.0
            self.layer.shadowOpacity = 1.0
        }
        self.layer.masksToBounds = true
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
    }
    
}



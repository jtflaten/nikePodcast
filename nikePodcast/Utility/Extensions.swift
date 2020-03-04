//
//  Extensions.swift
//  trussChatiOS
//
//  Created by Jake Flaten on 9/12/19.
//  Copyright © 2019 professionil. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIViewController
extension UIViewController {
    
    
    
    func addChildViewControllerToContainerView(viewController: UIViewController, containerView: UIView) {
        let vc = viewController
        self.addChild(vc)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(vc.view)
        NSLayoutConstraint.activate([
        vc.view.topAnchor.constraint(equalTo: containerView.topAnchor),
        vc.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        vc.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        vc.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        ])
        vc.didMove(toParent: self)
    }
    
    func setViewControllerInContainerView(viewController: UIViewController, containerView: UIView) {
        if self.children.isEmpty {
            let vc = viewController
            self.addChild(vc)
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(vc.view)
            NSLayoutConstraint.activate([
                vc.view.topAnchor.constraint(equalTo: containerView.topAnchor),
                vc.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                vc.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                vc.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
            ])
            vc.didMove(toParent: self)
        } else {
            guard let oldVC = self.children.last else {
                return
            }
            let vc = viewController
            oldVC.willMove(toParent: nil)
            self.addChild(vc)
            
            if !containerView.subviews.isEmpty {
                containerView.subviews.forEach {
                    $0.removeFromSuperview()
                }
            }
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(vc.view)
            NSLayoutConstraint.activate([
                vc.view.topAnchor.constraint(equalTo: containerView.topAnchor),
                vc.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                vc.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                vc.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
            ])
            vc.didMove(toParent: self)
            oldVC.removeFromParent()
        }
        
    }
}

//MARK: - UIImageView

extension UIImageView {
    public func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
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
    
    public func roundCorners(forTop: Bool = true, withShadow: Bool = true) {
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        if withShadow {
            self.layer.shadowColor = UIColor.lightGray.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            self.layer.shadowRadius = 2.0
            self.layer.shadowOpacity = 1.0
        }
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.maskedCorners = forTop ? [.layerMinXMinYCorner, .layerMaxXMinYCorner]: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
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
    
    public func addViewAndConstrainToSuper(superView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(self)
        let bottomConstraint = NSLayoutConstraint(item: self,
                                                  attribute: NSLayoutConstraint.Attribute.bottom,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: superView,
                                                  attribute: NSLayoutConstraint.Attribute.bottom,
                                                  multiplier: CGFloat(1),
                                                  constant: CGFloat(0))
        let topConstraint = NSLayoutConstraint(item: self,
                                               attribute: NSLayoutConstraint.Attribute.top,
                                               relatedBy: NSLayoutConstraint.Relation.equal,
                                               toItem: superView,
                                               attribute: NSLayoutConstraint.Attribute.top,
                                               multiplier: CGFloat(1),
                                               constant: CGFloat(0))
        let leadingConstraint = NSLayoutConstraint(item: self,
                                                   attribute: NSLayoutConstraint.Attribute.leading,
                                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                                   toItem: superView,
                                                   attribute: NSLayoutConstraint.Attribute.leading,
                                                   multiplier: CGFloat(1),
                                                   constant: CGFloat(0))
        let trailingConstraint = NSLayoutConstraint(item: self,
                                                    attribute: NSLayoutConstraint.Attribute.trailing,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: superView,
                                                    attribute: NSLayoutConstraint.Attribute.trailing,
                                                    multiplier: CGFloat(1),
                                                    constant: CGFloat(0))
        let constraints = [topConstraint, bottomConstraint, leadingConstraint, trailingConstraint]
        superView.addConstraints(constraints)
    }
    
}

// MARK: UIImage
extension UIImage {
    public static func rotateCameraImageToProperOrientation(imageSource: UIImage, maxResolution: CGFloat = 320) -> UIImage? {
        
        guard let imgRef = imageSource.cgImage else {
            return nil
        }
        
        let width = CGFloat(imgRef.width)
        let height = CGFloat(imgRef.height)
        
        var bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        var scaleRatio: CGFloat = 1
        if width > maxResolution || height > maxResolution {
            
            scaleRatio = min(maxResolution / bounds.size.width, maxResolution / bounds.size.height)
            bounds.size.height *=  scaleRatio
            bounds.size.width *= scaleRatio
        }
        
        var transform = CGAffineTransform.identity
        let orient = imageSource.imageOrientation
        let imageSize = CGSize(width: CGFloat(imgRef.width), height: CGFloat(imgRef.height))
        
        switch imageSource.imageOrientation {
        case .up:
            transform = .identity
        case .upMirrored:
            transform = CGAffineTransform
                .init(translationX: imageSize.width, y: 0)
                .scaledBy(x: -1.0, y: 1.0)
        case .down:
            transform = CGAffineTransform
                .init(translationX: imageSize.width, y: imageSize.height)
                .rotated(by: CGFloat.pi)
        case .downMirrored:
            transform = CGAffineTransform
                .init(translationX: 0, y: imageSize.height)
                .scaledBy(x: 1.0, y: -1.0)
        case .left:
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = storedHeight
            transform = CGAffineTransform
                .init(translationX: 0, y: imageSize.width)
                .rotated(by: 3.0 * CGFloat.pi / 2.0)
        case .leftMirrored:
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = storedHeight
            transform = CGAffineTransform
                .init(translationX: imageSize.height, y: imageSize.width)
                .scaledBy(x: -1.0, y: 1.0)
                .rotated(by: 3.0 * CGFloat.pi / 2.0)
        case .right :
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = storedHeight
            transform = CGAffineTransform
                .init(translationX: imageSize.height, y: 0)
                .rotated(by: CGFloat.pi / 2.0)
        case .rightMirrored:
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = storedHeight
            transform = CGAffineTransform
                .init(scaleX: -1.0, y: 1.0)
                .rotated(by: CGFloat.pi / 2.0)
        default:
            transform = .identity
        }
        
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            if orient == .right || orient == .left {
                context.scaleBy(x: -scaleRatio, y: scaleRatio)
                context.translateBy(x: -height, y: 0)
            } else {
                context.scaleBy(x: scaleRatio, y: -scaleRatio)
                context.translateBy(x: 0, y: -height)
            }
            
            context.concatenate(transform)
            context.draw(imgRef, in: CGRect(x: 0, y: 0, width: width, height: height))
        }
        
        let imageCopy = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageCopy
    }
}

extension Optional where Wrapped == String {
    
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
    
}

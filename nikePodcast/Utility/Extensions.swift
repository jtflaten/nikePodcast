//
//  Extensions.swift
//  trussChatiOS
//
//  Created by Jake Flaten on 9/12/19.
//  Copyright © 2019 professionil. All rights reserved.
//

import Foundation
import UIKit

// MARK: UIViewController
extension UIViewController {
    
    func addTapOutsideToDismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
        NotificationCenter.default.post(name: .outsideTapped, object: nil)
    }
    
    func addOutsideTapGestureReconizer() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(fireOutsideTapped))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func fireOutsideTapped() {
        NotificationCenter.default.post(name: .outsideTapped, object: nil)
    }
    
    static func storyboardInstance<T: UIViewController>() -> T? {
        let storyBoard = UIStoryboard(name: String(describing: (self)), bundle: nil)
        let ret = storyBoard.instantiateInitialViewController()
        return ret as? T
    }

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

// MARK: UITableView

// swiftlint:disable force_cast
extension UITableView {
    func dequeue<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

// MARK: UICollectionView
extension UICollectionView {
    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

// MARK: UIColor
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init(hex: String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if (cString.count) != 6 {
            self.init()
        } else {
            var rgbValue: UInt64 = 0

            Scanner(string: cString).scanHexInt64(&rgbValue)
            self.init(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
    }
 
    var hexString: String {
        let colorRef = cgColor.components
        let r = colorRef?[0] ?? 0
        let g = colorRef?[1] ?? 0
        let b = ((colorRef?.count ?? 0) > 2 ? colorRef?[2] : g) ?? 0
        let a = cgColor.alpha
        
        var color = String(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(r * 255)),
            lroundf(Float(g * 255)),
            lroundf(Float(b * 255))
        )
        
        if a < 1 {
            color += String(format: "%02lX", lroundf(Float(a)))
        }
        
        return color
    }
}

// MARK: UIView
extension UIView {
   
    static func nibInstance<T: UIView>() -> T? {
        if let nibView = Bundle.main.loadNibNamed(String(describing: (self)), owner: nil, options: nil)?.first as? T {
            return nibView
        }
        return nil
    }
    
    public func makeCircular(withBorder border: CGFloat? = nil) {
        if let border = border {
            self.layer.borderWidth = border
            self.layer.borderColor = Colors.gray2?.cgColor
        }
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
    public func addShadow() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
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

extension UITextViewDelegate {
    func removePlaceholder(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func resetPlaceholder(_ textView: UITextView, to placeholder: String) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = UIColor.lightGray
        }
    }
}

extension Optional where Wrapped == String {
    
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
    
}

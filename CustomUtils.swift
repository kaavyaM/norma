//
//  CustomUtils.swift
//  Corgis
//
//  Created by Sal Valdes on 11/21/17.
//  Copyright © 2017 CS147. All rights reserved.
//

import UIKit
extension UIImage {
    func flipImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let bitmap = UIGraphicsGetCurrentContext()!
        
        bitmap.translateBy(x: size.width / 2, y: size.height / 2)
        bitmap.scaleBy(x: -1.0, y: -1.0)
        
        bitmap.translateBy(x: -size.width / 2, y: -size.height / 2)
        bitmap.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIView {
    
    func dropShadow(color: UIColor = UIColor.black, opacity: Float = 0.5, offSet: CGSize = CGSize(width: -1, height: 2), radius: CGFloat = 4.0, scale: Bool = true) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
    }
    
    func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        let color1 = UIColor(hexString: "#4FCC83")
        let color2 = UIColor(hexString: "#27AE60")
        gradientLayer.colors = [color2.cgColor, color1.cgColor]
        gradientLayer.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func backgroundPhoto(photo: UIImage) {
        let layer = CALayer()
        
        let backgroundImage = photo.cgImage
        layer.frame = self.bounds
        layer.contents = backgroundImage
        
        self.layer.insertSublayer(layer, at:0)
        
    }
}



extension UIViewController {
    
    func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        let color1 = UIColor(hexString: "#4FCC83")
        let color2 = UIColor(hexString: "#27AE60")
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}





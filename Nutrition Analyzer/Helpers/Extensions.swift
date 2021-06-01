//
//  Extensions.swift
//  Nutrition Analyzer
//
//  Created by Mahmoud Eissa on 5/30/21.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        set {
            layer.borderColor = newValue.cgColor
        }
        get {
            return UIColor.init(cgColor: layer.borderColor!)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
 
    @IBInspectable var shadow: UIColor {
        set {
            let shadowLayer = ShapeLayer(color: newValue,
                                         cornerRadius: layer.cornerRadius,
                                         frame: frame)
            shadowLayer.view = self
            clipsToBounds = true
            if let view = superview{
                view.layer.insertSublayer(shadowLayer, at: 0)
            }
        } get {
            return UIColor.clear
        }
    }
    
}

class ShapeLayer: CAShapeLayer {
    weak var view: UIView?
    convenience init(color: UIColor, cornerRadius: CGFloat, frame: CGRect) {
        self.init()
        path = UIBezierPath(roundedRect: frame, cornerRadius: cornerRadius).cgPath
        fillColor = UIColor.clear.cgColor
        shadowColor = color.cgColor
        shadowPath = path
        shadowOffset = CGSize(width: 0, height: 0)
        shadowOpacity = 0.8
        shadowRadius = 5
    }
}

extension Float {
    func string(style: NumberFormatter.Style) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(identifier: "en")
        formatter.numberStyle = style
        formatter.maximumFractionDigits = 2;
        let number = NSNumber.init(value: self)
        return formatter.string(from: number)!
    }
}

extension UITableView {
    func registerCell<T: UITableViewCell>(ofType type: T.Type)  {
        register(T.nib, forCellReuseIdentifier: T.identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>() -> T? {
        return dequeueReusableCell(withIdentifier: T.identifier) as? T
    }
}

extension UITableViewCell {
    static var nib: UINib {
        return UINib.init(nibName: String(describing: self), bundle: .main)
    }
    static var identifier: String {
        return String(describing: self)
    }
}


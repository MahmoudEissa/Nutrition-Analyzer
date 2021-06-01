//
//  Swizzler.swift
//  Nutrition Analyzer
//
//  Created by Mahmoud Eissa on 5/30/21.
//

import UIKit


class Swizzler {
    static func swizzleForUI()  {
        MethodSwizzleGivenClassName(cls: UIView.self, originalSelector: #selector(UIView.layoutSubviews), overrideSelector: #selector(UIView.cstmlayoutSubviews))
    }
    
    
}
extension UIView {
    @objc func cstmlayoutSubviews()  {
        self.cstmlayoutSubviews()
        guard let layers = self.layer.sublayers  else { return }
        
        for layer in layers where layer is ShapeLayer {
            guard let layer = layer as? ShapeLayer else { return }
            guard let view = subviews.first(where: { $0 == layer.view })else { return }
            layer.path = UIBezierPath(roundedRect: view.frame, cornerRadius: view.cornerRadius).cgPath
            layer.shadowPath = layer.path
        }
    }
}

func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    let origMethod: Method = class_getInstanceMethod(cls, originalSelector)!;
    let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)!;
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}


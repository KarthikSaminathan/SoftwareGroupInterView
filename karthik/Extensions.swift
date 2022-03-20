//
//  Extensions.swift
//  karthik
//
//  Created by Florakarthik on 18/03/22.
//

import Foundation
import UIKit


extension UIView {
    func applyShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 2;
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
    }
    func applyLightShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2;
        self.layer.shadowRadius = 15;
        self.layer.shadowOffset = CGSize.zero
        self.layer.rasterizationScale = UIScreen.main.scale

    }
    func applyCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    func applyBorder() {
        self.clipsToBounds = true
        //self.layer.borderColor = CyberwaColors.borderColor.cgColor
        self.layer.borderWidth = 1.0
        //self.layer.cornerRadius = self.cornerRadius
    }
}

extension UILabel {
    func baseSetup(text: String? = nil, fontSize: CGFloat, color: UIColor, alignment: NSTextAlignment = .left, needShadow: Bool = false) {
        if let text = text {
            self.text = text
        }
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textColor = color
        self.textAlignment = alignment
        if needShadow {
            self.applyShadow()
        }
    }
}

extension UIStackView {
    func baseSetup(axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0, alignment: Alignment, distribution: Distribution, needShadow: Bool = false) {
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
        if needShadow {
            self.applyShadow()
        }
    }
}

extension UIWindow {
    static var isLandscape: Bool {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows
                .first?
                .windowScene?
                .interfaceOrientation
                .isLandscape ?? false
        } else {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
}


extension URL {
    func asyncDownload(completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()) {
        URLSession.shared
            .dataTask(with: self, completionHandler: completion)
            .resume()
    }
}

extension Date {
    func inString() -> String? {
        let df = DateFormatter()
        df.dateFormat = "dd MMMM yyyy hh:mm a"
        return df.string(from: self)
    }
}
extension String {
    func currentWeatherTitle() -> String? {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = df.date(from: self) else {
            return "NA"
        }
        df.dateFormat = "HH a"
        let value = df.string(from: date)
        if value == "00 AM" {
            return "12 AM"
        }
        return df.string(from: date)
    }
    func givenDate() -> String? {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        guard let date = df.date(from: self) else {
            return "NA"
        }
        df.dateFormat = "EEEE"
        return df.string(from: date)
    }
}

//
//  UI.swift
//  BridgeRunGame
//
//  Created by Victor Brito on 17/06/21.
//

import Foundation
import UIKit

extension UIColor {

    class func platformColor() -> UIColor {
        return UIColor().hexStringToUIColor(hex: "#0f291d")
    }

    class func floorColor() -> UIColor {
        return UIColor().hexStringToUIColor(hex: "#254024")
    }

    class func groundColor() -> UIColor {
        return UIColor().hexStringToUIColor(hex: "#254024")
    }

    class func coinsTextColor() -> UIColor {
        return UIColor().hexStringToUIColor(hex: "#ffffff")
    }

    private func hexStringToUIColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        cString.remove(at: cString.startIndex)

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}

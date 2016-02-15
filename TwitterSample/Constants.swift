//
//  Constants.swift
//  TwitterSample
//
//  Created by 藤井陽介 on 2016/02/15.
//  Copyright © 2016年 touyou. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    // version情報を返す
    struct Product {
        static func version() -> String {
            return "1.0"
        }
    }
    
    struct Theme {
        // my app concept color is #d9e5ff
        static func concept() -> UIColor {
            return UIColor(red: 217.0, green: 229.0, blue: 255, alpha: 1.0)
        }
    }
}
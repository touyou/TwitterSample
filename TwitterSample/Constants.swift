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
        // my app concept color is #00cccc
        static func concept() -> UIColor {
            return UIColor(red: 0.0, green: 204.0, blue: 204.0, alpha: 1.0)
        }
    }
}
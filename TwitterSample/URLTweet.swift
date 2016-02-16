//
//  URLTweet.swift
//  TwitterSample
//
//  Created by 藤井陽介 on 2016/02/16.
//  Copyright © 2016年 touyou. All rights reserved.
//

import Foundation
import TwitterKit

class URLTweet: TWTRTweet {
    var url : String = ""
    
    override init!(JSONDictionary dictionary: [NSObject : AnyObject]!) {
        super.init(JSONDictionary: dictionary)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func tweetsWithJSONArray(array: [AnyObject]!) -> [AnyObject]! {
        var list: [AnyObject]!
        if array != nil {
            list = [AnyObject]()
            for status in array {
                let tweet = URLTweet(JSONDictionary: status as! [NSObject : AnyObject])
                // set URL from json status -> entities -> urls -> expanded_url
                if let status = status as? NSDictionary {
                    if let entities = status["entities"] as? NSDictionary {
                        if let urls = entities["urls"] as? NSArray {
                            if urls.count > 0 {
                                if let url = urls[0] as? NSDictionary {
                                    if let expandedUrl = url["expanded_url"] as? String {
                                        tweet.url = expandedUrl
                                    }
                                }
                            }
                        }
                    }
                }
                list.append(tweet)
            }
        }
        return list
    }
}
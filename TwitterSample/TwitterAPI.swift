//
//  TwitterAPI.swift
//  TwitterSample
//
//  Created by 藤井陽介 on 2016/02/13.
//  Copyright © 2016年 touyou. All rights reserved.
//

import Foundation
import TwitterKit

// TwitterのAPIクラス
// 将来的にこれでいろんな機能を実装して流用できればいい
class TwitterAPI {
    let baseURL = "https://api.twitter.com"
    let version = "/1.1"

    init() {
    }
    
    // Swift2でエラーが出ないようにいじった
    // 普通のタイムライン
    class func getHomeTimeLine(tweets: [TWTRTweet]->(), error: (NSError)->()) {
        getAnyStatus(tweets, error: error, path: "/statuses/home_timeline.json")
    }
    // 自分に対するメンションのタイムライン
    class func getMentionTimeLine(tweets: [TWTRTweet]->(), error: (NSError)->()) {
        getAnyStatus(tweets, error: error, path: "/statuses/mention_timeline.json")
    }
    // 自分のリツイートされた通知
    class func getRetweetTimeLine(tweets: [TWTRTweet]->(), error: (NSError)->()) {
        getAnyStatus(tweets, error: error, path: "statuses/retweets_of_me.json")
    }
    
    // TimeLine一般を取得する
    class func getAnyStatus(tweets: [TWTRTweet]->(), error: (NSError)->(), path: String) {
        let api = TwitterAPI()
        var clientError: NSError?
        let endpoint = api.baseURL + api.version + path
        let request = Twitter.sharedInstance().APIClient.URLRequestWithMethod("GET", URL: endpoint, parameters: nil, error: &clientError)
        
        Twitter.sharedInstance().APIClient.sendTwitterRequest(request, completion: {
            response, data, err in
            if err == nil {
                do {
                    let json: AnyObject? = try NSJSONSerialization.JSONObjectWithData(data!,
                        options: NSJSONReadingOptions.MutableContainers)
                    if let jsonArray = json as? NSArray {
                        tweets(TWTRTweet.tweetsWithJSONArray(jsonArray as [AnyObject]) as! [TWTRTweet])
                    }
                } catch {
                }
            } else {
                error(err!)
            }
        })

    }
    // POSTアクションはこっち
    class func postAnyStatus(tweets: [TWTRTweet]->(), error: (NSError)->(), path: String) {
        let api = TwitterAPI()
        var clientError: NSError?
        let endpoint = api.baseURL + api.version + path
        let request = Twitter.sharedInstance().APIClient.URLRequestWithMethod("POST", URL: endpoint, parameters: nil, error: &clientError)
        Twitter.sharedInstance().APIClient.sendTwitterRequest(request, completion: {
            response, data, err in
            if err == nil {
                do {
                    let json: AnyObject? = try NSJSONSerialization.JSONObjectWithData(data!,
                        options: NSJSONReadingOptions.MutableContainers)
                    if let jsonArray = json as? NSArray {
                        tweets(TWTRTweet.tweetsWithJSONArray(jsonArray as [AnyObject]) as! [TWTRTweet])
                    }
                } catch {
                }
            } else {
                error(err!)
            }
        })

    }
    
}

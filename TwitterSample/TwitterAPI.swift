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
    
    var maxIdStr: String = ""
    var sinceIdStr: String = ""
    

    init() {
    }
    
    // Swift2でエラーが出ないようにいじった
    // paramsに色々渡すらしい
    // 極限まで関数わける
    // 普通のタイムライン
    class func getHomeTimeLine(params: [NSObject: AnyObject]!, tweets: [TWTRTweet]->(), error: (NSError)->()) {
        getAnyStatus(params, tweets: tweets, error: error, path: "/statuses/home_timeline.json")
    }
    // 自分に対するメンションのタイムライン
    class func getMentionTimeLine(params: [NSObject: AnyObject]!, tweets: [TWTRTweet]->(), error: (NSError)->()) {
        getAnyStatus(params, tweets: tweets, error: error, path: "/statuses/mentions_timeline.json")
    }
    // 自分のリツイートされた通知
    class func getRetweetTimeLine(params: [NSObject: AnyObject]!, tweets: [TWTRTweet]->(), error: (NSError)->()) {
        getAnyStatus(params, tweets: tweets, error: error, path: "statuses/retweets_of_me.json")
    }
    // お気に入りリスト
    class func getMyFavorites(params: [NSObject: AnyObject]!, tweets: [TWTRTweet]->(), error: (NSError)->()) {
        getAnyStatus(params, tweets: tweets, error: error, path: "/favorites/list.json")
    }
    
    // TimeLine一般を取得する
    class func getAnyStatus(params: [NSObject: AnyObject]!, tweets: [TWTRTweet]->(), error: (NSError)->(), path: String) {
        let api = TwitterAPI()
        var clientError: NSError?
        let endpoint = api.baseURL + api.version + path
        let request = Twitter.sharedInstance().APIClient.URLRequestWithMethod("GET", URL: endpoint, parameters: params, error: &clientError)
        
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
                // self.maxIdStr = response["max_id"]
                // self.sinceIdStr = response["since_id"]
                
            } else {
                error(err!)
            }
        })

    }
    // POSTアクションはこっち
    class func postAnyStatus(params: [NSObject: AnyObject]!, tweets: [TWTRTweet]->(), error: (NSError)->(), path: String) {
        let api = TwitterAPI()
        var clientError: NSError?
        let endpoint = api.baseURL + api.version + path
        let request = Twitter.sharedInstance().APIClient.URLRequestWithMethod("POST", URL: endpoint, parameters: params, error: &clientError)
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
    // もうひとつの呼び出し方？
//    class func search(params: [NSObject : AnyObject]!, tweets: [TWTRTweet]->(), error: (NSError) -> ()) {
//        self.callAPI("/search/tweets.json", parameters: params, completion: {
//            response, data, err in
//            if err == nil {
//                do {
//                    let json: AnyObject? =  try NSJSONSerialization.JSONObjectWithData(data!,
//                    options: NSJSONReadingOptions.MutableContainers)
//                    if let top = json as? NSDictionary {
//                        var list: [TWTRTweet] = []
//                        if let statuses = top["statuses"] as? NSArray {
//                            list = TWTRTweet.tweetsWithJSONArray(statuses as [AnyObject]) as! [TWTRTweet]
//                        }
//                        tweets(list)
//                    }
//                } catch {
//                }
//            } else {
//                error(err!)
//            }
//        })
//    }
//    class func callAPI(path: String, parameters: [NSObject: AnyObject]!, completion: TWTRNetworkCompletion!) {
//        self._callAPI(path, method: "GET", parameters: parameters, completion: completion)
//    }
//    class func _callAPI(path: String, method: String, parameters: [NSObject: AnyObject]!, completion: TWTRNetworkCompletion!) {
//        let api = TwitterAPI()
//        var clientError: NSError?
//        let endpoint = api.baseURL + api.version + path
//        let request = Twitter.sharedInstance().APIClient.URLRequestWithMethod(method, URL: endpoint, parameters: parameters, error: &clientError)
//        Twitter.sharedInstance().APIClient.sendTwitterRequest(request, completion: completion)
//    }
}

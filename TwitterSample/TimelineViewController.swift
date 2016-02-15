//
//  TimelineViewController.swift
//  TwitterSample
//
//  Created by 藤井陽介 on 2016/02/13.
//  Copyright © 2016年 touyou. All rights reserved.
//

import UIKit
import TwitterKit
import Foundation

class TimelineViewController:BaseTweetViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "タイムライン"
    }
    
    override func load() {
        let params = ["count": "40"]
        TwitterAPI.getHomeTimeLine(params, tweets: {
            twttrs in
            for tweet in twttrs {
                self.tweets.append(tweet)
            }
            self.tableView.reloadData()
            }, error: {
                error in
                // error handling
        })
    }
}

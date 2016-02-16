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
    // max_idの管理が微妙なので余分に一個とっておいてそれをmaxIdStrに保存しておき次にはそこから読み込むようにする
    override func load(cb: () -> (), errcb: () -> ()) {
        let params = ["count": "41"]
        TwitterAPI.getHomeTimeLine(params, tweets: {
            twttrs in
            for var i = 0; i < twttrs.count-1; i++ {
                self.tweets.append(twttrs[i])
            }
            self.maxIdStr = twttrs[twttrs.count - 1].tweetID
            self.tableView.reloadData()
            }, error: {
                error in
                // error handling
        })
    }
    override func loadMore(cb: () -> (), errcb: () -> ()) {
        let params = ["count": "41", "max_id": self.maxIdStr]
        TwitterAPI.getHomeTimeLine(params, tweets: {
            twttrs in
            for var i = 0; i < twttrs.count-1; i++ {
                self.tweets.append(twttrs[i])
            }
            self.maxIdStr = twttrs[twttrs.count - 1].tweetID
            self.tableView.reloadData()
            }, error: {
                error in
                // error handling
        })
    }
}

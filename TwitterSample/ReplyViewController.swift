//
//  RetweetViewController.swift
//  TwitterSample
//
//  Created by 藤井陽介 on 2016/02/14.
//  Copyright © 2016年 touyou. All rights reserved.
//

import UIKit

class ReplyViewController: BaseTweetViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "リプライ"
    }

    override func load(cb: () -> (), errcb: () -> ()) {
        let params = ["count": "40"]
        TwitterAPI.getMentionTimeLine(params, tweets: {
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
    override func loadMore(cb: () -> (), errcb: () -> ()) {
        let params = ["count": "40", "max_id": self.maxIdStr]
        TwitterAPI.getMentionTimeLine(params, tweets: {
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

//
//  TimelineViewController.swift
//  TwitterSample
//
//  Created by 藤井陽介 on 2016/02/13.
//  Copyright © 2016年 touyou. All rights reserved.
//

import UIKit
import TwitterKit

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    var tweets: [TWTRTweet] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var prototypeCell: TWTRTweetTableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        // これが一つ一つのセル、Twitter API側に用意されている
        prototypeCell = TWTRTweetTableViewCell(style: .Default, reuseIdentifier: "cell")
        
        tableView.registerClass(TWTRTweetTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        loadTweets()
    }
    
    // これでTLをロードする、これにボタンとかつけたらスライド更新とかできそう
    func loadTweets() {
        TwitterAPI.getHomeTimeLine({
            twttrs in
            for tweet in twttrs {
                self.tweets.append(tweet)
            }
            }, error: {
                error in
                print(error.localizedDescription)
        })
    }

    // MARK: UITableViewDataSource
    // 取得したTweetの数だけTableViewのセルをつくる
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    // セルの内容を返す
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! TWTRTweetTableViewCell
        
        let tweet = tweets[indexPath.row]
        cell.configureWithTweet(tweet)
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    // セルの大きさを決める
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let tweet = tweets[indexPath.row]
        
        prototypeCell?.configureWithTweet(tweet)
        
        if let height = prototypeCell?.calculatedHeightForWidth(self.view.bounds.width) {
            return height
        } else {
            return tableView.estimatedRowHeight
        }
    }
}

//
//  BaseTweetViewController.swift
//  TwitterSample
//
//  Created by 藤井陽介 on 2016/02/14.
//  Copyright © 2016年 touyou. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit

// 両方に共通するViewController、これを継承して２つのViewを作成する
class BaseTweetViewController: UIViewController {
    
    var tableView: UITableView!
    var tweets: [TWTRTweet] = []
    var prototypeCell: TWTRTweetTableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "title"
        
        // 実際の画面について
        // UITableViewを作成してdelegateとdataSourceを自分に
        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        // tableで使用するcellのクラスを指定
        prototypeCell = TWTRTweetTableViewCell(style: .Default, reuseIdentifier: "cell")
        tableView.registerClass(TWTRTweetTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        // ナビゲーションバーに置くボタン
        let tweetBtn:UIButton = UIButton(type: .Custom)
        tweetBtn.addTarget(self, action: "onClickTweet", forControlEvents: UIControlEvents.TouchUpInside)
        tweetBtn.frame = CGRectMake(0, 0, 24, 24)
        tweetBtn.setImage(UIImage(), forState: .Normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tweetBtn)
        
        self.load()
    }
    
    // for override、これを各クラスでオーバーロードするということ
    func load() {
    }
    
    // Tweetボタンが押されたら
    func onClickTweet() {
        let tweetViewCtrl = TweetViewController()
        let modalView = UINavigationController(rootViewController: tweetViewCtrl)
        modalView.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        self.presentViewController(modalView, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// UITableViewDataSourceを実装する
extension BaseTweetViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // cellをTWTRTweetTableViewCellにキャストする
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! TWTRTweetTableViewCell
        if tweets.count > indexPath.row {
            let tweet = tweets[indexPath.row]
            cell.tag = indexPath.row
            cell.configureWithTweet(tweet)
        }
        return cell
    }
}

// UITableViewDelegateを実装する
extension BaseTweetViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let tweet = tweets[indexPath.row]
        if tweets.count > indexPath.row {
            prototypeCell?.configureWithTweet(tweet)
        }
        // fabric 1.1以降は以下のクラスfuncでheightが取得できる
        return TWTRTweetTableViewCell.heightForTweet(tweet, width: self.view.bounds.width)
        // fabric 1.1より前のバージョンでは以下を使う
        //        if let height = prototypeCell?.calculatedHeightForWidth(self.view.bounds.width) {
        //            return height
        //        } else {
        //            return tableView.estimatedRowHeight
        //        }
    }
}
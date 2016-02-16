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
    var refreshControl: UIRefreshControl!
    // responseからmax_idを取り出すらしいけどやり方わからぬ
    var maxIdStr: String!

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
        
        // 引っ張ってロードするやつ
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "loading...")
        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        
        // ナビゲーションバーに置くボタン
        let tweetBtn:UIButton = UIButton(type: .Custom)
        tweetBtn.addTarget(self, action: "onClickTweet", forControlEvents: UIControlEvents.TouchUpInside)
        tweetBtn.frame = CGRectMake(0, 0, 24, 24)
        tweetBtn.setImage(UIImage(named: "tweet"), forState: .Normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tweetBtn)
        
        self.load({ ()->() in
            // なにもしない
            }, errcb: { () -> () in
                // なにもしない
        })
    }
    
    // for override、これを各クラスでオーバーロードするということ
    func load(cb: ()->(), errcb: ()->()) {
    }
    func loadMore(cb: ()->(), errcb: ()->()) {
    }
    
    // refresh処理
    func refresh() {
        self.tweets = []
        load({ () -> () in
            // API通信後のsuccess callbackでrefresh Controlのローディング
            self.refreshControl.endRefreshing()
            }, errcb: { () -> () in
            self.refreshControl.endRefreshing()
        })
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
            cell.tweetView.delegate = self
            let tweet = tweets[indexPath.row]
            cell.tag = indexPath.row
            // これでアクションボタン表示可能だけどデフォルトのアクションボタン結構扱いにくい
            cell.tweetView.showActionButtons = true
            cell.configureWithTweet(tweet)
            if (tweets.count - 1) == indexPath.row && self.maxIdStr != "" {
                self.loadMore({() -> () in }, errcb: {() -> () in })
            }
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
        // fabric 1.1以降は以下のクラスfuncでheightが取得できる(showingActionsオプションでActionボタンのあるなしかわる)
        return TWTRTweetTableViewCell.heightForTweet(tweet, width: self.view.bounds.width, showingActions: true)
        // fabric 1.1より前のバージョンでは以下を使う
        //        if let height = prototypeCell?.calculatedHeightForWidth(self.view.bounds.width) {
        //            return height
        //        } else {
        //            return tableView.estimatedRowHeight
        //        }
    }
}

// TWTRTweetViewDelegateを実装
extension BaseTweetViewController: TWTRTweetViewDelegate {
    // tap a cell
    func tweetView(tweetView: TWTRTweetView, didSelectTweet tweet: TWTRTweet) {
        var url: String = ""
        // URLTweetにcastしてurlをとりだす
        if let urlTweet = tweet as? URLTweet {
            url = urlTweet.url
        }
        if url == "" {
            return
        }
        self.openWebView(NSURL(string: url)!)
    }
    
    // tap a link in cell
    func tweetView(tweetView: TWTRTweetView, didTapURL url: NSURL) {
        self.openWebView(url)
    }
    
    func openWebView(url: NSURL) {
        let webviewController = StockWebViewController()
        webviewController.url = url
        // webviewController.hideBottomBarWhenPushed = true
        self.navigationController?.pushViewController(webviewController, animated: true)
    }
}
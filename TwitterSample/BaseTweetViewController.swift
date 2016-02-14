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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "title"
        
        let tweetBtn:UIButton = UIButton(type: .Custom)
        tweetBtn.addTarget(self, action: "onClickTweet", forControlEvents: UIControlEvents.TouchUpInside)
        tweetBtn.frame = CGRectMake(0, 0, 24, 24)
        tweetBtn.setImage(UIImage(), forState: .Normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tweetBtn)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

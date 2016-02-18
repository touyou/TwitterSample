//
//  TweetViewController.swift
//  TwitterSample
//
//  Created by 藤井陽介 on 2016/02/14.
//  Copyright © 2016年 touyou. All rights reserved.
//

import UIKit
import Foundation
import TwitterKit

class TweetViewController: UIViewController {

    @IBOutlet var tweetTextEdit: UITextView!
    @IBOutlet var tweetButton: UIButton!
    
    // ひとつだけストーリーボード実装しにくいから手書きで
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // タイトルのセットと背景色の指定
        // self.view.backgroundColor = UIColor.whiteColor()
        tweetTextEdit.text = ""
        
        tweetButton.layer.cornerRadius = 8
        
    }
    @IBAction func onClickClose() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func onClickTweet() {
        if tweetTextEdit.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 140 {
            simpleAlert("140字以内で書いてください")
            return
        }
        let params = ["statuses": tweetTextEdit.text!]
        TwitterAPI.postTweet(params, error: {error in })
        dismissViewControllerAnimated(true, completion: nil)
    }
    // 単純なアラートをつくる関数
    func simpleAlert(titleString: String) {
        let alertController = UIAlertController(title: titleString, message: nil, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
}

//
//  TweetViewController.swift
//  TwitterSample
//
//  Created by 藤井陽介 on 2016/02/14.
//  Copyright © 2016年 touyou. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    var toolBar: UIToolbar = UIToolbar()
    var backButton: UIBarButtonItem!
    var tweetTextEdit: UITextField!
    var toolBarHeight: CGFloat = 50.0
    
    // ひとつだけストーリーボード実装しにくいから手書きで
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let selfFrame: CGRect = self.view.frame
        self.toolBar.frame = CGRect(x: 0, y: selfFrame.size.height - toolBarHeight, width: selfFrame.size.width, height: toolBarHeight)
        self.toolBar.backgroundColor = Constants.Theme.concept()
        self.toolBar.tintColor = Constants.Theme.concept()
        self.view.addSubview(self.toolBar)
    }
    // TO-DO: テキストフィールドとツイートボタンとTweetViewをおわらせるボタンの配置
}

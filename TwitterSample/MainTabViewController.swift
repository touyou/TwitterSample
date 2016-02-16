//
//  MainTabViewController.swift
//  TwitterSample
//
//  Created by 藤井陽介 on 2016/02/14.
//  Copyright © 2016年 touyou. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    var timelineView: TimelineViewController!
    var replyView: ReplyViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        timelineView = TimelineViewController()
        replyView = ReplyViewController()
        timelineView.tabBarItem = UITabBarItem(title: "タイムライン", image: UIImage(named: "timeline"), selectedImage: UIImage(named: "timeline"))
        replyView.tabBarItem = UITabBarItem(title: "リプライ", image: UIImage(named: "reply"), selectedImage: UIImage(named: "reply"))
        
        let timelineNavigationController = UINavigationController(rootViewController: timelineView)
        let replyNavigationController = UINavigationController(rootViewController: replyView)
        self.setViewControllers([timelineNavigationController, replyNavigationController], animated: false)
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

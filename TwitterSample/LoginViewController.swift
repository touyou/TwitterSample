//
//  LoginViewController.swift
//  TwitterSample
//
//  Created by 藤井陽介 on 2016/02/13.
//  Copyright © 2016年 touyou. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let loginButton = TWTRLogInButton(logInCompletion: {
            session, error in
            if session != nil {
                print(session!.userName)
                let timelineVC = TimelineViewController()
                UIApplication.sharedApplication().keyWindow?.rootViewController = timelineVC
            } else {
                print(error!.localizedDescription)
            }
        })
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
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

//
//  AppDelegate.swift
//  TwitterSample
//
//  Created by 藤井陽介 on 2016/02/13.
//  Copyright © 2016年 touyou. All rights reserved.
//

import UIKit
import Fabric
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Fabric.with([Twitter.self])
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // すでにログインしていたらそのまま、していなかったらログインへ
        if let _ = Twitter.sharedInstance().session()?.userName {
            self.window?.rootViewController = MainTabViewController()
        } else {
            self.window?.rootViewController = LoginViewController()
        }
        self.window?.backgroundColor = UIColor.whiteColor()
        self.window?.makeKeyAndVisible()
        // 以下、色指定
        // ナビゲーションバーの色
        UINavigationBar.appearance().barTintColor = Constants.Theme.concept()
        // ナビゲーションバーボタンのベースの色（設定アイコンの色など）
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        // ナビゲーションバーのタイトル文字色
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        // ナビゲーションバーの背景色
        UINavigationBar.appearance().backgroundColor = UIColor.whiteColor()
        // TabBarItemのアイコンの色
        UITabBar.appearance().tintColor = Constants.Theme.concept()
        // 画面上部のキャリアなどが表示されるステータスバーの文字色
        // info.plistで”View controller-based status bar”をNOにセットする必要あり
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


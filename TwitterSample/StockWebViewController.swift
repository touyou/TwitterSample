//
//  StockWebViewController.swift
//  TwitterSample
//
//  Created by 藤井陽介 on 2016/02/16.
//  Copyright © 2016年 touyou. All rights reserved.
//

import UIKit
import Foundation

class StockWebViewController: UIViewController, UIWebViewDelegate, UIActionSheetDelegate {
    var webView: UIWebView = UIWebView()
    var toolBar: UIToolbar = UIToolbar()
    var backButton: UIBarButtonItem!
    var forwardButton: UIBarButtonItem!
    var refreshButton: UIBarButtonItem!
    var safariButton: UIBarButtonItem!
    var url : NSURL?
    let toolBarHeight: CGFloat = 50.0
    
    init() {
        super.init(nibName: nil, bundle: nil)
        let selfFrame: CGRect = self.view.frame
        self.webView.frame = CGRect(x: 0, y: 0, width: selfFrame.size.width, height: selfFrame.size.height-toolBarHeight)
        self.webView.delegate = self
        self.view.addSubview(self.webView)
        self.toolBar.frame = CGRect(x: 0, y: selfFrame.size.height - toolBarHeight, width: selfFrame.size.width, height: toolBarHeight)
        self.toolBar.backgroundColor = Constants.Theme.concept()
        self.toolBar.tintColor = Constants.Theme.concept()
        self.view.addSubview(self.toolBar)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let spacer: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        self.backButton = UIBarButtonItem(image: UIImage(named: "toolbar_back"), style: .Plain, target: self, action: Selector("back"))
        self.forwardButton = UIBarButtonItem(image: UIImage(named: "toolbar_forward"), style: .Plain, target: self, action: Selector("forward"))
        self.refreshButton = UIBarButtonItem(image: UIImage(named: "toolbar_reload"), style: .Plain, target: self, action: Selector("reload"))
        self.safariButton = UIBarButtonItem(image: UIImage(named: "toolbar_external"), style: .Plain, target: self, action: Selector("safari"))
        let items: NSArray = [spacer, self.backButton, spacer, self.forwardButton, spacer, self.refreshButton, spacer, self.safariButton, spacer]
        self.toolBar.items = items as? [UIBarButtonItem]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButton.enabled = self.webView.canGoBack
        self.forwardButton.enabled = self.webView.canGoForward
        self.refreshButton.enabled = false
        self.safariButton.enabled = false
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // self.view.makeToastActivity()
        let requestURL: NSURLRequest = NSURLRequest(URL: self.url!)
        self.webView.loadRequest(requestURL)
    }
    
    func back() {
        self.webView.goBack()
        self.backButton.enabled = self.webView.canGoBack
        self.forwardButton.enabled = self.webView.canGoForward
    }
    
    func forward() {
        self.webView.goForward()
        self.backButton.enabled = self.webView.canGoBack
        self.forwardButton.enabled = self.webView.canGoForward
    }
    
    func reload() {
        // self.view.makeToastActivity()
        self.webView.reload()
    }
}

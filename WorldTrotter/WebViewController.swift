//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Adminaccount on 10/27/17.
//  Copyright © 2017 Steve Harski. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
        let myURL = URL(string: "https://www.bignerdranch.com/")!
        webView.load(URLRequest(url: myURL))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    
}

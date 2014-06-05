//
//  FeedEntryDetailViewController.swift
//  SwiftReeder
//
//  Created by Thilong on 14/6/5.
//  Copyright (c) 2014年 thilong. All rights reserved.
//

import Foundation
import UIKit

class FeedEntryDetailViewController : UIViewController{
    
    var webView : UIWebView!
    var request : NSURLRequest! ;
    
    init (_ request : NSURLRequest!){
        super.init(nibName:nil,bundle:nil);
        self.request = request;
        self.webView = UIWebView()
    }
    
    override func viewDidLoad(){
        super.viewDidLoad();
        webView.frame = self.view.bounds;
        self.view.addSubview(webView);
        webView.backgroundColor=UIColor.whiteColor();
        webView.loadRequest(request);
    }
    
}
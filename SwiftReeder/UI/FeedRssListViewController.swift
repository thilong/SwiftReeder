//
//  FeedRssListViewController.swift
//  SwiftReeder
//
//  Created by Thilong on 14/6/5.
//  Copyright (c) 2014年 thilong. All rights reserved.
//

import Foundation
import UIKit


class FeedRssListViewController : UIViewController,RemoteDataLoaderDelegate,UIWebViewDelegate
{
    var remoteDataLoader : RemoteDataLoader? ;
    var loadingMask : UIAlertView? ;
    var webView : UIWebView!
    var feed : Feed?
    init (_ feed : Feed){
        super.init(nibName:nil,bundle:nil);
        self.feed = feed;
        self.webView = UIWebView()
    }
    
    override func viewDidLoad(){
        super.viewDidLoad();
        self.title = feed!.name;
        
        webView.frame = self.view.bounds;
        webView.delegate = self;
        self.view.addSubview(webView);
        webView.backgroundColor=UIColor.whiteColor();
        
        remoteDataLoader = RemoteDataLoader();
        remoteDataLoader!.delegate = self;
        remoteDataLoader!.urlString = feed!.url;
        remoteDataLoader!.start();
        loadingMask = OCBridge.createHUDMsg("正在加载数据...") as? UIAlertView;
        loadingMask!.show();
        
    }
    
    func dataLoadFailed(loader : RemoteDataLoader){
        loadingMask!.dismissWithClickedButtonIndex(0,animated: true);
        
        OCBridge.messageBox("出错了",msg:("没有加载到数据,请确认RUL地址正确,网络通畅,当前Rss地址 : " + feed!.url!));
    }
    
    func dataLoadFinised(loader : RemoteDataLoader, data : NSMutableData!){
        loadingMask!.dismissWithClickedButtonIndex(0,animated: true);
        
        var _data : NSData = data as NSData;
        var doc : GDataXMLDocument! = GDataXMLDocument(data: _data,options:0,error:nil);
        if !doc{
            OCBridge.messageBox("出错了",msg:("读取Feed列表失败!"));
            return;
        }
        var rootElement : GDataXMLElement! = doc.rootElement();
        var titleNode : GDataXMLElement! = rootElement.nodeForXPath("/rss/channel/title",error: nil);
        var linkNode : GDataXMLElement! = rootElement.nodeForXPath("/rss/channel/link",error: nil);
        var channelNode : GDataXMLElement! = rootElement.nodeForXPath("/rss/channel",error: nil);
        var items : NSArray! = doc.nodesForXPath("/rss/channel/item",error:nil);
        var entrysBuilder : NSMutableString = NSMutableString();
        var baseHTMLPath : NSString = NSBundle.mainBundle().pathForResource("FeedEntryList",ofType: "html");
        var finalHTML : NSString = NSString.stringWithContentsOfFile(baseHTMLPath,encoding: NSUTF8StringEncoding,error: nil);
        for (var i=0;i<items.count;i++){
            var item : GDataXMLElement = items.objectAtIndex(i) as GDataXMLElement;
            var itemTitleNode : GDataXMLElement = item.elementsForName("title")[0] as GDataXMLElement;
            var itemDescriptionNode : GDataXMLElement = item.elementsForName("description")[0] as GDataXMLElement;
            var itemUrlNode : GDataXMLElement = item.elementsForName("guid")[0] as GDataXMLElement;
            
            //http://3g.163.com/touch/article.html?docid=
            
            var entryBuilder : NSMutableString = NSMutableString();
            entryBuilder.appendString("<a href='");
            //link here
            var urlString : NSString! = itemUrlNode.stringValue();
            var stringS = urlString.componentsSeparatedByString("/");
            var finalString : NSString? = stringS[stringS.count-1] as? NSString;
            if finalString && finalString!.hasSuffix(".html"){
                urlString = NSString(string:"http://3g.163.com/touch/article.html?docid=");
                var docid : NSString = NSString(string:finalString!.stringByReplacingOccurrencesOfString(".html",withString:""));
                urlString = urlString.stringByAppendingFormat("%@",docid);
            }
            
            
            entryBuilder.appendString(urlString);
            entryBuilder.appendString("'><div class='entry'><div class='entryTitle'>");
            //title here
            entryBuilder.appendString(itemTitleNode.stringValue());
            entryBuilder.appendString("</div><div class='entryDescription'>");
            //description here
            var description : NSString = itemDescriptionNode.stringValue();
            entryBuilder.appendString(description);
            entryBuilder.appendString("</div></div></a>");
            
            entrysBuilder.appendString(entryBuilder);
        }
        finalHTML = finalHTML.stringByReplacingOccurrencesOfString("[[ENTRYLIST]]",withString: entrysBuilder);
        webView.loadHTMLString(finalHTML,baseURL: nil);
    }
    
    func webView(webView: UIWebView!, shouldStartLoadWithRequest request: NSURLRequest!, navigationType: UIWebViewNavigationType) -> Bool{
        var url :NSURL = request.URL;
        var path : String! = url.absoluteString;
        if path.hasPrefix("http") {
            var vc = FeedEntryDetailViewController(request);
            self.navigationController.pushViewController(vc,animated: true);
            return false;
        }
        return true;
    }
    
}
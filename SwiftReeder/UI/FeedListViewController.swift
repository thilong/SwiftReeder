//
//  FeedList.swift
//  SwiftReeder
//
//  Created by Thilong on 14/6/4.
//  Copyright (c) 2014年 thilong. All rights reserved.
//

import Foundation
import UIKit

class FeedListViewController : UIViewController , UITableViewDataSource, UITableViewDelegate 
{
    
    var tableView : UITableView? ;
    
    
    override func viewDidLoad(){
        self.title="网易Rss"
        var addButton : UIButton = UIButton()
        addButton.frame = CGRect(x: 0,y: 0,width: 50,height: 40);
        
        addButton.setTitle("添加",forState: UIControlState.Normal)
        addButton.titleLabel.font = UIFont.systemFontOfSize(12);
        addButton.setTitleColor( UIColor.blackColor(),forState: UIControlState.Normal);
        addButton.addTarget(self,action: "addButtonTapped:",forControlEvents: UIControlEvents.TouchUpInside)
        var addButtonItem = UIBarButtonItem(customView : addButton);
        super.navigationItem.rightBarButtonItem = addButtonItem;
        
        
        
        var aboutButton : UIButton = UIButton()
        aboutButton.frame = CGRect(x: 0,y: 0,width: 50,height: 40);
        
        aboutButton.setTitle("关于",forState: UIControlState.Normal)
        aboutButton.titleLabel.font = UIFont.systemFontOfSize(12);
        aboutButton.setTitleColor( UIColor.blackColor(),forState: UIControlState.Normal);
        aboutButton.addTarget(self,action: "aboutButtonTapped:",forControlEvents: UIControlEvents.TouchUpInside)
        var aboutButtonItem = UIBarButtonItem(customView : aboutButton);
        super.navigationItem.leftBarButtonItem = aboutButtonItem;
        
        
        var tableFrame : CGRect = self.view.bounds;
        self.tableView = UITableView(frame:tableFrame);
        self.tableView!.dataSource = self;
        self.tableView!.delegate = self;
        self.view.addSubview(tableView);
    }
      
    
    override func viewWillAppear(animated: Bool){
        self.tableView!.reloadData();
    }
    
    func aboutButtonTapped(sender : AnyObject){
        OCBridge.messageBox("关于",msg: "Swift语言Demo程序,请不要用于商业用途. By thilong.")
    }
    
    func addButtonTapped( sender : AnyObject){
        var defaultFeedList : DefaultFeedListViewController = DefaultFeedListViewController()
        self.navigationController.pushViewController(defaultFeedList,animated: true);
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return FeedManager.sharedManager().feedsCount();
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        
        var data : Feed = FeedManager.sharedManager().feedAtIndex(indexPath.row);
        
        let cellReuseId = "cell_FeedListCell" ;
        var cell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellReuseId) as? UITableViewCell;
        if !cell{
            cell = UITableViewCell(style: UITableViewCellStyle.Default,reuseIdentifier: cellReuseId);
            cell.selectionStyle = UITableViewCellSelectionStyle.None;
        }
        cell.textLabel.text = data.name?;
        return cell;
    }
    
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        var data : Feed = FeedManager.sharedManager().feedAtIndex(indexPath.row);
        var vc : FeedRssListViewController = FeedRssListViewController(data);
        self.navigationController.pushViewController(vc,animated:true);
    }
}
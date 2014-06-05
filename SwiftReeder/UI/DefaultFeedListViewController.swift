//
//  DefaultFeedListViewController.swift
//  SwiftReeder
//
//  Created by Thilong on 14/6/4.
//  Copyright (c) 2014年 thilong. All rights reserved.
//

import UIKit



class DefaultFeedListViewController: UIViewController , UITableViewDataSource,UITableViewDelegate {
    var tableView : UITableView? ;
    var defaultData : Array<Feed> = [Feed(name:"网易新闻",url:"http://news.163.com/special/00011K6L/rss_newstop.xml"),
                                     Feed(name:"网易科技",url:"http://tech.163.com/special/000944OI/headlines.xml"),
        Feed(name:"网易NBA",url:"http://sports.163.com/special/00051K7F/rss_sportslq.xml"),
        Feed(name:"网易英超",url:"http://sports.163.com/special/00051K7F/rss_sportsyc.xml"),
        Feed(name:"网易娱乐",url:"http://ent.163.com/special/00031K7Q/rss_toutiao.xml"),
        Feed(name:"网易电影",url:"http://ent.163.com/special/00031K7Q/rss_entmovie.xml"),
        Feed(name:"网易互联网",url:"http://tech.163.com/special/000944OI/hulianwang.xml"),
        Feed(name:"网易IT界",url:"http://tech.163.com/special/000944OI/kejiyejie.xml"),
        Feed(name:"网易汽车",url:"http://auto.163.com/special/00081K7D/rsstoutiao.xml"),
        Feed(name:"网易数码",url:"http://tech.163.com/digi/special/00161K7K/rss_digixj.xml"),
        Feed(name:"网易笔记本",url:"http://tech.163.com/digi/special/00161K7K/rss_diginote.xml"),
        Feed(name:"网易手机",url:"http://mobile.163.com/special/001144R8/mobile163_copy.xml"),
        Feed(name:"网易时尚",url:"http://lady.163.com/special/00261R8C/ladyrss1.xml"),
        Feed(name:"网易星运",url:"http://lady.163.com/special/00261R8C/ladyrss4.xml"),
        Feed(name:"网易游戏",url:"http://game.163.com/special/003144N4/rss_gametop.xml"),
        Feed(name:"网易旅游",url:"http://travel.163.com/special/00061K7R/rss_hline.xml")];
    override func viewDidLoad(){
        self.title = "Feeds";
        self.view.backgroundColor = UIColor.whiteColor();
        
        var tableFrame : CGRect = self.view.bounds;
        self.tableView = UITableView(frame:tableFrame);
        self.view.addSubview(tableView);
        tableView!.dataSource = (self as? UITableViewDataSource);
        tableView!.delegate = self;
    }
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return defaultData.count;
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        let cellReuseId = "cell_DefaultFeedListCell" ;
        var cell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellReuseId) as? UITableViewCell;
        if !cell{
            cell = UITableViewCell(style: UITableViewCellStyle.Default,reuseIdentifier: cellReuseId);
            cell.selectionStyle = UITableViewCellSelectionStyle.None;
        }
        cell.textLabel.text = defaultData[indexPath.row].name?;
        return cell;
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        var data = defaultData[indexPath.row];
        FeedManager.sharedManager().addFeed(data);
        self.navigationController.popViewControllerAnimated(true);
    }
    
}

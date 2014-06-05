//
//  FeedManager.swift
//  SwiftReeder
//
//  Created by Thilong on 14/6/5.
//  Copyright (c) 2014年 thilong. All rights reserved.
//

import Foundation


var global_FeedManager : FeedManager!

class FeedManager{
    var _data : NSMutableArray = NSMutableArray()
    
    class func sharedManager()->FeedManager!{
        if !global_FeedManager{
            global_FeedManager = FeedManager()
        }
        return global_FeedManager;
    }
    
    init(){
        
    }
    
    func addFeed(feed : Feed){
        for fe : AnyObject in self._data
        {
            if fe.name  == feed.name{
                return;
            }
        }
        
        self._data.addObject(feed);
        self.saveAllFeeds();
    }
    
    func removeFeedAtIndex(index : Int){
        self._data.removeObjectAtIndex(index);
        self.saveAllFeeds();
    }
    
    func feedsCount()->Int{
        return self._data.count;
    }
    
    func feedAtIndex(index : Int)->Feed!{
        return self._data.objectAtIndex(index) as Feed;
    }
    
    
    func saveAllFeeds(){
        var path : String! = OCBridge.feedCachePath(false);
        if path{
            NSFileManager.defaultManager().removeItemAtPath(path,error:nil);
        }
        NSKeyedArchiver.archiveRootObject(_data,toFile: path);
    }
    
    func loadAllFeeds(){
        var path : String! = OCBridge.feedCachePath(true);
        if path{
            var arrays = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as NSArray;
            _data.addObjectsFromArray(arrays);
        }
    }
}
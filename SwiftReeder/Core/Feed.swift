//
//  Feed.swift
//  SwiftReeder
//
//  Created by Thilong on 14/6/4.
//  Copyright (c) 2014年 thilong. All rights reserved.
//

import Foundation

class Feed : NSObject,NSCoding {
    
    var name : String?;
    var url : String?;
    
    init(name:String?,url:String?){
        self.name = name;
        self.url = url;
    }
    
    func encodeWithCoder(aCoder: NSCoder!)
    {
        aCoder.encodeObject(name,forKey:"name");
        aCoder.encodeObject(url,forKey:"url");
    }
    
    init(coder aDecoder: NSCoder!){
        self.name = aDecoder.decodeObjectForKey("name") as? String;
        self.url = aDecoder.decodeObjectForKey("url") as? String;
    }
}
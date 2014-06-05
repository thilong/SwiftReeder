//
//  RemoteDataLoader.swift
//  SwiftReeder
//
//  Created by Thilong on 14/6/5.
//  Copyright (c) 2014年 thilong. All rights reserved.
//

import Foundation

@objc protocol RemoteDataLoaderDelegate{
    @optional func dataLoadFailed(loader : RemoteDataLoader)
    @optional func dataLoadFinised(loader : RemoteDataLoader, data : NSMutableData!)
}

class RemoteDataLoader :NSObject, NSURLConnectionDelegate{
    
    var delegate : RemoteDataLoaderDelegate?
    
    var urlString : String? ;
    var connection : NSURLConnection? ;
    var _data : NSMutableData? ;
    
    init(){
        super.init();
        _data = NSMutableData();
    }
    
    func start(){
        self.cancel()
        _data!.resetBytesInRange(NSRange(location: 0,length: _data!.length));
        _data!.length = 0;
        if !urlString{ return; }
        var url = NSURL(string:urlString);
        var request = NSURLRequest(URL : url);
        connection = NSURLConnection(request: request,delegate: self,startImmediately: false);
        connection!.start();
    }
    
    func cancel(){
        if(connection){
            connection!.cancel();
            connection = nil;
        }
    }
    
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!){
        _data!.resetBytesInRange(NSRange(location: 0,length: _data!.length));
        _data!.length = 0;
        delegate?.dataLoadFailed!(self);
    }

    func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!){
        
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        _data!.appendData(data);
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!){
        delegate?.dataLoadFinised!(self, data: _data!);
        _data!.resetBytesInRange(NSRange(location: 0,length: _data!.length));
        _data!.length = 0;
    }
}

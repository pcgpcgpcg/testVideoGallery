//
//  RecordVideoInfo.swift
//  testVideoGallery
//
//  Created by mac on 2023/6/6.
//

import Foundation
import SwiftyJSON

struct RecordVideoInfoListResult {
    var recordVideoInfoList:[RecordVideoInfo]
    var size:Int = 10 //每页条数
    var total:Int = 0
    var current:Int = 0 //当前页面
    var pages:Int = 0 //总页数
}

struct RecordVideoInfo {
    let id:Int?
    let userId: String?
    let roomId: String?
    let conferenceNo : String?
    
    let startTime : String?
    let endTime : String?
    let status : Int?
    let filePath : String?
    let fileName : String?
    let fileSize : Int?
    let fileCount : Int?
    let title : String?
    let enterpriseId : String?

    init(_ jsonData: JSON){
        id = jsonData["id"].intValue
        userId = jsonData["userId"].string
        roomId = jsonData["roomId"].string
        conferenceNo = jsonData["conferenceNo"].string
        startTime = jsonData["startTime"].string
        endTime = jsonData["endTime"].string
        status = jsonData["status"].intValue
        
        filePath = jsonData["filePath"].string
        fileName = jsonData["fileName"].string
        fileSize = jsonData["fileSize"].intValue
        fileCount = jsonData["fileCount"].intValue
        title = jsonData["title"].string
        enterpriseId = jsonData["enterpriseId"].string
        
    }
    
    public func getVideoUrl()->String? {
        guard let filePath=filePath else{
            return nil
        }
        guard let fileName=fileName else{
            return nil
        }
        return filePath+fileName;
    }
    
    public func getVideoThumbnailUrl()->String? {
        // TODO: should replace mp4 by jpg
        guard let filePath=filePath else{
            return nil
        }
        guard let fileName=fileName else{
            return nil
        }
        return filePath+fileName;
        
    }
    
    public func getVideoStartTime()->String?{
        return startTime;
    }
}

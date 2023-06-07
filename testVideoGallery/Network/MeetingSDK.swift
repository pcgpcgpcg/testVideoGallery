//
//  MeetingSDK.swift
//  testVideoGallery
//
//  Created by pcg on 2023/6/7.
//

import Foundation
import Alamofire
import Hydra
import SwiftyJSON

public enum MeetingJsonError: Error {
    case encode
    case decode
    case tokenExpired(String)
    case getAdminTokenFailed(String)
    case getAppVersionInfoFailed(String)
    case getInProgerssMeeting(String)
    case getSMSVerifiedFailed(String)
    case checkPhoneNumRegisteredFailed(String)
    case registerFailed(String)
    case resetPasswordFailed(String)
    case loginFailed(String) //tuple for check the code
    case reserveMeetingFailed(String)
    case modifyMeetingFailed(String)
    case getMeetingListFailed(String)
    case forceEndMeetingFailed(String)
    case cancelMeetingFailed(String)
    case sendConferenceControlFailed(String)
    case sendImMsgFailed(String)
    case modifyUserNameFailed(String)
    case pingFailed(String)
    case getImHistoryMessagesFailed(String)
    case getUserInfoFailed(String)
    case getMeetingInfoFailed(String)
}

public class MeetingSDK : NSObject {
    
    //单例实现
    private static let sharedMeetingSDK: MeetingSDK = {
        let shared = MeetingSDK()
        return shared
    }()
    
    // Accessors
    class func sharedInstance() -> MeetingSDK {
        return sharedMeetingSDK
    }
    
    func getRecordVideoInfo() ->Promise<RecordVideoInfoListResult> {
        var headers: HTTPHeaders = [
            "Authorization": ""
        ]
        
        return Promise<RecordVideoInfoListResult>({ resolve, reject, _ in
            AF.request(Environment.default.httpServerUrl+"/recmgr/listnoauth",headers: headers).responseJSON { response in
                
                        switch response.result {
                            case .success(let value):
                                let json = JSON(value)
                                print("[MeetingSDK] getRecordVideoList ret \(json)")
                                let code = json["code"].intValue
                                
                                if(code == 200){
                                    //let recordVideoList = AppVersionInfo.init(json["data"])
                                    var videoInfoList:[RecordVideoInfo] = []
                                    for (_, subJson):(String,JSON) in json["data"]["records"] {
                                        let videoInfo = RecordVideoInfo.init(subJson)
                                        videoInfoList.append(videoInfo)
                                    }
                                    
                                    let recordVideoInfoListResult = RecordVideoInfoListResult.init(
                                        recordVideoInfoList: videoInfoList,
                                        size: json["data"]["size"].intValue,//每页条数
                                        total:  json["data"]["total"].intValue,// 会议链接, //TODO 这是什么
                                        current: json["data"]["current"].intValue, //当前页面
                                        pages: json["data"]["pages"].intValue //总页数
                                    )
                                    
                                    resolve(recordVideoInfoListResult)
                                }else{
                                    reject(MeetingJsonError.getMeetingInfoFailed("没拿到"))
                                }
                            case .failure(let error):
                                print(error)
                                reject(error)
                        }
                }
            
        })
    }
    
    
}

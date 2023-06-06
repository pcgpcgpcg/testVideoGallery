//
//  RecordVideoInfo.swift
//  testVideoGallery
//
//  Created by mac on 2023/6/6.
//

import Foundation

struct RecordVideoInfo {
    var videoUrl: String
    var videoName: String
    var videoTime: String

    init(videoName: String, videoUrl: String, videoTime: String) {
        self.videoName = videoName
        self.videoUrl = videoUrl
        self.videoTime = videoTime
    }
}

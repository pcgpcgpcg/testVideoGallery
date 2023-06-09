//
//  Environment.swift
//  testVideoGallery
//
//  Created by pcg on 2023/6/7.
//

import Foundation
struct Environment {
    var httpServerUrl: String = "http://192.168.31.90:8200"
    
    static var `default`: Environment = {
        var env = Environment()
        return env
    }()
}

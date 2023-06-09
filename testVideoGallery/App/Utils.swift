//
//  Utils.swift
//  testVideoGallery
//
//  Created by mac on 2023/6/7.
//

import Foundation

public func replaceSuffix(originalString: String, originalSuffix: String, replaceSuffix: String) -> String {
    var modifiedString = originalString
    modifiedString = modifiedString.replacingOccurrences(of: originalSuffix, with: replaceSuffix)
    return modifiedString
}

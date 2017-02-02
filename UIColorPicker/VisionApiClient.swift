//
//  VisionApiClient.swift
//  UIColorPicker
//
//  Created by Naoya Muto on 2017/02/03.
//  Copyright © 2017年 Naoya Muto. All rights reserved.
//

import Foundation

class VisionApiClient {

    let googleAPIKey: String
    let url: URL

    init() {
        googleAPIKey = "XXXX"
        url = URL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(googleAPIKey)")!
    }
}

//
//  VisionApiClient.swift
//  UIColorPicker
//
//  Created by Naoya Muto on 2017/02/03.
//  Copyright © 2017年 Naoya Muto. All rights reserved.
//

import Foundation
import SwiftyJSON

class VisionApiClient {

    let googleAPIKey: String
    let url: URL
    let session = URLSession.shared

    init() {
        googleAPIKey = "XXXX"
        url = URL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(googleAPIKey)")!
    }

    func createRequest(with imageBase64: String) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        
        // Build our API request
        let jsonRequest = [
            "requests": [
                "image": [
                    "content": imageBase64
                ],
                "features": [
                    [
                        "type": "LABEL_DETECTION",
                        "maxResults": 10
                    ],
                    [
                        "type": "FACE_DETECTION",
                        "maxResults": 10
                    ]
                ]
            ]
        ]
        let jsonObject = JSON(jsonDictionary: jsonRequest)
        
        // Serialize the JSON
        guard let data = try? jsonObject.rawData() else {
            return
        }
        
        request.httpBody = data
        
        // Run the request on a background thread
        DispatchQueue.global().async { self.runRequestOnBackgroundThread(request) }
    }

    func runRequestOnBackgroundThread(_ request: URLRequest) {
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            self.analyzeResults(data)
        }
        
        task.resume()
    }
    
    func analyzeResults(_ dataToParse: Data) -> JSON {
        // Use SwiftyJSON to parse results
        let json = JSON(data: dataToParse)
        let errorObj: JSON = json["error"]
        print(json)
        print(errorObj)
        let responses: JSON = json["responses"][0]
        let labelAnnotations: JSON = responses["labelAnnotations"]
        return labelAnnotations
    }
}

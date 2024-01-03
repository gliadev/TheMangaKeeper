//
//  URLRequest.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/12/23.
//

import Foundation

extension URLRequest {
   static func getCustom(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
       print(request.url!)
       request.setValue("application/json", forHTTPHeaderField: "Accept")
       request.httpMethod = "GET"
       request.timeoutInterval = 30
       return request
    }
}

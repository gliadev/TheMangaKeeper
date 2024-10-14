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
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        return request
    }
    
    
    static func getMoreMangas(url: URL, page: Int, per: Int = 29, contains: String? = nil) -> URLRequest {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        var queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "per", value: String(per))]
        
        if let contains = contains, !contains.isEmpty { queryItems.append(URLQueryItem(name: "search", value: contains))
        }
        components?.queryItems = queryItems
        guard let finalURL = components?.url else {
            fatalError("Unable to construct URL")
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        return request
    }
    
    
    static func getMangasContains(url: URL, contains: String, page: Int) -> URLRequest {
        var request = URLRequest(url: url.appending(path: contains))
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        return request
        
    }
    
    static func getMangaByGenre(url: URL, genre: Genre) -> URLRequest {
        var request = URLRequest(url: url.appending(path: String(genre.rawValue)))
        request.httpMethod = "GET"
        request.timeoutInterval = 40
        return request
    }
}



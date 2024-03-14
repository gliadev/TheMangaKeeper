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
        
        print("Cargando los datos desde la red")
        print("Cargando desde URL: \(url.absoluteString)")
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        return request
    }
    
    // creo una funcion aparte para hacer la llamada y traerme mas mangas
    static func getMoreMangas(url: URL, page: Int, per: Int = 25, contains: String? = nil) -> URLRequest {
        let page = URLQueryItem(name: "page", value: String(page))
        let per = URLQueryItem(name: "per", value: String(per))
        print("Cargando los datos desde la red")
        print("Cargando desde URL: \(url.absoluteString)")
        
        var request = URLRequest(url: url.appending(path: contains ?? ""))
        request.url?.append(queryItems: [page, per])
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        return request
    }
    
    //static func getBestMangas
    
    
    // para buscar por algo Patata
    static func getMangasContains(url: URL, contains: String, page: Int) -> URLRequest {
        var request = URLRequest(url: url.appending(path: contains))
        let page = URLQueryItem(name: "page", value: String(page))
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        return request
        
    }
    
    
    
}



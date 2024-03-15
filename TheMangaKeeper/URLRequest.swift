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
    //    static func getMoreMangas(url: URL, page: Int, per: Int = 25, contains: String? = nil) -> URLRequest {
    //        let page = URLQueryItem(name: "page", value: String(page))
    //        let per = URLQueryItem(name: "per", value: String(per))
    //        print("Cargando los datos desde la red")
    //        print("Cargando desde URL: \(url.absoluteString)")
    //
    //        var request = URLRequest(url: url.appending(path: contains ?? ""))
    //        request.url?.append(queryItems: [page, per])
    //        request.httpMethod = "GET"
    //        request.timeoutInterval = 30
    //        return request
    //    }
    
    // V2 revisar
    static func getMoreMangas(url: URL, page: Int, per: Int = 35, contains: String? = nil) -> URLRequest {
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
        print("Cargando los datos desde la red")
        print("Cargando desde URL: \(finalURL.absoluteString)")
        
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        return request
    }
    
    
    
    //static func getBestMangas
    
    
    // para buscar un manga por algo "patata"
    static func getMangasContains(url: URL, contains: String, page: Int) -> URLRequest {
        var request = URLRequest(url: url.appending(path: contains))
        print("Cargando Busqueda")
        print("Cargando desde la web de busqueda: \(url.absoluteString)")
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        return request
        
    }
    
    
    
}



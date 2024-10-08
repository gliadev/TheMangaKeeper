//
//  URL.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/12/23.
//

import Foundation

 

let mainURL = URL(string: "https://mymanga-acacademy-5607149ebe3d.herokuapp.com")!


extension URL {
   
    static let listaMangasURL = mainURL.appending(path: "list/mangas")
    
 
    static let BestMangas = mainURL.appending(path: "list/bestMangas")
    
    
    static let mangasSearchByContains = mainURL.appending(path: "search/mangasContains" )
    
    
    static let mangasSearchByGenre = mainURL.appending(path: "list/mangaByGenre")
}


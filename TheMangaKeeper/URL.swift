//
//  URL.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/12/23.
//

import Foundation

 
// CARGA DE LAS URL

// CARGA BASE
let mainURL = URL(string: "https://mymanga-acacademy-5607149ebe3d.herokuapp.com")!

// Devolverá 10 mangas por página, enviando la página 1.
extension URL {
    // para traerme una lista de mangas sin paguinar
    static let listaMangasURL = mainURL.appending(path: "list/mangas")
    
    // para traerme la lista de los mejores mangas
    static let BestMangas = mainURL.appending(path: "list/bestMangas")
    
// search endpoints
    // buscar un manga que contenga algo Patata Dragon
    static let mangasSearchByContains = mainURL.appending(path: "search/mangasContains" )
}



// list/mangas?page=2&per=20 Devolverá la página 2, de 20 en 20.
// list/mangas?page=1&per=50 Devolverá 50 mangas para la página 1.

//
//  MangasInteractor.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/12/23.
//

import Foundation

protocol MangasInteractorProtocol {
    var  docURL: URL { get }
    var  urlBundle : URL { get }
    func getMangas(page: Int) async throws -> [Manga]
    func loadMangasCollection() throws -> [Manga]
    func saveMangasCollection(mangas: [Manga]) throws
    
}  

extension MangasInteractorProtocol {
    
    func getMangas(page: Int) async throws -> [Manga] {
        try await getJSON(request: .getMoreMangas(url: .listaMangasURL, page: page), type: MangasDTO.self).items.map(\.toPresentation)
        
        //try await getJSON(request: .getCustom(url: .listaMangasURL), type: //MangasDTO.self).items.map(\.toPresentation)
    }
    
    // funcion para cargar los guardados en mi coleccion
    func loadMangasCollection() throws -> [Manga] {
        let url = docURL
        guard FileManager.default.fileExists(atPath: url.path) else {
            return []
        }
        let data = try Data(contentsOf: url)
        let mangas = try JSONDecoder().decode([Manga].self, from: data)
        return mangas
    }
    
    // funcion para guardar los que tenemos en la coleccion
    func saveMangasCollection(mangas: [Manga]) throws {
        let data = try JSONEncoder().encode(mangas)
        try data.write(to: docURL, options: .atomic)
    }
    
}

struct MangasInteractor: MangasInteractorProtocol {
    
    let urlBundle = Bundle.main.url(forResource: "TestLocalMangas", withExtension: "json")!
    
    let docURL = URL.documentsDirectory.appending(path: "mangasSaved.json")
    
}



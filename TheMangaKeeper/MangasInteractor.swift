//
//  MangasInteractor.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/12/23.
//

import Foundation

struct MangasInteractor: MangasInteractorProtocol {
    let urlBundle = Bundle.main.url(forResource: "TestLocalMangas", withExtension: "json")!
    let docURL = URL.documentsDirectory.appending(path: "mangasSaved.json")
    let docURLUserCollectionManagement = URL.documentsDirectory.appending(path: "userMangasColectionManagement.json")
}

protocol MangasInteractorProtocol {
    
    var  docURL: URL { get }
    var  urlBundle : URL { get }
    var  docURLUserCollectionManagement: URL { get }
    
    func getMangas(page: Int) async throws -> [Manga]
    func loadMangasCollection() throws -> [Manga]
    func saveMangasCollection(mangas: [Manga]) throws
    func searchMangasContains(page: Int, contains: String) async throws -> [Manga]
    func saveUserMangasVolumenCollection(mangas: [Manga]) throws
    func loadUserMangaVolumenCollection() throws -> [Manga]
    func searchMangaByGenre(genre: Genre) async throws -> [Manga] 
    
    
}

extension MangasInteractorProtocol {
    
    func getMangas(page: Int) async throws -> [Manga] {
        try await getJSON(request: .getMoreMangas(url: .listaMangasURL, page: page), type: MangasDTO.self).items.map(\.toPresentation)
    }
    
    
   
    func loadMangasCollection() throws -> [Manga] {
        let url = docURL
        guard FileManager.default.fileExists(atPath: url.path) else { return [] }
        let data = try Data(contentsOf: url)
        let mangas = try JSONDecoder().decode([Manga].self, from: data)
        return mangas
    }
    
   
    func saveMangasCollection(mangas: [Manga]) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(mangas)
        try data.write(to: docURL, options: .atomic)
    }
    
    
    func searchMangasContains(page: Int, contains: String) async throws -> [Manga] {
        try await getJSON(request: .getMangasContains(url: .mangasSearchByContains, contains: contains, page: page), type: MangasDTO.self).items.map(\.toPresentation)
    }
    
    
    func searchMangaByGenre(genre: Genre) async throws -> [Manga] {
        try await getJSON(request: .getMangaByGenre(url: .mangasSearchByGenre, genre: genre), type: MangasDTO.self).items.map(\.toPresentation)
    }
    
    
    func saveUserMangasVolumenCollection(mangas: [Manga]) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(mangas)
        print(docURLUserCollectionManagement)
        try data.write(to: docURLUserCollectionManagement, options: .atomic)
    }
    
   
    func loadUserMangaVolumenCollection() throws -> [Manga] {
        guard FileManager.default.fileExists(atPath: docURLUserCollectionManagement.path) else { return [] }
        let data = try Data(contentsOf: docURLUserCollectionManagement)
        return try JSONDecoder().decode([Manga].self, from: data)
    }
    
    
    
}

//
//  MangasInteractor.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/12/23.
//

import Foundation

protocol MangasInteractorProtocol {
    func getMangas() async throws -> [Manga]
    func loadMangasCollection() throws -> [Manga]
    func saveMangasCollection(mangas: [Manga]) throws
    
}

struct MangasInteractor: MangasInteractorProtocol {
    let docURL = URL.documentsDirectory.appending(path: "mangasSaved.json")
    
    func getMangas() async throws -> [Manga] {
        try await getJSON(request: .getCustom(url: .listaMangasURL), type: MangasDTO.self).items.map(\.toPresentation)
    }
    
    // funcion para cargar los guardaos en mi coleccion
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



// intentado hacer carga de datos locales para no estar llamando a al api
//struct MangasInteractor: MangasInteractorProtocol {
//    func getMangas() async throws -> [Manga] {
//        #if DEBUG
//        // Código para leer datos del archivo local
//        guard let path = Bundle.main.path(forResource: "TestLocalMangas", ofType: "json") else {
//            throw NetworkErrors.fileNotFound
//        }
//        let data = try Data(contentsOf: URL(fileURLWithPath: path))
//        let mangasDTO = try JSONDecoder().decode(MangasDTO.self, from: data)
//        return mangasDTO.items.map(\.toPresentation)
//        #else
//        // Código para realizar llamada a la API
//        try await getJSON(request: .getCustom(url: .listaMangasURL), type: MangasDTO.self).items.map(\.toPresentation)
//        #endif
//    }
//}

//
//  MangasInteractor.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/12/23.
//

import Foundation

protocol MangasInteractorProtocol {
    func getMangas() async throws -> [Manga]
}

struct MangasInteractor: MangasInteractorProtocol {
    func getMangas() async throws -> [Manga] {
        try await getJSON(request: .getCustom(url: .listaMangasURL), type: MangasDTO.self).items.map(\.toPresentation)
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

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

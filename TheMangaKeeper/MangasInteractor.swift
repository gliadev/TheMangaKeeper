//
//  MangasInteractor.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/12/23.
//

import Foundation

protocol MangasInteractorProtocol {
    func getMangasInteractor() async throws -> [Mangas]
}

struct MangasInteractor: MangasInteractorProtocol {
    func getMangasInteractor() async throws -> [Mangas] {
        try await getJSON(request: .getCustom(url: .listaMangasURL), type: MangasDTO.self).items.map(\.toPresentation)
    }
}

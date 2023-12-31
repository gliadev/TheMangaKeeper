//
//  TestData.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 20/12/23.
//

import Foundation

extension Manga {
    static let testManga = Manga(themes: [], endDate: Date.now, demographics: [], volumes: 6, genres: [], title: "Patata", sypnosis: "En el vibrante mundo de Vegetalia, Patatín, una patata valiente y curiosa, sueña con explorar más allá de su campo. Su vida da un giro inesperado cuando un misterioso visitante cae del cielo, revelando que Patatín no es una patata común, sino el elegido para salvar Vegetalia de la sombría amenaza de los Devoradores de Raíces", status: .currentlyPublishing, authors: [], titleEnglish: "The Patata", startDate: Date.now, score: 8.9, mainPicture: "https://cdn.myanimelist.net/images/manga/3/180031l.jpg", chapters: 4, id: 56, background: "Aventuras de Patatín. Ha sido publicada digitalmente en español por Vegetalia Comics desde el 22 de agosto de 2023, y en formato impreso desde el 15 de noviembre de 2023. La serie también ha sido publicada simultáneamente a través de la plataforma de manga en línea V Manga", url: "https://myanimelist.net/manga/3/20th_Century_Boys", titleJapanese: "ベジタリア", isFavorite: false)
}

struct testMangasLocal: MangasInteractorProtocol {
        let url = Bundle.main.url(forResource: "TestLocalMangas", withExtension: "json")!
        
        func getMangas() async throws -> [Manga] {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(MangasDTO.self, from: data).items.map(\.toPresentation)
        }
    }

extension MangasViewModel {
    static let localTestMangas = MangasViewModel(mangaInteractor: testMangasLocal())
}


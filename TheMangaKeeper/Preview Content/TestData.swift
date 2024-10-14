//
//  TestData.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 20/12/23.
//

import Foundation

struct testMangasLocal: MangasInteractorProtocol {
    let urlBundle = Bundle.main.url(forResource: "TestLocalMangas", withExtension: "json")!
    let docURL = URL.documentsDirectory.appending(path: "TestMangasSaved.json")
    let docURLUserCollectionManagement = URL.documentsDirectory.appending(path: "TestUserMangasColectionManagement.json")
    
    func getMangas(page: Int) async throws -> [Manga] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.dateFormatted)
        
        let data = try Data(contentsOf: urlBundle)
        return try decoder.decode(MangasDTO.self, from: data).items.map(\.toPresentation)
    }
    
    func searchMangasContains(page: Int, contains: String) async throws -> [Manga] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.dateFormatted)
        let data = try Data(contentsOf: urlBundle)
        return try decoder.decode(MangasDTO.self, from: data).items.map(\.toPresentation)
    }
    
    func searchMangaByGenre(genre: Genre) async throws -> [Manga] {
        try await getJSON(request: .getMangaByGenre(url: .mangasSearchByGenre, genre: genre), type: MangasDTO.self).items.map(\.toPresentation)
    }
    
    func saveUserMangasVolumenCollection(mangas: [Manga]) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(mangas)
        try data.write(to: docURLUserCollectionManagement, options: .atomic)
    }
    
    func loadUserMangaVolumenCollection() throws -> [Manga] {
        guard FileManager.default.fileExists(atPath: docURLUserCollectionManagement.path) else { return [] }
        let data = try Data(contentsOf: docURLUserCollectionManagement)
        return try JSONDecoder().decode([Manga].self, from: data)
    }
    
}

extension MangasViewModel {
    static let localTestMangas = MangasViewModel(mangaInteractor: testMangasLocal())
}


extension Manga {
    static let testManga = Manga(themes: [Theme(id: "ñlijghq", theme: .combatSports),
                                          Theme(id: "piripi", theme: .delinquents),
                                          Theme(id: "poropo", theme: .detective)],
                                 endDate: Date.now,
                                 demographics: [],
                                 volumes: 3,
                                 genres: [
                                    Genres(id: "4C13067F-96FF-4F14-A1C0-B33215F24E0B", genre: .awardWinning),
                                    Genres(id: "4312867C-1359-494A-AC46-BADFD2E1D4CD", genre: .drama),
                                    Genres(id: "97C8609D-856C-419E-A4ED-E13A5C292663", genre: .mystery)],
                                 title: "Patata",
                                 sypnosis: "En el vibrante mundo de Vegetalia, Patatín, una patata valiente y curiosa, sueña con explorar más allá de su campo. Su vida da un giro inesperado cuando un misterioso visitante cae del cielo, revelando que Patatín no es una patata común, sino el elegido para salvar Vegetalia de la sombría amenaza de los Devoradores de Raíces",
                                 status: .currentlyPublishing,
                                 authors: [Author(id: "54BE174C-2FE9-42C8-A842-85D291A6AEDD", lastName: "Urasawa", role: .storyArt, firstName: "Naoki")],
                                 titleEnglish: "The Patata",
                                 startDate: Date.now,
                                 score: 8.9,
                                 mainPicture: "https://cdn.myanimelist.net/images/manga/3/180031l.jpg",
                                 chapters: 4,
                                 id: 56,
                                 background: "Aventuras de Patatín. Ha sido publicada digitalmente en español por Vegetalia Comics desde el 22 de agosto de 2023, y en formato impreso desde el 15 de noviembre de 2023. La serie también ha sido publicada simultáneamente a través de la plataforma de manga en línea V Manga",
                                 url: "https://myanimelist.net/manga/3/20th_Century_Boys",
                                 titleJapanese: "ベジタリア",
                                 isFavorite: false, volumeStates: [Manga.VolumeState(id: 1, isPurchased: false, isBeingRead: false),
                                                                   Manga.VolumeState(id: 2, isPurchased: false, isBeingRead: false),
                                                                   Manga.VolumeState(id: 3, isPurchased: false, isBeingRead: false)],
                                 isCollectionComplete: false)
}

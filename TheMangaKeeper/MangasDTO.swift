//
//  MangasDTO.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 18/12/23.
//

import Foundation

struct MangasDTO: Codable {
    let items: [Items]
    let metadata: Metadata
}

struct Metadata: Codable {
    let total: Int
    let page: Int
    let per: Int
}


struct Items: Codable {
    let themes: [Theme]
    let endDate: Date?
    let demographics: [Demographic]
    let volumes: Int?
    let genres: [GenreDTO]
    let title: String
    let sypnosis: String?
    let status: Status
    let authors: [Author]
    let titleEnglish: String?
    let startDate: Date?
    let score: Double
    let mainPicture: String
    let chapters: Int?
    let id: Int
    let background: String?
    let url: String?
    let titleJapanese: String?
    
}


struct Author: Codable {
    let id, lastName: String
    let role: Role
    let firstName: String
}

enum Role: String, Codable {
    case art = "Art"
    case story = "Story"
    case storyArt = "Story & Art"
}


struct Demographic: Codable {
    let id, demographic: String
}

// hay que cambiar el nombre a genreDTO para que no de errores
struct GenreDTO: Codable, Hashable {
    let id: String
    let genre: Genre
}
enum Genre: String, Codable {
    var id: Self { self }
    case action = "Action"
    case adventure = "Adventure"
    case awardWinning = "Award Winning"
    case drama = "Drama"
    case fantasy = "Fantasy"
    case horror = "Horror"
    case supernatural = "Supernatural"
    case mystery = "Mystery"
    case sliceOfLife = "Slice of Life"
    case comedy = "Comedy"
    case sciFi = "Sci-Fi"
    case suspense = "Suspense"
    case sports = "Sports"
    case ecchi = "Ecchi"
    case romance = "Romance"
    case girlsLove = "Girls Love"
    case boysLove = "Boys Love"
    case gourmet = "Gourmet"
    case erotica = "Erotica"
    case hentai = "Hentai"
    case avantGarde = "Avant Garde"
}



enum Status: String, Codable {
    case currentlyPublishing = "currently_publishing"
    case finished = "finished"
    case onHiatus = "on_hiatus"
    case discontinued = "discontinued"
    
    // consultar
    var statusDescripcion: String {
        switch self {
        case .currentlyPublishing:
            return "Publicado"
        case .finished:
            return "Finalizado"
        case .onHiatus:
            return "Pausado"
        case .discontinued:
            return "interrumpido"
        }
    }
}


struct Theme: Codable {
    let id, theme: String
}








extension Items {
    var toPresentation: Manga {
        Manga(themes: themes, endDate: endDate, demographics: demographics, volumes: volumes, genres: genres, title: title, sypnosis: sypnosis, status: status, authors: authors, titleEnglish: titleEnglish, startDate: startDate, score: score, mainPicture: mainPicture, chapters: chapters, id: id, background: background, url: url, titleJapanese: titleJapanese, isFavorite: false)
    }
}

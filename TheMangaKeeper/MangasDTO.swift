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
    let genres: [Genres]
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


struct Genres: Codable, Hashable {
    let id: String
    let genre: Genre
}
enum Genre: String, Codable {
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


struct Theme: Codable, Hashable {
    let id: String
    let theme: themes
}

enum themes: String, Codable {
    case gore = "Gore"
    case military = "Military"
    case mythology = "Mythology"
    case psychological = "Psychological"
    case historical = "Historical"
    case samurai = "Samurai"
    case romanticSubtext = "Romantic Subtext"
    case school = "School"
    case adultCast = "Adult Cast"
    case parody = "Parody"
    case superPower = "Super Power"
    case teamSports = "Team Sports"
    case delinquents = "Delinquents"
    case workplace = "Workplace"
    case survival = "Survival"
    case childcare = "Childcare"
    case iyashikei = "Iyashikei"
    case reincarnation = "Reincarnation"
    case showbiz = "Showbiz"
    case anthropomorphic = "Anthropomorphic"
    case lovePolygon = "Love Polygon"
    case music = "Music"
    case mecha = "Mecha"
    case combatSports = "Combat Sports"
    case isekai = "Isekai"
    case gagHumor = "Gag Humor"
    case crossdressing = "Crossdressing"
    case reverseHarem = "Reverse Harem"
    case martialArts = "Martial Arts"
    case visualArts = "Visual Arts"
    case harem = "Harem"
    case otakuCulture = "Otaku Culture"
    case timeTravel = "Time Travel"
    case videoGame = "Video Game"
    case strategyGame = "Strategy Game"
    case vampire = "Vampire"
    case mahouShoujo = "Mahou Shoujo"
    case highStakesGame = "High Stakes Game"
    case cgdct = "CGDCT"
    case organizedCrime = "Organized Crime"
    case detective = "Detective"
    case performingArts = "Performing Arts"
    case medical = "Medical"
    case space = "Space"
    case memoir = "Memoir"
    case villainess = "Villainess"
    case racing = "Racing"
    case pets = "Pets"
    case magicalSexShift = "Magical Sex Shift"
    case educational = "Educational"
    case idolsFemale = "Idols (Female)"
    case idolsMale = "Idols (Male)"
}


extension Items {
    var toPresentation: Manga {
        Manga(themes: themes, endDate: endDate, demographics: demographics, volumes: volumes, genres: genres, title: title, sypnosis: sypnosis, status: status, authors: authors, titleEnglish: titleEnglish, startDate: startDate, score: score, mainPicture: mainPicture, chapters: chapters, id: id, background: background, url: url, titleJapanese: titleJapanese, isFavorite: false, volumeStates: [Manga.VolumeState(id: 1, isPurchased: false, isBeingRead: false),Manga.VolumeState(id: 1, isPurchased: false, isBeingRead: false)], isCollectionComplete: false)
    }
}


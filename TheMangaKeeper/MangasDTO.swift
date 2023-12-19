//
//  MangasDTO.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 18/12/23.
//

import Foundation

struct MangasDTO: Codable {
    let items: [Items]
}


struct Items: Codable {
    //let themes: [Theme]
    //let endDate: Date?
    //let demographics: [Demographic]
    //let volumes: Int?
    //let genres: [Genre]
    let title: String
    let sypnosis: String?
    //let status: Status
    //let authors: [Author]
    let titleEnglish: String?
    //let startDate: Date
    let score: Double
    //let mainPicture: String
    //let chapters: Int?
    let id: Int
    //let background: String?
    //let url, titleJapanese: String
}

extension Items {
    var toPresentation: Mangas {
        Mangas(id: id, title: title, titleEnglish: titleEnglish, sypnosis: sypnosis, score: score)
    }
}


//struct Welcome: Codable {
//    let items: [Item]
//    let metadata: Metadata
//}
//
//

//
//
//struct Author: Codable {
//    let id, lastName: String
//    let role: Role
//    let firstName: String
//}
//
//enum Role: String, Codable {
//    case art = "Art"
//    case story = "Story"
//    case storyArt = "Story & Art"
//}
//
//
//struct Demographic: Codable {
//    let id, demographic: String
//}
//
//
//struct Genre: Codable {
//    let genre, id: String
//}
//
//enum Status: String, Codable {
//    case currentlyPublishing = "currently_publishing"
//    case finished = "finished"
//}
//
//
//struct Theme: Codable {
//    let id, theme: String
//}
//
//
//struct Metadata: Codable {
//    let total, page, per: Int
//}


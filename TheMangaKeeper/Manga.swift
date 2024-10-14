//
//  Mangas.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 18/12/23.
//

import SwiftUI

struct Manga: Identifiable, Decodable, Encodable {
    
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
    var isFavorite: Bool
    var volumeStates: [VolumeState]
    var isCollectionComplete: Bool
    
    
   
    var mainPictureFormateada: String {
        mainPicture.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
    }
    
    
    
    var urlFormateada: String {
        return url?.replacingOccurrences(of: "\\", with: "") ?? ""
    }
    
    var scoreFormateado: Int {
        Int(score)
    }
    
    struct VolumeState: Identifiable, Codable {
        var id: Int
        var isPurchased: Bool
        var isBeingRead: Bool
    }
    
    
}



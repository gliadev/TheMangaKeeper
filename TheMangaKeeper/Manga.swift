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
    
    var volumensCompleted: Bool = false
   
    
    // otra solucion no estaba viendo que tambien tenia que eliminar las "" de la url de la foto
    var mainPictureFormateada: String {
        //let mainPicture1 = mainPicture.replacingOccurrences(of: "\\", with: "")
        mainPicture.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
    }
    
    
    // cuando la puesto me pedia un valor por defecto
    var urlFormateada: String {
        return url?.replacingOccurrences(of: "\\", with: "") ?? ""
    }
    
    var scoreFormateado: String {
        //Text("Puntuacion: \(manga.score, specifier: "%.2f")")
        String(Int(score))
    }
}



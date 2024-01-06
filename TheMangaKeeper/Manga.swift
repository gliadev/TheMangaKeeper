//
//  Mangas.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 18/12/23.
//

import SwiftUI
//cambiar nombre manga

struct Manga: Identifiable {
    
    let themes: [Theme]
    let endDate: Date?
    let demographics: [Demographic]
    let volumes: Int?
    let genres: [Genre]
    let title: String
    let sypnosis: String?
    let status: Status
    let authors: [Author]
    let titleEnglish: String?
    let startDate: Date
    let score: Double
    let mainPicture: String
    let chapters: Int?
    let id: Int
    let background: String?
    let url: String?
    let titleJapanese: String?
    

// para dar formato al mainPicture y eliminar el \ del principio
//    var mainPictureFormateada: String {
//        print(mainPicture)
//        return mainPicture.replacingOccurrences(of: "\\", with: "")
//    }
// Tenia hecha esta pero me di cuenta imprimiendo la url que me la traia asi " " y encontre
    //https://developer.apple.com/documentation/foundation/nsstring/1412937-replacingoccurrences
    //https://developer.apple.com/documentation/swift/stringprotocol/trimmingcharacters(in:)
    
    // otra solucion no estaba viendo que tambien tenia que eliminar las "" de la url de la foto
    var mainPictureFormateada: String {
        let mainPicture1 = mainPicture.replacingOccurrences(of: "\\", with: "")
        let mainPicture = mainPicture1.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
        return mainPicture
    }

    
    // para dar formato a la url como es una url opcional
    // cuando la puesto me pedia un valor por defecto
    var urlFormateada: String {
        return url?.replacingOccurrences(of: "\\", with: "") ?? ""
    }
}



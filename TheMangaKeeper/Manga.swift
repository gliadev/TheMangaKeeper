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
    
//    func obtenerURLLimpia() -> URL? {
//        guard let cadenaURL = self.url else { return nil }
//        let cadenaURLRecortada = cadenaURL.trimmingCharacters(in: .whitespacesAndNewlines)
//        let cadenaURLLimpia = cadenaURLRecortada.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
//        return URL(string: cadenaURLLimpia)
//    }
    // para dar formato al mainPicture y eliminar el \ del principio
    var mainPictureFormateada: String {
        return mainPicture.replacingOccurrences(of: "\\", with: "")
    }
    
    // para dar formato a la url como es una url opcional
    // cuando la puesto me pedia un valor por defecto
    var urlFormateada: String {
        return url?.replacingOccurrences(of: "\\", with: "") ?? ""
    }
}



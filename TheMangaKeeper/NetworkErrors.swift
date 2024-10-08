//
//  NetworkErrors.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/12/23.
//

import Foundation


enum NetworkErrors: Error, CustomStringConvertible {
    case noHTTP
    case parseJson(Error)
    case badStatusCode(Int)
    case general(Error)
    case fileNotFound
    
    
    var description: String {
        switch self {
        case .noHTTP:
            "Fallo en la llamada HTTP"
        case .parseJson(let error):
            "Fallo el parseo del json \(error.localizedDescription)"
        case .badStatusCode(let statusCode):
            "Error de status \(statusCode)"
        case .general(let error):
            "Error general \(error)"
        case .fileNotFound:
            "Error no encontrado archvivo de carga local"
    
        }
    }
}

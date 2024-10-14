//
//  JsonDecoder.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/12/23.
//

import Foundation

func getJSON<JSON: Codable>(request: URLRequest, type: JSON.Type) async throws -> JSON {
    let (data, response) = try await URLSession.shared.getMangas(request: request)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(.dateFormatted)
    if response.statusCode == 200 {
        do {
            return try decoder.decode(type .self, from: data)
        } catch {
            throw NetworkErrors.parseJson(error)
        }
    } else {
        throw NetworkErrors.badStatusCode(response.statusCode)
    }
}




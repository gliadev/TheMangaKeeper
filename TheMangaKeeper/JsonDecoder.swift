//
//  JsonDecoder.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/12/23.
//

import Foundation

func getJSON<JSON: Codable>(request: URLRequest, type: JSON.Type) async throws -> JSON {
    let (data, response) = try await URLSession.shared.getMangas(request: request)
    if response.statusCode == 200 {
        do {
            return try JSONDecoder().decode(type .self, from: data)
        } catch {
            throw NetworkErrors.parseJson(error)
        }
    } else {
        throw NetworkErrors.badStatusCode(response.statusCode)
    }
}

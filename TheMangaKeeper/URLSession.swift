//
//  URLSession.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/12/23.
//

import Foundation

extension URLSession {
    func getMangas(request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            //print(data)
            //print(response)
            guard let httpResponse = response as? HTTPURLResponse else { 
                throw NetworkErrors.noHTTP }
            //print("Cargando los datos desde la rede")
            return (data, httpResponse)
        } catch {
            throw NetworkErrors.general(error)
        }
    }
}

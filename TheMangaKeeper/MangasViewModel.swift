//
//  MangasViewModel.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/12/23.
//

import Foundation

final class MangasViewModel: ObservableObject {
    @Published var mangas: [Manga] = []
    
    let mangaInteractor: MangasInteractorProtocol
    
    init(mangaInteractor: MangasInteractorProtocol = MangasInteractor()) {
        self.mangaInteractor = mangaInteractor
        Task { await getMangas() }
    }
    
    
    func getMangas() async {
        do {
            print("Llamada de red")
            let manga = try await mangaInteractor.getMangas()
            await MainActor.run {
                mangas = manga
            }
        }
        catch {
            print("Este error: \(error)")
        }
    }
    // eliminar un manga
    func deleteManga(manga: Manga){
        mangas.removeAll(where: {$0.id == manga.id})
    }
    // añadir a manga
    func toogleMangaFavorite(manga: Manga){
        if let index = mangas.firstIndex(where: { $0.id == manga.id }) {
            mangas[index].isFavorite.toggle()
        }
    }
    
    
    
    
}

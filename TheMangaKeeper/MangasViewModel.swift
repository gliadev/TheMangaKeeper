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
        Task { await getMangas()
        await loadFavorites()}
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
    func toogleMangaFavorite(mangaID: Int){
        if let index = mangas.firstIndex(where: { $0.id == mangaID }) {
            mangas[index].isFavorite.toggle()
            saveFavorites()
        }
    }
    
    func saveFavorites() {
        do {
            let favorites = mangas.filter { $0.isFavorite }
            try mangaInteractor.saveMangasCollection(mangas: favorites)
        } catch {
            print("Error al guardar los mangas favoritos: \(error)")
        }
    }
    
    // cargar faritos
    func loadFavorites() async {
        do {
            let loadedFavorites = try mangaInteractor.loadMangasCollection()
            await MainActor.run {
                for loadedFavorite in loadedFavorites {
                    if let index = mangas.firstIndex(where: {$0.id == loadedFavorite.id}) {
                        mangas[index].isFavorite = true
                    }
                }
            }
        } catch {
            print("Error al cargar la coleccion\(error)")
        }
    }
    
    
    
    
    
}

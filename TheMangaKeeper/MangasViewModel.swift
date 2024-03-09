//
//  MangasViewModel.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/12/23.
//

import Foundation

final class MangasViewModel: ObservableObject {
    @Published var mangas: [Manga] = []
    @Published var isLoading = false
    var currentPage = 1
    
    let mangaInteractor: MangasInteractorProtocol
    
    init(mangaInteractor: MangasInteractorProtocol = MangasInteractor()) {
        self.mangaInteractor = mangaInteractor
        Task {
            await getMangas()
            await loadFavorites()
        }
    }
    
    // llamada a red
    func getMangas() async {
        do {
            print("Llamada de red")
            let manga = try await mangaInteractor.getMangas(page: currentPage)
            await MainActor.run {
                mangas += manga
                
                print(currentPage)
                print(manga.count)
            }
        }
        catch {
            print("Este error desde el getMangas: \(error)")
        }
    }
     
    // cargar mas mangas scroll infinito
    func loadMoreMangaIfNeeded(manga: Manga) {
        if isLastManga(manga: manga){
            currentPage += 1
        }
    }
    
    // cargar mangas siguiente paguina
    func isLastManga(manga: Manga) -> Bool {
        mangas.last?.id == manga.id
    }
    
    // eliminar magna de coleccion
    func deleteManga(manga: Manga){
        mangas.removeAll(where: {$0.id == manga.id})
    }
    
    
    // añadir manga a coleccion
    func toogleMangaFavorite(mangaID: Int){
        if let index = mangas.firstIndex(where: { $0.id == mangaID }) {
            mangas[index].isFavorite.toggle()
            saveFavorites()
        }
    }
    
    // guardar coleccion de mis mangas
    func saveFavorites() {
        do {
            let favorites = mangas.filter { $0.isFavorite }
            try mangaInteractor.saveMangasCollection(mangas: favorites)
        } catch {
            print("Error al guardar los mangas favoritos: \(error)")
        }
    }
    
    // cargar la coleccion
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

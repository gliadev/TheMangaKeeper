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
    @Published var currentPage = 1
    
    let mangaInteractor: MangasInteractorProtocol
    
    init(mangaInteractor: MangasInteractorProtocol = MangasInteractor()) {
        self.mangaInteractor = mangaInteractor
        Task {
            await getMangas()
            await loadFavorites()
        }
    }
    
    
    func getMangas() async {
        do {
            print("Llamada de red")
            let manga = try await mangaInteractor.getMangas(page: currentPage)
            await MainActor.run {
                mangas += manga
            }
        }
        catch {
            print("Este error: \(error)")
        }
    }
    
// cargar mas mangas scroll infinito
    func loadMoreMangas() async {
        guard !isLoading else { return }
        await MainActor.run { isLoading = true }
        
        do {
            let newMangas = try await mangaInteractor.getMangas(page: currentPage)
            await MainActor.run {
                self.mangas += newMangas
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                print("Error cargando mas mangas: \(error)")
                self.isLoading = false
            }
        }
    }

    
// cargar mangas siguiente paguina
    func moreMangas(manga: Manga) {
            currentPage += 1
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

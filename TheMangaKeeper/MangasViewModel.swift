//  MangasViewModel.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/12/23.



import Foundation

final class MangasViewModel: ObservableObject {
    @Published var mangas: [Manga] = []
    @Published var mangasFavorites: [Manga] = [] {
        didSet{
            Task {
                await saveFavorites()
            }
        }
    }
    @Published var showAlert = false
    @Published var deleteMangaAlertConfirmation = false
    @Published var errormenssage = ""
    @Published var searchBarText = ""
    @Published var GenreIsSelect: String = "" {
        didSet {
            if let genre = Genre(rawValue: GenreIsSelect) {
                Task {
                    await mangaSelectByGenre(genre: genre)
                }
            }
        }
    }
    
    var currentPage = 1
    
    let mangaInteractor: MangasInteractorProtocol
    
    init(mangaInteractor: MangasInteractorProtocol = MangasInteractor()) {
        self.mangaInteractor = mangaInteractor
        Task {
            async let getMangas: () = await getMangas()
            async let loadFavorites: () = await loadFavorites()
            async let loadUserCollection: () = await loadUserMangaVolumenCollection()
            _ = await (getMangas, loadFavorites, loadUserCollection)
        }
    }
    
    // hasta aqui
    func getMangas() async {
        do {
            let manga = try await mangaInteractor.getMangas(page: currentPage)
            await MainActor.run {
                mangas += manga
                self.showAlert = false
            }
        }
        catch {
            let networkError = error as? NetworkErrors
            await MainActor.run {
                self.errormenssage = networkError?.description ?? "error en la carga de la API"
                self.showAlert = true

            }
        }
    }
    

    func loadMoreMangaIfNeeded(manga: Manga) {
        if isLastManga(manga: manga){
            currentPage += 1
            Task {
                await getMangas()
            }
        }
    }
    
    
    func isLastManga(manga: Manga) -> Bool {
        mangas.last?.id == manga.id
    }
    
  
    func getMangaByID(id: Int) -> Manga? {
        return mangas.first(where: { $0.id == id })
    }
    
    
    
    func toogleMangaFavorite(mangaID: Int) async {
        if let index = mangasFavorites.firstIndex(where: { $0.id == mangaID }) {
            // Manga ya está en favoritos, lo eliminamos
            mangasFavorites.remove(at: index)
            if let mainIndex = mangas.firstIndex(where: { $0.id == mangaID }) {
                mangas[mainIndex].isFavorite = false
            }
        } else if let index = mangas.firstIndex(where: { $0.id == mangaID }) {
            await MainActor.run{
                mangas[index].isFavorite = true
                mangasFavorites.append(mangas[index])
            }
        }
        await saveFavorites()
    }
    
    
    func saveFavorites() async {
        do {
            let favorites = mangasFavorites
            try mangaInteractor.saveMangasCollection(mangas: favorites)
        } catch {
            print("Error al guardar los mangas favoritos: \(error)")
        }
    }
    
  
    func checkIsFavorite(manga: Manga)-> Bool {
        mangasFavorites.contains(where: { $0.id == manga.id })
    }
    
   
    
    @MainActor
    func deleteManga(mangaID: Int) async {
        mangasFavorites.removeAll(where: {$0.id == mangaID})
        if let index = mangas.firstIndex(where: { $0.id == mangaID }) {
            mangas[index].isFavorite.toggle()
        }
        await saveFavorites()
    }
    
    @MainActor
    func loadFavorites() async {
        do {
            let loadedFavorites = try mangaInteractor.loadMangasCollection()
            await MainActor.run {
                mangasFavorites = loadedFavorites
            }
        } catch {
            print("Error al cargar la coleccion\(error)")
        }
    }
    
    
    
    @MainActor
    func updateFavoriteStatus(for mangaID: Int, isFavorite: Bool) {
        for index in mangas.indices where mangas[index].id == mangaID {
            mangas[index].isFavorite = isFavorite
            if isFavorite {
                if !mangasFavorites.contains(where: { $0.id == mangaID }) {
                    mangasFavorites.append(mangas[index])
                }
            } else {
                mangasFavorites.removeAll(where: { $0.id == mangaID })
            }
        }
    }
    
    
    
    @MainActor
    func searchMangaContains(searchBarText: String) async {
        if !searchBarText.isEmpty {
            do {
                let searchBar = try await mangaInteractor.searchMangasContains(page: 0, contains: searchBarText)
                if currentPage == 1 {
                    mangas.removeAll()
                }
                mangas += searchBar
            } catch {
                print("Error desde la busqueda: \(error) \(errormenssage)")
            }
        } else {
            mangas.removeAll()
            currentPage = 1
            await getMangas()
        }
    }
    
    
    
  
    func mangasAlphabetic(){
        mangas.sort { $0.title < $1.title }
    }
    

    func mangaSelectByGenre(genre: Genre) async -> [Manga] {
        if !GenreIsSelect.isEmpty {
            do {
                let manga = try await mangaInteractor.searchMangaByGenre(genre: genre)
                await MainActor.run {
                    if currentPage == 1 {
                        mangas.removeAll()
                    }
                    mangas += manga
                }
            } catch {
                print("Error busqueda por genero \(error)")
            }
        } else {
            await MainActor.run {
                mangas.removeAll()
            }
            await getMangas()
            currentPage = 1
            GenreIsSelect = ""
        }
        return []
    }
    
    
    
    @MainActor
        func updateMangaVolumeStates(mangaID: Int, newVolumeStates: [Manga.VolumeState], isCollectionComplete: Bool) {
            if let mangaIndex = mangas.firstIndex(where: { $0.id == mangaID }) {
                mangas[mangaIndex].volumeStates = newVolumeStates
                mangas[mangaIndex].isCollectionComplete = isCollectionComplete
            }
        }

        @MainActor
        func updateVolumeState(mangaID: Int, volumeID: Int, isPurchased: Bool? = nil, isBeingRead: Bool? = nil) {
            if let mangaIndex = mangas.firstIndex(where: { $0.id == mangaID }) {
                if let volumeIndex = mangas[mangaIndex].volumeStates.firstIndex(where: { $0.id == volumeID }) {
                    if let isPurchased = isPurchased {
                        mangas[mangaIndex].volumeStates[volumeIndex].isPurchased = isPurchased
                    }
                    if let isBeingRead = isBeingRead {
                        mangas[mangaIndex].volumeStates[volumeIndex].isBeingRead = isBeingRead
                    }
                    mangas[mangaIndex].isCollectionComplete = mangas[mangaIndex].volumeStates.allSatisfy { $0.isPurchased }
                    try? saveUserVolumeCollection()
                }
            }
        }
    

        func saveUserVolumeCollection() throws {
            do {
                try mangaInteractor.saveUserMangasVolumenCollection(mangas: mangas)
            } catch {
                throw error
            }
        }
    

        @MainActor
        func loadUserMangaVolumenCollection() async {
            do {
                let loadedCollections = try mangaInteractor.loadUserMangaVolumenCollection()
                await MainActor.run {
                    for collection in loadedCollections {
                        if let index = mangas.firstIndex(where: { $0.id == collection.id }) {
                            mangas[index].volumeStates = collection.volumeStates
                            mangas[index].isCollectionComplete = collection.isCollectionComplete
                        }
                    }
                }
            } catch {
                print("Error al cargar la colección de volúmenes del usuario: \(error)")
            }
        }
    
    
    
}






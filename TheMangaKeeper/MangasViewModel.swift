//  MangasViewModel.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/12/23.
//

import Foundation
final class MangasViewModel: ObservableObject {
    @Published var mangas: [Manga] = []
    @Published var mangasUserVolumenCollection: [Manga] = [] // intentar unificar en al modelo de manga
    @Published var mangasFavorites: [Manga] = [] {
        didSet{
            Task {
                await saveFavorites()
            }
        }
    }
    @Published var mangaToDelete: Manga? // limpiar
    @Published var showAlert = false
    @Published var duplicateMangaAlert = false // limpiar
    @Published var deleteMangaAlertConfirmation = false
    @Published var errormenssage = ""
    @Published var searchBarText = ""
    @Published var isTheMangaCollectionVolumeCompleted = false
    var currentPage = 1
    
    let mangaInteractor: MangasInteractorProtocol
    
    init(mangaInteractor: MangasInteractorProtocol = MangasInteractor()) {
        self.mangaInteractor = mangaInteractor
        Task {
            async let getMangas: () = await getMangas()
            async let loadFavorites: () = await loadFavorites()
            _ = await (getMangas, loadFavorites)
        }
    }
    
//PETICIONES DE LOS MANGAS
    // llamada a red
    @MainActor
    func getMangas() async {
        do {
            print("Llamada de red")
            let manga = try await mangaInteractor.getMangas(page: currentPage)
            await MainActor.run {
                mangas += manga
                
            }
        }
        catch {
            self.errormenssage = "\(error)"
            self.showAlert.toggle()
            print("Este error desde el getMangas: \(error)")
        }
    }
    
    // CARGA DEL SCROLL DE MAS MANGAS
    
    // cargar mas mangas scroll infinito
    func loadMoreMangaIfNeeded(manga: Manga) {
        if isLastManga(manga: manga){
            currentPage += 1
            Task {
                await getMangas()
            }
        }
    }
    
    // cargar mangas siguiente paguina
    func isLastManga(manga: Manga) -> Bool {
        mangas.last?.id == manga.id
    }
    
    
    
//GESTION DE LA COLLECION PARA AÑADIR ELIMINAR A FAVORITOS
    
    // metodo chechduplicate array de mi coleccion esta el magna que quiero añadir
    //  func checkDu
    
    // añadir manga a coleccion
    @MainActor
    func toogleMangaFavorite(mangaID: Int) async {
        if let index = mangasFavorites.firstIndex(where: { $0.id == mangaID }) {
            // Manga ya está en favoritos, lo eliminamos
            mangasFavorites.remove(at: index)
            if let mainIndex = mangas.firstIndex(where: { $0.id == mangaID }) {
                mangas[mainIndex].isFavorite = false
            }
        } else if let index = mangas.firstIndex(where: { $0.id == mangaID }) {
            // Añadir a favoritos si no está ya
            mangas[index].isFavorite = true
            mangasFavorites.append(mangas[index])
        }
        await saveFavorites()
        objectWillChange.send()
    }
    
    // guardar coleccion de mis mangas
    @MainActor
    func saveFavorites() async {
        do {
            let favorites = mangasFavorites
            try mangaInteractor.saveMangasCollection(mangas: favorites)
        } catch {
            print("Error al guardar los mangas favoritos: \(error)")
        }
    }
    
    // checfavorito
    // necestio un favorito
    
    
    // eliminar magna de coleccion
    @MainActor
    func deleteManga(mangaID: Int) async {
        mangasFavorites.removeAll(where: {$0.id == mangaID})
        if let index = mangas.firstIndex(where: { $0.id == mangaID }) {
            mangas[index].isFavorite.toggle()
        }
// revisar
//        mangas.indices.forEach { index in
//            if mangas[index].id == mangaID {
//                mangas[index].isFavorite = false
//            }
//        }
        await saveFavorites()
    }
    
    // cargar la coleccion
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
    
    
    
    // funcion para actualizar el estado de la coleccion de los mangas
    @MainActor
    func updateFavoriteStatus(for mangaID: Int, isFavorite: Bool) {
//        // Actualizar en la lista principal si es necesario
//        if let index = mangas.firstIndex(where: { $0.id == mangaID }) {
//            mangas[index].isFavorite = isFavorite
//        }
//        // Actualizar en la lista de favoritos
//        if isFavorite {
//            if !mangasFavorites.contains(where: { $0.id == mangaID }) {
//                if let mangaToAdd = mangas.first(where: { $0.id == mangaID }) {
//                    mangasFavorites.append(mangaToAdd)
//                }
//            }
//        } else {
//            mangasFavorites.removeAll(where: { $0.id == mangaID })
//        }
//        // Notificar a SwiftUI que necesita actualizar las vistas
//        objectWillChange.send()
//    }
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
            objectWillChange.send() // revisar conbine
        }
    
    
    
//BUSQUEDAS
    
    // buscar mangas por algo "Patata"
    @MainActor
    func searchMangaContains(searchBarText: String) async {
        if !searchBarText.isEmpty {
            do {
                let searchBar = try await mangaInteractor.searchMangasContains(page: 0, contains: searchBarText)
                if currentPage == 1 {
                    mangas.removeAll()
                } // cuando valla hacer una busqueda paso la currentpage a 0
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
    
    
    
//FILTROS
    
    // funcion para el filtro y ordenar alfabeticamente
    func mangasAlphabetic(){
        mangas.sort { $0.title < $1.title }
    }
    
    
    
//GESTION DE LOS VOLUMENES DE LA COLECCION
    // Función para actualizar el estado de un volumen específico en la colección de usuario
    func updateVolumeStatus(mangaID: Int, volumeID: Int, newStatus: VolumeStatus) {
        guard let mangaIndex = mangasUserVolumenCollection.firstIndex(where: { $0.id == mangaID }) else { return }
        if let volumeIndex = mangasUserVolumenCollection[mangaIndex].volumeDetails.firstIndex(where: { $0.id == volumeID }) {
            mangasUserVolumenCollection[mangaIndex].volumeDetails[volumeIndex].status = newStatus
            try? saveUserVolumeCollection()
        }
    }

    // Función para guardar la colección de volúmenes del usuario
    func saveUserVolumeCollection() throws {
        do {
            try mangaInteractor.saveUserMangasVolumenCollection(mangas: mangasUserVolumenCollection)
        } catch {
            print("Error al guardar la colección de volúmenes: \(error)")
        }
    }
    
   
    func checkIsFavorite(manga: Manga)-> Bool {
        mangasFavorites.contains(where: { $0.id == manga.id })
    }
    
    

}

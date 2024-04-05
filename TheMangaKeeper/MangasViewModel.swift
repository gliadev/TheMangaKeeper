//
//  MangasViewModel.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/12/23.
//

import Foundation

final class MangasViewModel: ObservableObject {
    @Published var mangas: [Manga] = []
    @Published var mangasFavorites: [Manga] = [] {
        didSet{
            saveFavorites()
        }
    }
    @Published var mangaToDelete: Manga?
    @Published var showAlert = false
    @Published var duplicateMangaAlert = false
    @Published var deleteMangaAlertConfirmation = false
    @Published var errormenssage = ""
    @Published var searchBarText = ""
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
                
            }
        }
        catch {
            await MainActor.run {
                self.errormenssage = "\(error)"
                self.showAlert.toggle()
            }
            print("Este error desde el getMangas: \(error)")
        }
    }
    
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
    
    // eliminar magna de coleccion
    func deleteManga(manga: Manga) async{
        mangasFavorites.removeAll(where: {$0.id == manga.id})
        //mangas.removeAll(where: {$0.id == manga.id})
        //saveFavorites()
        await loadFavorites()
        
    }
     
    
    // metodo chechduplicate array de mi coleccion esta el magna que quiero añadir
  //  func checkDu
    
    // añadir manga a coleccion
    func toogleMangaFavorite(mangaID: Int){
        if let index = mangasFavorites.firstIndex(where: { $0.id == mangaID }) {
                // Manga ya está en favoritos, lo eliminamos de favoritos
        
                mangasFavorites.remove(at: index)
                // Actualiza el estado isFavorite del manga en la lista general si es necesario
                if let mainIndex = mangas.firstIndex(where: { $0.id == mangaID }) {
                    mangas[mainIndex].isFavorite = false
                }
            } else {
                // Intentamos añadir el manga a favoritos
                if let index = mangas.firstIndex(where: { $0.id == mangaID }) {
                    if mangas[index].isFavorite {
                        // El manga ya es favorito, mostrar alerta
                        duplicateMangaAlert = true
                    } else {
                        // El manga no es favorito aún, lo añadimos a favoritos
                        mangas[index].isFavorite.toggle() // Cambiamos el estado a favorito
                        mangasFavorites.append(mangas[index])
                    }
                }
            }
            saveFavorites()

//        guard let index = mangas.firstIndex(where: { $0.id == mangaID }) else { return }
//
//        if mangasFavorites.contains(where: { $0.id == mangaID }) {
//            duplicateMangaAlert = true
//        } else {
//            mangas[index].isFavorite.toggle()
//            let manga = mangas[index]
//            mangasFavorites.append(manga)
//            saveFavorites()
//        }
////        if let index = mangas.firstIndex(where: { $0.id == mangaID }) {
////            mangas[index].isFavorite.toggle()
////            let manga = mangas[index]
////            mangasFavorites.append(manga)
////            saveFavorites()
////        }
    }
    
    // guardar coleccion de mis mangas
    func saveFavorites() {
        do {
            let favorites = mangasFavorites
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
                mangasFavorites = loadedFavorites
//                for loadedFavorite in loadedFavorites {
//                    if let index = mangas.firstIndex(where: {$0.id == loadedFavorite.id}) {
//                        mangas[index].isFavorite = true
//                    }
//                }
                
            }
        } catch {
            print("Error al cargar la coleccion\(error)")
        }
    }
    
    // buscar mangas por algo "Patata"
    func searchMangaContains() async {
        if !searchBarText.isEmpty {
            do {
                if currentPage == 1 {
                    await MainActor.run {
                        mangas.removeAll()
                    }
                } // cuando valla hacer una busqueda paso la currentpage a 0
                let searchBar = try await mangaInteractor.searchMangasContains(page: 0, contains: searchBarText)
                await MainActor.run {
                    mangas += searchBar
                }
            } catch {
                print("Error desde la busqueda: \(error) \(errormenssage)")
            }
        } else {
            await MainActor.run {
                mangas.removeAll()
                currentPage = 1
            }
            await getMangas()
        }
    }
    
// funcion para el filtro y ordenar alfabeticamente
    func mangasAlphabetic(){
        mangas.sort { $0.title < $1.title }
    }
    
}





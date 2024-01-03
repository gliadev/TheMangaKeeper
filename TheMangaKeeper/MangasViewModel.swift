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
            print("red")
            let manga = try await mangaInteractor.getMangas()
            await MainActor.run {
                mangas = manga
            }
        }
        catch {
            print(error)
            print("ESte error")
        }
    }
}

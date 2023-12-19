//
//  MangasViewModel.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/12/23.
//

import Foundation

final class MangasViewModel: ObservableObject {
    @Published var mangas: [Mangas] = []
    
    let mangaInteractor: MangasInteractorProtocol
    
    init(mangaInteractor: MangasInteractorProtocol = MangasInteractor()) {
        self.mangaInteractor = mangaInteractor
        Task { await getMangas() }
    }
    
    
    func getMangas() async {
        do {
            let manga = try await
            mangaInteractor.getMangasInteractor()
            await MainActor.run {
                mangas = manga
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
}

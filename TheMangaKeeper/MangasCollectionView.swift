//
//  MangasFavorites.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 6/1/24.
//TODO: PAGUINACION AÑADIR A UN NUEVO LISTADO LOS MANGAS QUE TENGAMOS

import SwiftUI

struct MangasCollectionView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    
    var body: some View {
        List {
                    ForEach(mangasVM.mangas.filter { $0.isFavorite }) { manga in
                        MangasCellView(manga: manga)
                    }
                  //  .navigationTitle("Favorites Mangas")
                }
            }
        }
//TODO: PAGUINACION AÑADIR A UN NUEVO LISTADO LOS MANGAS QUE TENGAMOS
#Preview {
    MangasCollectionView()
        .environmentObject(MangasViewModel.localTestMangas)
}




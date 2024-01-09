//
//  MangasFavorites.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 6/1/24.
//

import SwiftUI

struct MangasCollectionView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    
    var body: some View {
        List {
                    ForEach(mangasVM.mangas.filter { $0.isFavorite }) { manga in
                        // Aquí puedes usar MangasCellView o cualquier otra vista que represente un manga
                        MangasCellView(manga: manga)
                    }
                  //  .navigationTitle("Favorites Mangas")
                }
            }
        }
//TODO: PAGUINACION AÑADIR A UN NUEVO LISTADO LOS MANGAS QUE TENGAMOS
#Preview {
    MangasCollectionView()
        .environmentObject(MangasViewModel())
}


   

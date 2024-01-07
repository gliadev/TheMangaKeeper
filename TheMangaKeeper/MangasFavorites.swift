//
//  MangasFavorites.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 6/1/24.
//

import SwiftUI

struct MangasFavorites: View {
    @ObservedObject var mangasVM = MangasViewModel()
    
    var body: some View {
        Text("Mangas Favoritos")
    }
}

#Preview {
    MangasFavorites()
}

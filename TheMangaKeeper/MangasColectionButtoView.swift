//
//  MangasColectionButtoView.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 16/4/24.
//

import SwiftUI

struct MangasColectionButtoView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
   // @State var isFavorite: Bool
    var manga: Manga

    init(manga: Manga) {
        self.manga = manga
      //  _isFavorite = State(initialValue: manga.isFavorite)
    }
    
       var body: some View {
           Button(action: {
               if mangasVM.checkIsFavorite(manga: manga) {
                   mangasVM.deleteMangaAlertConfirmation = true
               } else {
                   Task {
                       await mangasVM.toogleMangaFavorite(mangaID: manga.id)
                   }
               }
           }) {
               HStack {
                   Image(systemName: mangasVM.checkIsFavorite(manga: manga) ? "star.fill" : "star")
                       .foregroundColor(mangasVM.checkIsFavorite(manga: manga) ? .yellow : .gray)
                   Text(mangasVM.checkIsFavorite(manga: manga) ? "Eliminar de favoritos" : "Añadir a favoritos")
               }
               .padding()
               .background(mangasVM.checkIsFavorite(manga: manga) ? Color.red : Color.blue)
               .foregroundColor(.white)
               .clipShape(RoundedRectangle(cornerRadius: 10))
           }
           .confirmationDialog("¿Estas seguro que deseas eliminar este manga de tus colección?", isPresented: $mangasVM.deleteMangaAlertConfirmation, titleVisibility: .visible) {
               Button("Eliminar", role: .destructive) {
                   Task {
                       await mangasVM.deleteManga(mangaID: manga.id)
                      // manga.isFavorite = false
                   }
               }
               Button("Cancelar", role: .cancel) {}
           }
       }
   }
#Preview {
    MangasColectionButtoView(manga: .testManga)
        .environmentObject(MangasViewModel.localTestMangas)
}

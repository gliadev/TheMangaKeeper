//
//  MangasColectionButtoView.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 16/4/24.
//

import SwiftUI

struct MangasColectionButtoView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
       var manga: Manga

       var body: some View {
           Button(action: {
               if manga.isFavorite {
                   mangasVM.deleteMangaAlertConfirmation = true
               } else {
                   mangasVM.toogleMangaFavorite(mangaID: manga.id)
               }
           }) {
               HStack {
                   Image(systemName: manga.isFavorite ? "star.fill" : "star")
                       .foregroundColor(manga.isFavorite ? .yellow : .gray)
                   Text(manga.isFavorite ? "Eliminar de favoritos" : "Añadir a favoritos")
               }
               .padding()
               .background(manga.isFavorite ? Color.red : Color.blue)
               .foregroundColor(.white)
               .clipShape(RoundedRectangle(cornerRadius: 10))
           }
           .confirmationDialog("¿Estás seguro que deseas eliminar este manga de tus favoritos?", isPresented: $mangasVM.deleteMangaAlertConfirmation, titleVisibility: .visible) {
               Button("Eliminar", role: .destructive) {
                   Task {
                       await mangasVM.deleteManga(manga: manga)
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

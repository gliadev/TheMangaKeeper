//
//  MangasListViewSecond.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 10/3/24.
//

import SwiftUI

struct MangasListView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    @State var timer: Timer?
    var body: some View {
        NavigationStack {
                   VStack {
                       HStack {
                           TextField("Buscar un Manga", text: $mangasVM.searchBarText)
                               .textFieldStyle(.roundedBorder)
                               .onChange(of: mangasVM.searchBarText) {
                                   timer?.invalidate()
                                   timer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { _ in
                                       Task {
                                           await mangasVM.searchMangaContains()
                                       }
                                   }
                               }
                               .frame(maxWidth: .infinity)

                           Button(action: {
                               mangasVM.mangasAlphabetic()
                           }) {
                               Image(systemName: "arrow.up.arrow.down")
                                   .font(.body)
                                   .foregroundStyle(.red)
                                   .padding(8)
                                   //.background(Circle().fill(Color.blue))
                                   .frame(width: 36, height: 36, alignment: .center)
                           }
                           //.padding(.leading, 8)
                       }
                       .padding([.horizontal, .top])

                       List {
                           ForEach(mangasVM.mangas) { manga in
                               NavigationLink(destination: MangasDetailView(manga: manga)) {
                                   MangasCellView(manga: manga)
                                       .onAppear {
                                           mangasVM.loadMoreMangaIfNeeded(manga: manga)
                                       }
                               }
                               .swipeActions(edge: .leading) {
                                   Button {
                                       mangasVM.toogleMangaFavorite(mangaID: manga.id)
                                   } label: {
                                       Label(manga.isFavorite ? "Eliminar de Colección" : "Añadir a colección", systemImage: manga.isFavorite ? "trash" : "heart.fill")
                                   }
                                   .tint(manga.isFavorite ? .red : .yellow)
                               }
                           }
                       }
                       .navigationTitle("Lista de Mangas")
                   }
               }
               .alert(isPresented: $mangasVM.duplicateMangaAlert) {
                   Alert(title: Text("Ya tienes este Manga en tu coleccion"), message: Text(mangasVM.errormenssage), dismissButton: .default(Text("OK")))
               }
           }
       }
       

   #Preview {
       MangasListView()
           .environmentObject(MangasViewModel())
   }

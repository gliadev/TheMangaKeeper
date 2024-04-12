//
//  MangasListViewSecond.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 10/3/24.
//

import SwiftUI

struct MangasListView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Buscar un Manga", text: $mangasVM.searchBarText)
                        .textFieldStyle(.roundedBorder)
                        .onReceive(mangasVM
                            .$searchBarText
                            .delay(
                                for: .seconds(0.4),
                                scheduler: DispatchQueue.main,
                                options: nil
                            )
                        ) { text in
                            guard !text.isEmpty else { return }
                            Task {
                                await mangasVM.searchMangaContains(searchBarText: text)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    
                    Button(action: {
                        mangasVM.mangasAlphabetic()
                    }) {
                        Image(systemName: "textformat.abc")
                            .font(.body)
                            .foregroundStyle(.red)
                            .padding(8)
                        //.background(Circle().fill(Color.blue))
                            .frame(width: 36, height: 36, alignment: .center)
                    }
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
                            ToggleFavoriteButton(manga: manga)
                        }
                    }
                }
                .navigationTitle("Lista de Mangas")
            }
        } // modificar la alert
        .alert(isPresented: $mangasVM.duplicateMangaAlert) {
            Alert(title: Text("Ya tienes este Manga en tu coleccion"), message: Text(mangasVM.errormenssage), dismissButton: .default(Text("OK")))
        }
    }
    
    @ViewBuilder
    func ToggleFavoriteButton(manga: Manga) -> some View {
        let isFavorite = mangasVM.isMangaFavorite(mangaId: manga.id)
        let title = isFavorite ? "Eliminar de Colección" : "Añadir a colección"
        Button {
            mangasVM.toogleMangaFavorite(mangaID: manga.id)
        } label: {
            Label(
                title,
                systemImage: manga.isFavorite ? "trash" : "heart.fill"
            )
        }
        .tint(isFavorite ? .red : .yellow)
    }
}

#Preview {
    MangasListView()
        .environmentObject(MangasViewModel())
}

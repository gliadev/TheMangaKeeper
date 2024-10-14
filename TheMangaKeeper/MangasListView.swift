//
//  MangasListViewSecond.swift
//  TheMangaKeeper
//  Created by Adolfo on 10/3/24.


import SwiftUI

struct MangasListView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBarView()
                List {
                    ForEach(mangasVM.mangas) { manga in
                        NavigationLink(destination: MangasDetailView(manga: manga)) {
                            MangasCellView(manga: manga)
                                .onAppear {
                                    mangasVM.loadMoreMangaIfNeeded(manga: manga)
                                }
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Listado de Mangas")
                .navigationBarTitleDisplayMode(.inline)
            }
            .alert("No se ha podido cargar los datos de la API, vuelve a intentarlo o sal y ven en un rato", isPresented: $mangasVM.showAlert) {
                Button("Reintentar", role: .cancel) {
                    Task {
                        await mangasVM.getMangas()
                    }
                }
            }
        }
    }
}


#Preview {
    MangasListView()
        .environmentObject(MangasViewModel.localTestMangas)
}

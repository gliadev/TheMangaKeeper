//
//  ContentView.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 17/12/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var mangasVM = MangasViewModel()
    //let manga: Manga
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(mangasVM.mangas) { manga in
                    NavigationLink(destination: MangasDetailView(manga: manga)) {
                        MangasCellView(manga: manga)
                    }
                }
            }
            .padding()
            .navigationTitle("Mangas List")
        }
    }
}
                                                       

#Preview {
    ContentView()
}

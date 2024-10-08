//
//  SearchBarView.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 16/4/24.
//

import SwiftUI

struct SearchBarView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    @State private var showGenreFilter = false
    
    var body: some View {
        VStack {
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
            HStack {
                Button(action: {showGenreFilter.toggle()}) {
                    Image(systemName: "camera.filters")
                        .foregroundStyle(.gray)
                        .frame(width: 36, height: 36, alignment: .center)
                }
                
                .padding(.leading, 24)
                .sheet(isPresented: $showGenreFilter) {
                                    SearchByGenreFilterView()
                                        .environmentObject(mangasVM)
                                }
                Spacer()
                Button(action: {
                    mangasVM.mangasAlphabetic()
                }) {
                    Image(systemName: "textformat.abc")
                        .font(.body)
                        .foregroundStyle(.red)
                        .padding(.bottom)
                        .frame(width: 36, height: 36, alignment: .center)
                }
                .padding(.trailing, 24)
            }
        }
    }
}
    #Preview {
        SearchBarView()
            .environmentObject(MangasViewModel.localTestMangas)
    }

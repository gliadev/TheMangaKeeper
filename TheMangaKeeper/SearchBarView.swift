//
//  SearchBarView.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 16/4/24.
//

import SwiftUI

struct SearchBarView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    //@State var timer: Timer?
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
                Button(action: {}) {
                    Image(systemName: "camera.filters")
                        .foregroundStyle(.gray)
                }
                .disabled(true)
                .padding(.bottom)
                .padding(.leading, 24)
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
            .environmentObject(MangasViewModel())
    }

//
//  MangasCellView.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 19/12/23.
//

import SwiftUI

struct MangasCellView: View {
    let mangas: Mangas
    var body: some View {
        Text(mangas.title)
        Text(mangas.titleEnglish)
    }
}

#Preview {
    MangasCellView(mangas: .init(id: 12, title: "Hola", titleEnglish: "Ingles", sypnosis: "patatit tapton patotaeero patot", score: 2.22))
}

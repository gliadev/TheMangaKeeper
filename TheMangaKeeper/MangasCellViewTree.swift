//
//  MangasCellViewTree.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 18/3/24.
//

import SwiftUI

struct MangasCellViewTree: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    let manga: Manga
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MangasCellViewTree(manga: .testManga)
        
}

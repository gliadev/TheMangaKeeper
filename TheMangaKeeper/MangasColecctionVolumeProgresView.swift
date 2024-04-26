//
//  MangasColecctionVolumeProgresView.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 26/4/24.
//

import SwiftUI

struct MangasColecctionVolumeProgresView: View {
    let manga: Manga
    var body: some View {
        VStack {
            HStack {
                Text(manga.title)
                Text(manga.titleJapanese ?? "")
            }
        }
       
    }
}

#Preview {
    MangasColecctionVolumeProgresView(manga: .testManga)
}

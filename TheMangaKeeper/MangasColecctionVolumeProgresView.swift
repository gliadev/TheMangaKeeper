//
//  MangasColecctionVolumeProgresView.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 26/4/24.
//

import SwiftUI

struct MangasColecctionVolumeProgresView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    let manga: Manga
    var body: some View {
        VStack {
            VStack {
                VStack {
                    Text(manga.title)
                    Text(manga.titleJapanese ?? "")
                }
                
            }
        }
        
    }
}

#Preview {
    MangasColecctionVolumeProgresView(manga: .testManga)
        .environmentObject(MangasViewModel.localTestMangas)
}

//
//  MangaVolumesManagementView.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 26/4/24.
//

import SwiftUI

struct MangaVolumesManagementView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    let manga: Manga
    var body: some View {
            VStack {
                if let volumes = manga.volumes {
                    ForEach(1...volumes, id: \.self) {
                        volume in
                        Text("Volumen: \(volume)")
                    }
                } else {
                    Text("No hay informacion de volumenes")
                }
            }
        }
    }

#Preview {
    MangaVolumesManagementView(manga: .testManga)
        .environmentObject(MangasViewModel.localTestMangas)
    
}

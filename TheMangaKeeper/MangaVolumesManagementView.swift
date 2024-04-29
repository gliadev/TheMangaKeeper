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
        List {
                    ForEach(manga.volumeDetails.indices, id: \.self) { index in
                        let volume = manga.volumeDetails[index]
                        HStack {
                            Text("Volumen \(index + 1)")
                            Spacer()
                            Text(volume.status.rawValue)
                            Spacer()
                            Menu("Cambiar Estado") {
                                Button("Comprado", action: {
                                    mangasVM.updateVolumeStatus(mangaID: manga.id, volumeID: volume.id, newStatus: .purchased)
                                })
                                Button("Leyendo", action: {
                                    mangasVM.updateVolumeStatus(mangaID: manga.id, volumeID: volume.id, newStatus: .reading)
                                })
                                Button("Leído", action: {
                                    mangasVM.updateVolumeStatus(mangaID: manga.id, volumeID: volume.id, newStatus: .read)
                                })
                            }
                        }
                    }
                }
                .navigationTitle("Gestión de Volumen")
            }
        }

#Preview {
    MangaVolumesManagementView(manga: .testManga)
        .environmentObject(MangasViewModel.localTestMangas)
    
}

//
//  MangaVolumesManagementView.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 26/4/24.
//

import SwiftUI

struct MangaVolumesManagementView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    @State private var localVolumeStates: [Manga.VolumeState]
    @State private var isCollectionComplete: Bool

    let manga: Manga

    init(manga: Manga) {
        self.manga = manga
        _localVolumeStates = State(initialValue: manga.volumeStates)
        _isCollectionComplete = State(initialValue: manga.isCollectionComplete)
    }

    var body: some View {
        VStack {
                   Text("Gestión de Volúmenes de \(manga.title)")
                       .font(.title)
                       .padding()

                   Toggle("Colección completa", isOn: $isCollectionComplete)
                       .padding()
                       .onChange(of: isCollectionComplete) { _, newValue in
                           if let volumes = manga.volumes {
                               for volumeID in 1...volumes {
                                   mangasVM.updateVolumeState(mangaID: manga.id, volumeID: volumeID, isPurchased: newValue)
                               }
                               localVolumeStates = mangasVM.mangas.first { $0.id == manga.id }?.volumeStates ?? []
                           }
                       }

                   if let volumes = manga.volumes {
                       ScrollView {
                           VStack {
                               ForEach(1...volumes, id: \.self) { volumeID in
                                   if volumeID - 1 < localVolumeStates.count {
                                       VStack(alignment: .leading) {
                                           Text("Volumen \(volumeID)")
                                               .font(.headline)
                                               .padding(.top)

                                           HStack {
                                               Toggle("Comprado", isOn: Binding(
                                                   get: { localVolumeStates[volumeID - 1].isPurchased },
                                                   set: { isPurchased in
                                                       mangasVM.updateVolumeState(mangaID: manga.id, volumeID: volumeID, isPurchased: isPurchased)
                                                       localVolumeStates = mangasVM.mangas.first { $0.id == manga.id }?.volumeStates ?? []
                                                       isCollectionComplete = localVolumeStates.allSatisfy { $0.isPurchased }
                                                   }
                                               ))
                                               .padding(.leading)
                                           }
                                           .padding(.bottom, 5)

                                           HStack {
                                               Toggle("Leyendo", isOn: Binding(
                                                   get: { localVolumeStates[volumeID - 1].isBeingRead },
                                                   set: { isBeingRead in
                                                       mangasVM.updateVolumeState(mangaID: manga.id, volumeID: volumeID, isBeingRead: isBeingRead)
                                                       localVolumeStates = mangasVM.mangas.first { $0.id == manga.id }?.volumeStates ?? []
                                                   }
                                               ))
                                               .padding(.leading)
                                           }
                                       }
                                       .padding()
                                       Divider()
                                   }
                               }
                           }
                       }
                   } else {
                       Text("No hay información de volúmenes")
                   }

                   Button("Guardar Cambios") {
                       mangasVM.updateMangaVolumeStates(mangaID: manga.id, newVolumeStates: localVolumeStates, isCollectionComplete: isCollectionComplete)
                       do {
                           try mangasVM.saveUserVolumeCollection()
                       } catch {
                           print("Error al guardar la colección de volúmenes: \(error)")
                       }
                   }
                   .padding()
                   .buttonStyle(.borderedProminent)

                   Spacer()
               }
               .padding()
           }
       }

        

#Preview {
    MangaVolumesManagementView(manga: .testManga)
        .environmentObject(MangasViewModel.localTestMangas)
    
}

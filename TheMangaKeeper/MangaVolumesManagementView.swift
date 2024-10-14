//
//  MangaVolumesManagementView.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 26/4/24.
//

import SwiftUI

struct MangaVolumesManagementView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    @State private var localVolumeStates: [Manga.VolumeState] = []
    @State private var isCollectionComplete: Bool = false
    
    let manga: Manga
    
    var body: some View {
        VStack {
            Text("Gestión de Volúmenes de \(manga.title)")
                .font(.title)
                .padding()
            
            Toggle("Colección completa", isOn: $isCollectionComplete)
                .padding()
                .onChange(of: isCollectionComplete) { _, newValue in
                    if let volumes = manga.volumes {
                        for volumeID in 0..<volumes {
                            mangasVM.updateVolumeState(mangaID: manga.id, volumeID: volumeID, isPurchased: newValue)
                        }
                        localVolumeStates = mangasVM.mangas.first { $0.id == manga.id }?.volumeStates ?? []
                        if localVolumeStates.count != volumes {
                            localVolumeStates = Array(repeating: Manga.VolumeState(id: 0, isPurchased: false, isBeingRead: false), count: volumes)
                        }
                    }
                }
            
            if let volumes = manga.volumes {
                ScrollView {
                    VStack {
                        ForEach(1...volumes, id: \.self) { volumeID in
                            let actualIndex = volumeID - 1
                            if actualIndex < localVolumeStates.count {
                                VStack(alignment: .leading) {
                                    Text("Volumen \(volumeID)")
                                        .font(.headline)
                                        .padding(.top)
                                    
                                    HStack {
                                        Toggle("Comprado", isOn: Binding(
                                            get: { localVolumeStates[actualIndex].isPurchased },
                                            set: { isPurchased in
                                                mangasVM.updateVolumeState(mangaID: manga.id, volumeID: actualIndex, isPurchased: isPurchased)
                                                localVolumeStates = mangasVM.mangas.first { $0.id == manga.id }?.volumeStates ?? []
                                                isCollectionComplete = localVolumeStates.allSatisfy { $0.isPurchased }
                                            }
                                        ))
                                        .padding(.leading)
                                    }
                                    .padding(.bottom, 5)
                                    HStack {
                                        Toggle("Leyendo", isOn: Binding(
                                            get: { localVolumeStates[actualIndex].isBeingRead },
                                            set: { isBeingRead in
                                                mangasVM.updateVolumeState(mangaID: manga.id, volumeID: actualIndex, isBeingRead: isBeingRead)
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
                    print("Cambios en la colección guardados")
                } catch {
                    mangasVM.showAlert = true
                    mangasVM.errormenssage = "Error al guardar la colección de volúmenes: \(error)"
                    print("Error al guardar la colección de volúmenes: \(error)")
                }
            }
            .padding()
            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .padding()
        .onAppear {
            Task {
                await mangasVM.loadUserMangaVolumenCollection()
                print("carga los datos del json que tenemos guarados")
                loadMangaData()
            }
            
        }
    }
    
    
    private func loadMangaData() {
        if let loadedManga = mangasVM.mangas.first(where: { $0.id == manga.id }) {
            localVolumeStates = loadedManga.volumeStates
            isCollectionComplete = loadedManga.isCollectionComplete
        } else {
            localVolumeStates = manga.volumeStates
            isCollectionComplete = manga.isCollectionComplete
        }
        let volumeCount = manga.volumes ?? 0
        if localVolumeStates.count != volumeCount {
            localVolumeStates = Array(repeating: Manga.VolumeState(id: 0, isPurchased: false, isBeingRead: false), count: volumeCount)
            for i in 0..<volumeCount {
                localVolumeStates[i].id = i + 1
            }
        }
    }
}

#Preview {
    MangaVolumesManagementView(manga: .testManga)
        .environmentObject(MangasViewModel.localTestMangas)
}

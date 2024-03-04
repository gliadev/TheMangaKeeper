//
//  MangaCelGridView.swift
//  TheMangaKeeper
// 
//  Created by Adolfo on 29/2/24.
//

import SwiftUI

struct MangaCelGridView: View {
    @EnvironmentObject var MangasVM: MangasViewModel
    let manga: Manga
    
    var body: some View {
        
            AsyncImage(url: URL(string: manga.mainPictureFormateada)){
                image in image
                    .image?.resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 300)
                    
            
        }
    }
}

#Preview {
    MangaCelGridView(manga: .testManga)
}

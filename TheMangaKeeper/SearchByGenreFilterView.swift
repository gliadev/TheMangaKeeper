//
//  SearchByGenreFilterView.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 2/6/24.
//

import SwiftUI

struct SearchByGenreFilterView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List {
            ForEach(Genre.allCases) {
                genre in
                Text(genre.rawValue)
                    .onTapGesture {
                        mangasVM.GenreIsSelect = genre.rawValue
                        dismiss()
                    }
            }
        }
    }
}

#Preview {
    SearchByGenreFilterView()
        .environmentObject(MangasViewModel())
}

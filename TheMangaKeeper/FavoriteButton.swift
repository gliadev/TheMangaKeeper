//
//  FavoriteButton.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 18/3/24.
//

import SwiftUI

struct FavoriteButton: View {
    var isFavorite: Bool
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "heart.fill")
                .foregroundStyle(isFavorite ? .red : .gray )
                .padding()
                .background(Circle().fill(Color.white))
                .shadow(radius: 5)
        }
    }
}

#Preview {
    FavoriteButton(isFavorite: false, action: {})
}

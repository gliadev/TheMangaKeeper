//
//  StarRatingViewComponent.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 10/3/24.
//

import SwiftUI

struct StarRatingViewComponent: View {
    let rating: Int
    private let maxRating = 5
    
    var body: some View {
        HStack {
            ForEach(0..<maxRating, id: \.self) { star in
                Image(systemName: "star.fill")
                    .foregroundColor(colorForStar(starNumber: star))
            }
        }
    }
    
    func colorForStar(starNumber: Int) -> Color {
        let activeStarCount = Int(ceil(Double(rating) / 2.0))
       // let activeStarCount = rating
        let color: Color
        
        if activeStarCount == 1 || activeStarCount == 2 {
            color = .red
        } else if activeStarCount == 3 || activeStarCount == 4 {
            color = .orange
        } else if activeStarCount == 5 || activeStarCount == 6 {
            color = .yellow
        } else if activeStarCount == 7 || activeStarCount == 8 {
            color = .green
        } else if activeStarCount == 9 || activeStarCount == 10 {
            color = .brown
        } else {
            color = .gray
        }
        
        return starNumber < activeStarCount ? color : .white
    }
}
#Preview {
    StarRatingViewComponent(rating: 9)
}

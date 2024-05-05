//
//  DateFormatter.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 29/2/24.
//

import Foundation

extension DateFormatter {
    static let dateFormatted: DateFormatter = {
        let formattedDate = DateFormatter()
        formattedDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formattedDate
    }()
}

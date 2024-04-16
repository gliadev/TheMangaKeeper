//
//  SearchBarView.swift
//  TheMangaKeeper
//
//  Created by Adolfo on 16/4/24.
//

import SwiftUI

struct SearchBarView: View {
    @EnvironmentObject var mangasVM: MangasViewModel
    @State var timer: Timer?
    var body: some View {
        HStack {
            TextField("Buscar un Manga", text: $mangasVM.searchBarText)
                .textFieldStyle(.roundedBorder)
                .onChange(of: mangasVM.searchBarText) {
                    timer?.invalidate()
                    timer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { _ in
                        Task {
                            await mangasVM.searchMangaContains()
                        }
                    }
                }
                .frame(maxWidth: .infinity)

//                           Button(action: {
//                               mangasVM.mangasAlphabetic()
//                           }) {
//                               Image(systemName: "textformat.abc")
//                                   .font(.body)
//                                   .foregroundStyle(.red)
//                                   .padding(8)
//                                   //.background(Circle().fill(Color.blue))
//                                   .frame(width: 36, height: 36, alignment: .center)
//                           }
        }
        .padding([.horizontal, .top])
    }
}

#Preview {
    SearchBarView()
        .environmentObject(MangasViewModel())
}

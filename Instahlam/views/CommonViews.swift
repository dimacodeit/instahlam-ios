//
//  PhotoGrid.swift
//  Instahlam
//
//  Created by dmitry-s on 06.04.2022.
//

import SwiftUI

struct PhotoGrid: View {
    @Binding var setOfImages: [Image]
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.adaptive(minimum: 170))
        ], spacing: 20) {
            ForEach(0..<setOfImages.count, id: \.self) { index in
                ZStack {
                    NavigationLink {
                        VStack {
                            PhotoDetail(image: setOfImages[index])
                        }
                    } label: {
                        setOfImages[index]
                            .resizable()
                            .frame(width: 170, height: 170)
                            .scaledToFit()
                    }
                    
                }
            }
        }
    }
}



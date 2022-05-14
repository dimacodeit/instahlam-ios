//
//  ContentView.swift
//  Instahlam
//
//  Created by dmitry-s on 05.04.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var setOfImages = createInitialSet()
    @State private var showPhotoPicker = false
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentCamera = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    Text("Это ваши стремные фотки")
                        .font(.title)
                    VStack {
                        PhotoGrid(setOfImages: $setOfImages)
                            .navigationTitle(Text("INSTAHLAM"))
                        Spacer()
                            .frame(height: 20)
                    }
                }
                .sheet(isPresented: $shouldPresentImagePicker) {
                    PhotoPicker(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, setOfImages: $setOfImages)
                }
                .actionSheet(isPresented: $showPhotoPicker) {
                    ActionSheet(title: Text("ОТКУДА???"),
                                buttons: [
                                    .cancel(),
                                    .default(
                                        Text("С камеры плз"),
                                        action: {
                                            shouldPresentImagePicker = true
                                            shouldPresentCamera = true
                                        }
                                    ),
                                    .default(
                                        Text("УЖЕ ЕСТЬ"),
                                        action: {
                                            shouldPresentImagePicker = true
                                            shouldPresentCamera = false
                                        }
                                    ),
                                    
                                ])
                }
                Button {
                    showPhotoPicker = true
                } label: {
                    Text("Загрузить никому неинтересное фото")
                        .fontWeight(.medium)
                }
                .font(.title)
                .foregroundColor(.red)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func createInitialSet() -> [Image] {
    (0...5).map { index in
        Image("rofl\(index)")
    }
}

struct PhotoDetail: View {
    var image: Image
    @State private var like = false
    @State private var dislike = false
    @State private var dislikeRandom = Int.random(in:1...10000)
    @State private var likeRandom = Int.random(in:1...10000)
    
    var body: some View {
        VStack {
            image
                .resizable()
                .scaledToFit()
            Spacer()
                .frame(height: 20)
            HStack {
                Image(systemName: like ? "suit.heart.fill" : "suit.heart")
                    .foregroundColor(.red)
                    .font(.largeTitle)
                    .padding(.vertical, 5)
                    .onTapGesture {
                        if dislike {
                            dislikeRandom -= 1
                        }
                        like.toggle()
                        if like {
                            likeRandom += 1
                        } else {
                            likeRandom -= 1
                        }
                        dislike = false
                    }
                Text("\(likeRandom)")
                    .foregroundColor(.red)
                
                Image(systemName: dislike ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .onTapGesture {
                        if like {
                            likeRandom -= 1
                        }
                        dislike.toggle()
                        if dislike {
                            dislikeRandom += 1
                        } else {
                            dislikeRandom -= 1
                        }
                        like = false
                    }
                Text("\(dislikeRandom)")
                Spacer()
                
            }
            .padding(.horizontal, 25)
            
        }
    }
}



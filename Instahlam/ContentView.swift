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
                Text("INSTAHLAM")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                    .frame(height: 40)
                Text("Это ваши стремные фотки")
                    .font(.title)
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 170))
                ], spacing: 20) {
                    ForEach(0..<setOfImages.count, id: \.self) { index in
                        ZStack {
                            NavigationLink {
                                VStack {
                                    setOfImages[index]
                                        .resizable()
                                        .scaledToFit()
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
                
                Spacer()
                    .frame(height: 20)
                Button {
                    showPhotoPicker = true
                } label: {
                    Text("Загрузить никому неинтересное фото")
                        .fontWeight(.medium)
                }
                .font(.title)
                .foregroundColor(.red)
                
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



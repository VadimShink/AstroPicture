//
//  APODDetailView.swift
//  AstroPicture
//
//  Created by Vadim Shinkarenko on 05.09.2022.
//

import SwiftUI

struct APODDetailView: View {
    
    init(photoInfo: PhotoInfo, manager: MultiNetworkManager) {
        self.photoInfo = photoInfo
        self.manager = manager
    }
    
    @ObservedObject var manager: MultiNetworkManager
    
    let photoInfo: PhotoInfo
    
    var body: some View {
        VStack {
            if photoInfo.image != nil {
                Image(uiImage: self.photoInfo.image!)
                    .resizable()
                    .scaledToFit()
            } else {
                LoadingAnimation()
                    .frame(height: 400)
            }
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text(photoInfo.title).font(.headline)
                    Text(photoInfo.description)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Text(photoInfo.date).font(.title))

        .onAppear {
            self.manager.fetchImage(for: self.photoInfo)
        }
    }
}

struct APODDetailView_Previews: PreviewProvider {
    static var previews: some View {
            APODDetailView(photoInfo: PhotoInfo.createDefault(), manager: MultiNetworkManager())
    }
}

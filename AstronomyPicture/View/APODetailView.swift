//
//  APODetailView.swift
//  AstronomyPicture
//
//  Created by Andrey Kaldyaev on 02.02.2023.
//

import SwiftUI

struct APODetailView: View {
    
    let photoInfo: PhotoInfo
    @ObservedObject var manager: MultiNetworkManager
    
    init(photoInfo: PhotoInfo, manager: MultiNetworkManager) {
        print("init detail for \(photoInfo.date)")
        self.photoInfo = photoInfo
        self.manager = manager
    }

    var body: some View {
        VStack {
            if photoInfo.image != nil {
                Image(uiImage: self.photoInfo.image!)
                    .resizable()
            } else {
                LoadingAnimationBox()
                    .frame(height: 400)
            }
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text(photoInfo.title)
                        .font(.headline)
                    Text(photoInfo.description)
                }
            }.padding()
        }
        .navigationBarTitle(Text(photoInfo.date), displayMode: .inline)
        .onAppear {
            self.manager.fetchImage(for: self.photoInfo)
        }
    }
}

struct APODetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        APODetailView(photoInfo: PhotoInfo.createDefault(), manager: MultiNetworkManager())
        }
    }
}

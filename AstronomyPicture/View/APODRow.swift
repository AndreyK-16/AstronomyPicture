//
//  APODRow.swift
//  AstronomyPicture
//
//  Created by Andrey Kaldyaev on 31.01.2023.
//

import SwiftUI

struct APODRow: View {
    let photoInfo: PhotoInfo
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(photoInfo.date).bold()
            Text(photoInfo.title)
        }
    }
}

struct APODRow_Previews: PreviewProvider {
    static var previews: some View {
        APODRow(photoInfo: PhotoInfo.createDefault())
            .previewLayout(.fixed(width: 400, height: 100))
    }
}

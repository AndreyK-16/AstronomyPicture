//
//  APODListView.swift
//  AstronomyPicture
//
//  Created by Andrey Kaldyaev on 31.01.2023.
//

import SwiftUI

struct APODListView: View {
    @ObservedObject var manager = MultiNetworkManager()
    
    var body: some View {
        List {
            ForEach(manager.infos) { info in
                APODRow(photoInfo: info)
            }
        }
    }
}

struct APODListView_Previews: PreviewProvider {
    static var previews: some View {
        APODListView()
    }
}

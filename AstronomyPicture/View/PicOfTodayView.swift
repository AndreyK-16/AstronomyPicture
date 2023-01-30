//
//  PicOfTodayView.swift
//  AstronomyPicture
//
//  Created by Andrey Kaldyaev on 30.01.2023.
//

import SwiftUI

struct PicOfTodayView: View {
    
    @ObservedObject var manager = NetworkManager()
    
    var body: some View {
        VStack {
            Text(manager.photoInfo.date)
            Text(manager.photoInfo.title)
            Text(manager.photoInfo.description)
        }
    }
}

struct PicOfTodayView_Previews: PreviewProvider {
    static var previews: some View {
        PicOfTodayView()
    }
}

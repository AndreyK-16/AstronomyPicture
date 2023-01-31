//
//  PicOfTodayView.swift
//  AstronomyPicture
//
//  Created by Andrey Kaldyaev on 30.01.2023.
//

import SwiftUI

struct PicOfTodayView: View {
    
    @ObservedObject var manager = NetworkManager()
    
    @State private var showSwitchDate: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            Button {
                self.showSwitchDate.toggle()
            } label: {
                Image(systemName: "calendar")
                Text("switch day")
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
            .popover(isPresented: $showSwitchDate) {
                SelectDateView(manager: self.manager)
            }
            
            if manager.image != nil {
                Image(uiImage: self.manager.image!)
                    .resizable()
//                    .scaledToFit()
//                    .frame(maxWidth: 300)
                    .onTapGesture {
                        showSwitchDate.toggle()
                    }
            } else {
                LoadingAnimationBox()
                    .frame(height: 400)
            }
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(manager.photoInfo.date)
                            .font(.title)
                        Text(manager.photoInfo.title)
                            .font(.headline)
                        Text(manager.photoInfo.description)
                    }
                    .padding()
                }
            }
        }
}

struct PicOfTodayView_Previews: PreviewProvider {
    static var previews: some View {
        let view = PicOfTodayView()
        view.manager.photoInfo = PhotoInfo.createDefault()
        view.manager.image = UIImage(named: "TripleCometZTF_Caldera_960")
        return view
    }
}

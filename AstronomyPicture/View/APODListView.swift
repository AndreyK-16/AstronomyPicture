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
        NavigationView {
            List {
                ForEach(manager.infos) { info in
                    NavigationLink(destination: APODetailView(photoInfo: info, manager: self.manager)) {
                        APODRow(photoInfo: info)
                            .onAppear {
                                if let index = self.manager.infos.firstIndex(where: {$0.id == info.id}),
                                   index == self.manager.infos.count - 1 &&
                                    self.manager.daysFromToday == self.manager.infos.count - 1 {
                                    self.manager.getMoreDate(for: 10)
                                }
                            }
                            .navigationTitle(Text("Pichture of the Day"))
                    }
                    
                }
                
                ForEach(0..<10) { _ in
                    Rectangle()
                        .fill(.gray.opacity(0.2))
                        .frame(height: 50)
                }
            }
        }
    }
}

struct APODListView_Previews: PreviewProvider {
    static var previews: some View {
        APODListView()
    }
}

//
//  SelectDateView.swift
//  AstronomyPicture
//
//  Created by Andrey Kaldyaev on 31.01.2023.
//

import SwiftUI

struct SelectDateView: View {
    
    @State private var date = Date()
    @ObservedObject var manager: NetworkManager
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Select a day")
            DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                Text("select")
            }
            .labelsHidden()
            .pickerStyle(.segmented)
            
            Button {
                
                self.manager.date = date
                self.presentation.wrappedValue.dismiss()
            } label: {
                Text("Done")
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 8.0)
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            

        }
    }
}

struct SelectDateView_Previews: PreviewProvider {
    static var previews: some View {
        SelectDateView(manager: NetworkManager())
    }
}

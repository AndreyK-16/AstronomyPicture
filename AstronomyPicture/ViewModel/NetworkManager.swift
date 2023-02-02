//
//  NetworkManager.swift
//  AstronomyPicture
//
//  Created by Andrey Kaldyaev on 30.01.2023.
//

import Foundation
import Combine
import SwiftUI

class NetworkManager: ObservableObject {
    
    @Published var photoInfo = PhotoInfo()
    @Published var image: UIImage? = nil
    @Published var date: Date = Date()
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        
        $date // при обновлении даты обнулить картинку до ее обновления
            .removeDuplicates()
            .sink { _ in
                self.image = nil
            }
            .store(in: &subscriptions)
        
        $date //срабатывает при изменении даты через PickerData
            .removeDuplicates()
            .map({ API.createURL(for: $0) })
            .flatMap { url in
                API.crearePublisher(url: url)
            }
            .receive(on: RunLoop.main)
            .assign(to: \.photoInfo, on: self)
            .store(in: &subscriptions)
        
        $photoInfo // обновление данных
            .filter({$0.url != nil })
            .map { photoInfo -> URL in
                return photoInfo.url!
            }
            .flatMap { url in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map(\.data)
                    .catch { error in
                        return Just(Data())
                    }
            }
            .map { out -> UIImage? in
                UIImage(data: out)
            }
            .receive(on: RunLoop.main)
            .assign(to: \.image, on: self)
            .store(in: &subscriptions)
    }
}

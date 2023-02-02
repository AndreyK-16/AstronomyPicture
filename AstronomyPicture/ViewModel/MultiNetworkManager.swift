//
//  MultiNetworkManager.swift
//  AstronomyPicture
//
//  Created by Andrey Kaldyaev on 31.01.2023.
//

import Foundation
import Combine

class MultiNetworkManager: ObservableObject {
    
    @Published var infos = [PhotoInfo]()
    @Published var daysFromToday: Int = 0
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        
        $daysFromToday
            .map { daysFromToday in
                return API.create(daysFromToday: daysFromToday)
            }
            .map { date in
                return API.createURL(for: date)
            }
            .flatMap { url in
                return API.crearePublisher(url: url)
            }
            .scan([]) { particalValue, newValue in
                return particalValue + [newValue]
            }
            .tryMap({ infos in
                infos.sorted { $0.formattedDate > $1.formattedDate }
            })
            .catch { error in
                Just([PhotoInfo]())
            }
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \.infos, on: self)
            .store(in: &subscriptions)
        
        getMoreDate(for: 20)
    }
    
    func getMoreDate(for times: Int) {
        for i in 1..<times {
            self.daysFromToday += 1
        }
    }
}

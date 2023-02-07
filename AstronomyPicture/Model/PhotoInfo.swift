//
//  PhotoInfo.swift
//  AstronomyPicture
//
//  Created by Andrey Kaldyaev on 30.01.2023.
//

import Foundation
import SwiftUI

struct PhotoInfo: Codable, Identifiable {
    var title: String
    var description: String
    var url: URL?
    var copyright: String?
    var date: String
    
    let id = UUID()
    
    var image: UIImage? = nil
    
    var formattedDate: Date {
        let dateFormatter = API.createFormatter()
        return dateFormatter.date(from: self.date) ?? Date()
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "explanation"
        case url = "url"
        case copyright = "copyright"
        case date = "date"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.url = try? valueContainer.decode(URL.self, forKey: CodingKeys.url)
        self.copyright = try? valueContainer.decode(String.self, forKey: CodingKeys.copyright)
        self.date = try valueContainer.decode(String.self, forKey: CodingKeys.date)
    }
    
    init() {
        self.title = ""
        self.description = ""
        self.date = ""
    }
    
    /// функция заполняет поля PhotoInfo значениями по умолчанию
    static func createDefault() -> PhotoInfo {
        var photoInfo = PhotoInfo()
        photoInfo.title = "A Triple View of Comet ZTF"
        photoInfo.description = "Comet ZTF has a distinctive shape. The now bright comet visiting the inner Solar System has been showing not only a common dust tail, ion tail, and green gas coma, but also an uncommonly distinctive antitail. The antitail does not actually lead the comet -- it is just that the head of the comet is seen superposed on part of the fanned-out and trailing dust tail.  The giant dirty snowball that is Comet C/2022 E3 (ZTF) has now passed its closest to the Sun and tomorrow will pass its closest to the Earth. The main panel of the featured triple image shows how Comet ZTF looked last week to the unaided eye under a dark and clear sky over Cáceres, Spain.  The top inset image shows how the comet looked through binoculars, while the lower inset shows how the comet looked through a small telescope.  The comet is now visible all night long from northern latitudes but will surely fade from easy observation during the next few weeks.    Comet ZTF Gallery: Notable Submissions to APOD"
        photoInfo.date = "2023-01-31"
        photoInfo.image = UIImage(named: "default")
        return photoInfo
    }
}





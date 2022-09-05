//
//  PhotoInfo.swift
//  AstroPicture
//
//  Created by Vadim Shinkarenko on 04.09.2022.
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
    
    var formatterDate: Date {
        let dateFormatter = API.createFormatter()
        return dateFormatter.date(from: self.date) ?? Date()
        
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation"
        case url
        case copyright
        case date
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.url = try valueContainer.decode(URL.self, forKey: CodingKeys.url)
        self.copyright = try? valueContainer.decode(String.self, forKey: CodingKeys.copyright)
        self.date = try valueContainer.decode(String.self, forKey: CodingKeys.date)
    }
    
    init() {
        self.title = ""
        self.description = ""
        self.date = ""
    }
    
    static func createDefault() -> PhotoInfo {
        var photoInfo = PhotoInfo()
        photoInfo.title = "Sea and Sky Glows over the Oregon Coast"
        
        photoInfo.description = "Very step caused the sand to light up blue. That glow was bioluminescence -- a blue radiance that also lights the surf in this surreal scene captured in mid-2018 at Meyer's Creek Beach in Oregon, USA. Volcanic stacks dot the foreground sea, while a thin fog layer scatters light on the horizon. The rays of light spreading from the left horizon were created by car headlights on the Oregon Coast Highway (US 101), while the orange light on the right horizon emanates from a fishing boat.  Visible far in the distance is the band of our Milky Way Galaxy, appearing to rise from a dark rocky outcrop.  Sixteen images were added together to bring up the background Milky Way and to reduce noise.    Your Sky Surprise: What picture did APOD feature on your birthday? (post 1995)"
        
        photoInfo.date = "2022-09-04"
        photoInfo.image = UIImage(named: "preview_image")
        return photoInfo
    }
}

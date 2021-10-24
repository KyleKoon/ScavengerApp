//
//  Person.swift
//  ScavengerAppTest
//
//  Created by Ajay Bati on 10/23/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
//struct Regions: Identifiable, Codable {
//    var id: String
//    var reg: [Region] = [Region]()
//}
struct Region: Identifiable, Codable {
    var id: String
    var name: String
    var location: GeoPoint
    var value: Int
    var buildingType: String
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name = "location_name"
//        case location = "Location"
//        case value = "Value"
//        case buildingType
//    }
}

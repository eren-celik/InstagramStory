//
//  UserStoryModel.swift
//  Instagram Stories View
//
//  Created by Eren  Çelik on 9.06.2021.
//

import Foundation


struct IGStoryModel: Identifiable {
    var id = Int()
    var name : String
    var profilePicture: String
    var stories : [String]
    var seen: Bool
}

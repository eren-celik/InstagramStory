//
//  UserStoryModel.swift
//  Instagram Stories View
//
//  Created by Eren  Çelik on 9.06.2021.
//

import Foundation


struct UserStoryModel: Identifiable {
    var id = UUID()
    let name : String
    let photos : [String]
}


//MARK: Dummy Data
let stories : [UserStoryModel] =  [
UserStoryModel(name: "Mikey", photos: ["photo1","photo2" , "photo3","photo5"]),
UserStoryModel(name: "James", photos: ["photo6","photo7" , "photo8","photo9"]),
UserStoryModel(name: "Eren", photos: ["photo10", "video1", "video2"])
]

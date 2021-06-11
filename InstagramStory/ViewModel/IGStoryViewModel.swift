//
//  IGStoryViewModel.swift
//  InstagramStory
//
//  Created by Eren  Çelik on 11.06.2021.
//

import Combine
import Foundation

final class CountTimer: ObservableObject {
    @Published var progress: Double
    
    private var interval: TimeInterval
    private let publisher: Timer.TimerPublisher
    private var cancellable = Set<AnyCancellable>()
    
    init(interval: TimeInterval) {
        self.progress = 0
        self.interval = interval
        self.publisher = Timer.publish(every: 0.1, on: .main, in: .default)
    }
    
    func start(itemCount: Int){
      self.publisher
        .autoconnect()
        .sink(receiveValue: {_ in
            var newProgress = self.progress + (0.1/self.interval)
            if Int(newProgress) >= itemCount {newProgress = 0}
            self.progress = newProgress
        })
        .store(in: &cancellable)
    }
    func advancePage(by number: Int, itemCount: Int) {
        let newProgress = Swift.max((Int(self.progress) + number) % itemCount, 0)
        self.progress = Double(newProgress)
    }
}

final class IGStoryViewModel: ObservableObject {
    
    @Published var dummyData : [IGStoryModel] = [
        IGStoryModel(name: "Eren", profilePicture: "photo1", stories: ["photo10","photo2","photo3","photo5"], seen: false),
        IGStoryModel(name: "Eren", profilePicture: "photo2", stories: ["photo6","photo7","photo8","photo9"], seen: false),
        IGStoryModel(name: "Eren", profilePicture: "photo3", stories: ["photo10"], seen: false),
        IGStoryModel(name: "Eren", profilePicture: "photo4", stories: ["photo1"], seen: false),
        IGStoryModel(name: "Eren", profilePicture: "photo5", stories: ["photo1"], seen: false),
        IGStoryModel(name: "Eren", profilePicture: "photo6", stories: ["photo1"], seen: false)
    ]
    

}

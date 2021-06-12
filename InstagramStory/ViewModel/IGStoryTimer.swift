//
//  IGStoryTimer.swift
//  InstagramStory
//
//  Created by Eren  Çelik on 12.06.2021.
//

import Combine
import UIKit

final class IGStoryTimer : ObservableObject {
    @Published var progress   : Double = 0
    @Published var storiesEnd : Bool = false
    
    private let timer: Timer.TimerPublisher = Timer.publish(every: 0.1,
                                                            on: .main,
                                                            in: .default)
    private var interval: TimeInterval
    private var itemCount: Int
    private var cancellable = Set<AnyCancellable>()
    private var displayLink : CADisplayLink?

    init(interval: TimeInterval , itemCount: Int) {
        self.interval = interval
        self.itemCount = itemCount
    }
}

extension IGStoryTimer {
    
    func startTimer(){
        self.storiesEnd = false

        stopTimer()
        
        self.displayLink = .init(target: self, selector: #selector(update))
        guard let displayLink = self.displayLink else { return }
        displayLink.add(to: .current, forMode: .common)

    }
    
    @objc private func update() {
        guard let displayLink = self.displayLink else { return }
        let duration = displayLink.targetTimestamp - displayLink.timestamp
        
        var newProgress = self.progress + (duration / 5.0)
        if Int(newProgress) >= itemCount {
            self.storiesEnd = true
            newProgress = 0
        }
        self.progress = newProgress
    }
    
    func showStory(by number: Int) {
        let newProgress = Swift.max((Int(self.progress) + number) % itemCount, 0)
        self.progress = Double(newProgress)
    }
    
    func pauseTimer(){
        if self.displayLink != nil {
            self.displayLink?.invalidate()
        }
    }
    
    func resumeTimer(){
        if self.displayLink != nil {
            self.startTimer()
        }
    }
    
    func stopTimer(){
        if self.displayLink != nil {
            self.displayLink?.invalidate()
            self.displayLink = nil
        }
    }
    
    func calculateAngle(offset: CGFloat) -> Double {
        let angle = offset / (UIScreen.main.bounds.width / 2)
        let degree : CGFloat = 20
        return  Double(angle * degree)
    }
    
}

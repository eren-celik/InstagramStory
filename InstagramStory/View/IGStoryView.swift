//
//  IGStoryView.swift
//  InstagramStory
//
//  Created by Eren  Çelik on 11.06.2021.
//

import SwiftUI
import Combine

struct IGStoryView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var storyTimerViewModel: IGStoryTimer
    @Binding var storyData: IGStoryModel
    
    init(itemCount: Int, stories: Binding<IGStoryModel>) {
        self._storyData = stories
        self.storyTimerViewModel = IGStoryTimer(interval: 5, itemCount: itemCount)
    }
    
    var body: some View {
        TabView {
            ForEach(0 ..< 5) { item in
                storyView
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear{
            self.storyTimerViewModel.startTimer()
        }
        .onReceive(self.storyTimerViewModel.$storiesEnd) { output in
            if output {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    private func progressBarValue(_ value: Int) -> CGFloat {
        return min( max( (CGFloat(self.storyTimerViewModel.progress) - CGFloat(value)), 0.0) , 1.0)
    }
    
    
    private var storyView: some View {
        GeometryReader{ proxy in
            ZStack {
                GeometryReader{ geometry in
                    ZStack(alignment: .top) {
                        Image(storyData.stories[ Int(self.storyTimerViewModel.progress) ])
                            .resizable()
                            .edgesIgnoringSafeArea(.all)
                            .scaledToFill()
                            .frame(width: geometry.size.width,height: nil,alignment: .center)

                        HStack(alignment: .center, spacing: 4){
                            ForEach(storyData.stories.indices){ index in
                                LoadingBar(progress: progressBarValue(index) )
                                    .frame(height: 2, alignment:.leading)
                            }
                        }
                        .padding()
                        
                        tapNavigators
                        
                    }
                }
            }
            .frame(width: proxy.frame(in: .global).width,
                   height: proxy.frame(in: .global).height)
            .rotation3DEffect(
                .init(degrees: storyTimerViewModel.calculateAngle(offset: proxy.frame(in: .global).minX)),
                axis: (0,1,0),
                anchor: proxy.frame(in: .global).minX > 0 ? .leading : .trailing,
                perspective: 2
            )
        }
    }
    
    
    private var tapNavigators: some View {
        HStack(alignment: .center,spacing:0) {
            Rectangle()
                .foregroundColor(.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.storyTimerViewModel.showStory(by: -1)
                }
            Rectangle()
                .foregroundColor(.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.storyTimerViewModel.showStory(by: 1)
                }
        }
        .onLongPressGesture(minimumDuration: 5) { value in
            if value {
                storyTimerViewModel.pauseTimer()
            }else {
                self.storyTimerViewModel.resumeTimer()
            }
        } perform: {}
    }
}

//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        IGStoryView(itemCount: 1, stories: .constant(IGStoryModel(name: "Eren", profilePicture: "photo1", stories: ["photo10","photo2","photo3","photo5"], seen: false)))
//    }
//}

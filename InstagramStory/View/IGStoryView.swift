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
    @ObservedObject var storyViewModel : IGStoryViewModel = IGStoryViewModel()
    
    @State var storyData: IGStoryModel
    @State var storySelection : Int
    
    init(itemCount: Int, selection: Int, storyData: IGStoryModel) {
        self._storyData = State(initialValue: storyData)
        self._storySelection = State(initialValue: selection)
        self.storyTimerViewModel = IGStoryTimer(interval: 5, itemCount: itemCount)
    }
    
    var body: some View {
        TabView(selection: $storySelection) {
            ForEach(storyViewModel.dummyData) { item in
                GeometryReader { outProxy in
                    ZStack {
                        GeometryReader{ inProxy in
                            ZStack(alignment: .top) {
                                Image(storyData.stories[Int(self.storyTimerViewModel.progress)])
                                    .resizable()
                                    .edgesIgnoringSafeArea(.all)
                                    .scaledToFill()
                                    .frame(width: inProxy.size.width)
                                
                                VStack(alignment: .leading) {
                                    HStack(alignment: .center, spacing: 4){
                                        ForEach(storyData.stories.indices, id: \.self ){ index in
                                            LoadingBar(progress: self.storyTimerViewModel.progressBarValue(index) )
                                                .frame(height: 2, alignment:.leading)
                                        }
                                    }
                                    
                                    HStack {
                                        Image(storyData.profilePicture)
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .aspectRatio(contentMode: .fill)
                                            .clipShape(Circle())
                                        Text(storyData.name)
                                            .font(.title3)
                                            .foregroundColor(.white)
                                    }
                                    .padding(.top, 5)
                                }
                                .padding()
                                
                                tapNavigators
                                
                            }
                        }
                    }
                    .frame(width: outProxy.frame(in: .global).width,
                           height: outProxy.frame(in: .global).height)
                    .rotation3DEffect(
                        Angle(degrees: storyViewModel.calculateAngle(offset: outProxy.frame(in: .global).minX)),
                        axis: (0, 1, 0),
                        anchor: outProxy.frame(in: .global).minX > 0 ? .leading : .trailing,
                        perspective: 2.5
                    )
                }
                .tag(item.id)
                .onChange(of: storySelection) { onChange(value: $0) }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear(perform: onAppear)
        .onReceive(self.storyTimerViewModel.$storiesEnd) { onRecive(value: $0) }
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

extension IGStoryView {
    
    private func onChange(value: Int) {
        self.storyTimerViewModel.resetTimer(itemCount: storyData.stories.count)
        let data = storyViewModel.dummyData.filter { model in
            return model.id == value
        }
        guard let value = data.first else { return }
        self.storyData = value
    }
    
    private func onRecive(value: Published<Bool>.Publisher.Output) {
        if value {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    private func onAppear(){
        self.storyTimerViewModel.startTimer()
    }
}

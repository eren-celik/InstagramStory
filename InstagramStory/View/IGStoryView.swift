//
//  IGStoryView.swift
//  InstagramStory
//
//  Created by Eren  Çelik on 11.06.2021.
//

import SwiftUI
import Combine

struct IGStoryView: View {
    
    @ObservedObject var countTimer: CountTimer = CountTimer(interval: 5)
    @Binding var stories: [String]
    
    var body: some View {
        TabView {
            ForEach(0 ..< 5) { item in
                GeometryReader{ proxy in
                    ZStack {
                        GeometryReader{ geometry in
                            ZStack(alignment: .top) {
                                Image(stories[ Int(self.countTimer.progress) ] )
                                    .resizable()
                                    .edgesIgnoringSafeArea(.all)
                                    .scaledToFill()
                                    .frame(width: geometry.size.width,height: nil,alignment: .center)
                                    .animation(.none)
                                
                                HStack(alignment: .center, spacing: 4){
                                    ForEach(stories.indices){ image in
                                        LoadingBar(progress: min( max( (CGFloat(self.countTimer.progress) - CGFloat(image)), 0.0) , 1.0) )
                                            .frame(height: 2, alignment:.leading)
                                    }
                                }
                                .padding()
                                
                                HStack(alignment:.center,spacing:0) {
                                    
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            self.countTimer.advancePage(by: -1, itemCount: stories.count)
                                        }
                                    
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            self.countTimer.advancePage(by: 1, itemCount: stories.count)
                                        }
                                }
                            }
                            .onAppear{
                                self.countTimer.start(itemCount: stories.count)
                                print(stories)
                            }
                        }
                    }
                    .frame(width: proxy.frame(in: .global).width,
                           height: proxy.frame(in: .global).height)
                    .rotation3DEffect(
                        .init(degrees: calculateAngle(offset: proxy.frame(in: .global).minX)),
                        axis: (0,1,0),
                        anchor: proxy.frame(in: .global).minX > 0 ? .leading : .trailing,
                        perspective: 2
                )
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
    
    func calculateAngle(offset: CGFloat) -> Double {
        let angle = offset / (UIScreen.main.bounds.width / 2)
        let degree : CGFloat = 20
        return  Double(angle * degree)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IGStoryView(stories: .constant([""]))
    }
}

//
//  MainView.swift
//  InstagramStory
//
//  Created by Eren  Çelik on 11.06.2021.
//

import SwiftUI



struct MainView : View {
    @State var gestureValue: CGFloat = 0
    @ObservedObject private var viewModel = IGStoryViewModel()
    @State private var show  : Bool = false
    @State private var showStory: IGStoryModel?
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(.fixed(40))]) {
                        HStack {
                            ForEach(viewModel.dummyData) { item in
                                ProfileImageView(data: .constant(item))
                                    .onTapGesture {
                                        showStory = item
                                        withAnimation(.easeInOut) {
                                            self.show.toggle()
                                        }
                                    }
                            }
                        }
                    }
                }
                .frame(height: 120)
                
                Spacer()
            }
            .navigationTitle("Instagram")
            .sheet(item: $showStory) { value in
                IGStoryView(stories: .constant(value.stories))
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
            MainView()
    }
}



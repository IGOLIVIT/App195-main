//
//  BookmarksView.swift
//  App195
//
//  Created by Вячеслав on 9/14/23.
//

import SwiftUI

struct BookmarksView: View {
    
    @StateObject var viewModel = TodayViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Offline Bookmarks")
                    .foregroundColor(.black)
                    .font(.system(size: 25, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                if viewModel.saved_news.isEmpty {
                    
                    VStack(alignment: .leading) {
                        
                        Image("empty")
                        
                        Text("No Bookmarks saved")
                            .foregroundColor(.black)
                            .font(.system(size: 19, weight: .semibold))
                        
                        Text("Sign in and save your first article so you can return to it later")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                    .padding()
                     
                } else {
                    
                    ScrollView(.vertical, showsIndicators: true) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.news.filter{viewModel.saved_news.contains($0.resultTitle ?? "")}, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.selectedNews = index
                                    viewModel.isDetail = true
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        VStack(alignment: .leading, content: {
                                            
                                            Text(index.resultDateTime ?? "")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 13, weight: .regular))
                                            
                                            Text(index.resultTitle ?? "")
                                                .foregroundColor(.black)
                                                .font(.system(size: 15, weight: .medium))
                                                .lineLimit(2)
                                                .multilineTextAlignment(.leading)
                                            
                                            Text(index.resultText ?? "")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 13, weight: .regular))
                                                .lineLimit(3)
                                                .multilineTextAlignment(.leading)
                                        })
                                        
                                        Spacer()
                                        
                                        WebPic(urlString: index.resultImage ?? "", width: 100, height: 100, cornerRadius: 5, isPlaceholder: true)
                                    }
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                                })
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .onAppear {
            
            viewModel.getNews()
        }
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            if let index = viewModel.selectedNews {
                
                NewsDetail(index: index)
            }
        })
    }
}

struct BookmarksView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarksView()
    }
}

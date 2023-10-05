//
//  TodayView.swift
//  App195
//
//  Created by Вячеслав on 9/14/23.
//

import SwiftUI

struct TodayView: View {
    
    @StateObject var viewModel = TodayViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Today")
                    .foregroundColor(.black)
                    .font(.system(size: 25, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                if viewModel.isLoading {
                    
                    ProgressView()
                        .frame(maxHeight: .infinity, alignment: .center)
                    
                } else {
                    
                    if viewModel.news.isEmpty {
                        
                        VStack(alignment: .leading) {
                            
                            Image("empty")
                            
                            Text("News")
                                .foregroundColor(.black)
                                .font(.system(size: 19, weight: .semibold))
                            
                            Text("No any news we have")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .frame(maxHeight: .infinity, alignment: .center)
                        
                    } else {
                        
                        ScrollView(.vertical, showsIndicators: true) {
                            
                            LazyVStack {
                                
                                ForEach(viewModel.news, id: \.self) { index in
                                    
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

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}

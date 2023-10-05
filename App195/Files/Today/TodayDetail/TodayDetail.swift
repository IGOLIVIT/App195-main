//
//  TodayDetail.swift
//  App195
//
//  Created by Вячеслав on 9/14/23.
//

import SwiftUI

struct NewsDetail: View {
    
    @AppStorage("saved_news") var saved_news: [String] = []
    
    let index: TodayItem
    
    var body: some View {
        
        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                ScrollView(.vertical, showsIndicators: true) {
                    
                    LazyVStack {
                        
                        WebPic(urlString: index.resultImage ?? "", width: .infinity, height: 250, cornerRadius: 0, isPlaceholder: true)
                        
                        VStack(alignment: .leading, content: {
                            
                            HStack(content:  {
                                
                                Text(index.resultDateTime ?? "")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12, weight: .regular))
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                    if saved_news.contains(index.resultTitle ?? "") {
                                        
                                        if let index = saved_news.firstIndex(of: index.resultTitle ?? "") {
                                            
                                            saved_news.remove(at: index)
                                        }
                                        
                                    } else {
                                        
                                        saved_news.append(index.resultTitle ?? "")
                                    }
                                    
                                }, label: {
                                    
                                    Image(systemName: saved_news.contains(index.resultTitle ?? "") ? "bookmark.fill" : "bookmark")
                                        .foregroundColor(saved_news.contains(index.resultTitle ?? "") ? Color("primary") : .gray)
                                        .font(.system(size: 16, weight: .medium))
                                })
                            })
                            .padding(.bottom, 1)
                            
                            Text(index.resultTitle ?? "")
                                .foregroundColor(.black)
                                .font(.system(size: 19, weight: .semibold))
                            
                            Text(index.resultText ?? "")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct NewsDetail_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetail(index: TodayItem(resultId: 0, resultTitle: "Testy1", resultImage: "https://cnews24.ru/uploads/b84/b84c4173deb030c035075d91ea7f84a0830aa501.jpg", resultMark: "", resultDateTime: "13.02.5002", resultText: "fgdgdfsgdfsgdfsgdfsgdfdfs", resultTotalLikes: 0, resultTotalComments: 0))
    }
}

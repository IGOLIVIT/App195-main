//
//  RankingsView.swift
//  App195
//
//  Created by Вячеслав on 9/14/23.
//

import SwiftUI

struct RankingsView: View {
    
    @StateObject var viewModel = RankingsViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Rankings")
                    .foregroundColor(.black)
                    .font(.system(size: 25, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Text("My News")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .regular))
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                if viewModel.rankings.isEmpty {
                    
                    VStack(alignment: .leading) {
                        
                        Image("empty")
                        
                        Text("No news added")
                            .foregroundColor(.black)
                            .font(.system(size: 19, weight: .semibold))
                        
                        Text("Add your first post to save your result")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                    .padding()
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: true) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.rankings, id: \.self) { index in
                                
                                HStack {
                                    
                                    Text(index.name ?? "")
                                        .foregroundColor(.black)
                                        .font(.system(size: 16, weight: .medium))
                                    
                                    Spacer()
                                    
                                    Text("+$\(index.income)")
                                        .foregroundColor(.green)
                                        .font(.system(size: 13, weight: .medium))
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                            }
                        }
                        .padding()
                    }
                }
            }
            
            VStack {
                
                Spacer()
                
                Button(action: {
                    
                    viewModel.isAdd = true
                    
                }, label: {
                    
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium))
                        .padding(15)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                })
            }
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            RankingsAdd(viewModel: viewModel)
        })
        .onAppear {
            
            viewModel.fetchRankings()
        }
    }
}

struct RankingsView_Previews: PreviewProvider {
    static var previews: some View {
        RankingsView()
    }
}

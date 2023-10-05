//
//  RankingsAdd.swift
//  App195
//
//  Created by Вячеслав on 9/14/23.
//

import SwiftUI

struct RankingsAdd: View {
    
    @StateObject var viewModel: RankingsViewModel
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Add News")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .medium))
                    
                    HStack {
                        
                        Button(action: {
                            
                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .medium))
                        })
                        
                        Spacer()
                    }
                }
                .padding()
                
                ScrollView(.vertical, showsIndicators: true) {
                    
                    LazyVStack(spacing: 35) {
                        
                        VStack(alignment: .leading, content: {
                            
                            Text("Name")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter name")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.name.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.name)
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .regular))
                            })
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                        })
                        
                        VStack(alignment: .leading, content: {
                            
                            Text("Date")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text(Date().convertDate(format: "MMM d"))
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                            })
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                        })
                        
                        VStack(alignment: .leading, content: {
                            
                            Text("Your Income")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                            
                            HStack {
                                
                                ZStack(alignment: .leading, content: {
                                    
                                    Text("Enter income")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 15, weight: .regular))
                                        .opacity(viewModel.amount.isEmpty ? 1 : 0)
                                    
                                    TextField("", text: $viewModel.amount)
                                        .foregroundColor(.black)
                                        .font(.system(size: 15, weight: .regular))
                                        .keyboardType(.decimalPad)
                                })
                                
                                Button(action: {
                                    
                                    viewModel.isPairs = true
                                    
                                }, label: {
                                    
                                    Text(viewModel.pair.isEmpty ? "PAIR" : viewModel.pair)
                                        .foregroundColor(.white)
                                        .font(.system(size: 13, weight: .medium))
                                        .padding(6)
                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                                })
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                        })
                    }
                    .padding()
                }
                
                Spacer()
                
                Button(action: {
                    
                    viewModel.addRankings {
                        
                        router.wrappedValue.dismiss()
                        
                        viewModel.fetchRankings()
                    }
                    
                }, label: {
                    
                    Text("Create")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                        .padding()
                })
                .opacity(viewModel.name.isEmpty || viewModel.amount.isEmpty || viewModel.pair.isEmpty ? 0.5 : 1)
                .disabled(viewModel.name.isEmpty || viewModel.amount.isEmpty || viewModel.pair.isEmpty ? true : false)
            }
        }
        .sheet(isPresented: $viewModel.isPairs, content: {
            
            RankingsPairs(pair: $viewModel.pair)
        })
        .sheet(isPresented: $viewModel.isChart, content: {
            
            RankingsChart(pair: viewModel.pair)
        })
        .onChange(of: viewModel.pair, perform: { _ in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                
                viewModel.isChart = true
            }
        })
    }
}

struct RankingsAdd_Previews: PreviewProvider {
    static var previews: some View {
        RankingsAdd(viewModel: RankingsViewModel())
    }
}

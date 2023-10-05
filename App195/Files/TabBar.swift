//
//  TabBar.swift
//  App195
//
//  Created by Вячеслав on 9/14/23.
//

import SwiftUI

struct TabBar: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        
        HStack {
            
            ForEach(Tab.allCases, id: \.self) { index in
                
                Button(action: {
                    
                    selectedTab = index
                    
                }, label: {
                    
                    VStack(alignment: .center, spacing: 7, content: {
                        
                        Image(index.rawValue)
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == index ? Color("primary") : .gray)
                        
                        Text(index.rawValue)
                            .foregroundColor(selectedTab == index ? Color("primary") : .gray)
                            .font(.system(size: 11, weight: .medium))
                    })
                    .frame(maxWidth: .infinity)
                })
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.top, 9)
        .padding(.bottom, 31)
        .background(Color.gray.opacity(0.05))
    }
}

enum Tab: String, CaseIterable {
    
    case Today = "Today"
    
    case Bookmarks = "Bookmarks"
    
    case Rankings = "Rankings"
    
    case Settings = "Settings"
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

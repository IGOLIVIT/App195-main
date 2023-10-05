//
//  RankingsChart.swift
//  App195
//
//  Created by Вячеслав on 9/14/23.
//

import SwiftUI

struct RankingsChart: View {
    
    let pair: String
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Chart(pair: pair)
                    .disabled(true)
                
                Spacer()
            }
        }
    }
}

struct RankingsChart_Previews: PreviewProvider {
    static var previews: some View {
        RankingsChart(pair: "EURUSD")
    }
}

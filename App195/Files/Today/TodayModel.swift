//
//  TodayModel.swift
//  App195
//
//  Created by Вячеслав on 9/14/23.
//

import SwiftUI

struct TodayModel: Codable, Hashable {

    var results: [TodayItem]
}

struct TodayItem: Codable, Hashable {
    
    var resultId: Int?
    
    var resultTitle: String?
    var resultImage: String?
    
    var resultMark: String?
    var resultDateTime: String?
    
    var resultText: String?
    
    var resultTotalLikes: Int?
    var resultTotalComments: Int?
}

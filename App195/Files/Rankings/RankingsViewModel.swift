//
//  RankingsViewModel.swift
//  App195
//
//  Created by Вячеслав on 9/14/23.
//

import SwiftUI
import CoreData

final class RankingsViewModel: ObservableObject {
    
    @Published var rankings: [RankingsModel] = []
    
    @Published var name: String = ""
    @Published var amount: String = ""
    @Published var pair: String = ""
    @Published var pairs: [String] = ["EURUSD", "EURTRY", "EURRUB", "EURJPY", "EURCAD"]
    
    @Published var isAdd: Bool = false
    @Published var isPairs: Bool = false
    @Published var isChart: Bool = false
    
    func addRankings(completion: @escaping () -> (Void)) {
        
        CoreDataStack.shared.modelName = "RankingsModel"
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let trans = NSEntityDescription.insertNewObject(forEntityName: "RankingsModel", into: context) as! RankingsModel
        
        trans.name = name
        trans.income = Int16(amount) ?? 0
        trans.pair = pair
        trans.date = Date()
        
        CoreDataStack.shared.saveContext()
        
        completion()
    }
    
    func fetchRankings() {
        
        CoreDataStack.shared.modelName = "RankingsModel"
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<RankingsModel>(entityName: "RankingsModel")

        do {
            
            let branch = try context.fetch(fetchRequest)
            
            self.rankings = branch
            
        } catch let error as NSError {
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.rankings = []
        }
    }
}

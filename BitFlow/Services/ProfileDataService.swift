//
//  ProfileDataService.swift
//  BitFlow
//
//  Created by Macbook Pro on 16/08/2025.
//

import Foundation
import CoreData

class ProfileDataService{
    
    // main thread to manage coreData
    private let container: NSPersistentContainer
    
    private let containerName: String = "ProfileContainer"
    private let entityName: String = "ProfileEntity"
    
    // to save entities in coreData
    @Published var savedEntities : [ProfileEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error{
                print("Error in loading CoreData! \(error)")
            }
            // initially load profile
            self.getProfile()
        }
    }
    
    // public method
    func updateProfile(coin:CoinModel, amount:Double){
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }){
            if amount > 0{
                update(entity: entity, amount: amount)
            }else{
                delete(entity: entity)
            }
        }else{
            add(coin: coin, amount: amount)
        }
    }
    
    
    // private methods
    private func getProfile(){
        let request = NSFetchRequest<ProfileEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching profile entities! \(error)")
        }
    }
    
    private func add(coin:CoinModel ,amount:Double){
        let entity = ProfileEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func save(){
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving core data! \(error)")
        }
    }
    
    
    
    private func applyChanges(){
        save()
        getProfile()
    }
    
    private func update(entity: ProfileEntity, amount:Double){
        entity.amount = amount
        applyChanges()
    }
    
    
    private func delete(entity:ProfileEntity){
        
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    
    
}


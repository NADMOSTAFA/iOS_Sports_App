//
//  DBManager.swift
//  SportsApp
//
//  Created by Apple on 13/05/2024.
//

import Foundation
import CoreData

enum LeagueKeys : String{
    case leagueTable = "LeagueEntity"
    case leagueKey = "leagueKey"
    case leagueName = "leagueName"
    case leagueLogo = "leagueLogo"
}

protocol DBManagerProtocol{
    func insertLeague(league :League)
    func getAllLeagues() -> [League]
}

class DBManager : DBManagerProtocol{
    static let instance = DBManager()
    
    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SportsApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    
    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - CRUD Operations
    
    func insertLeague(league :League) {
        let context = persistentContainer.viewContext
        let leagueEntity = NSEntityDescription.entity(forEntityName: LeagueKeys.leagueTable.rawValue, in: context)
        let leagueObject = NSManagedObject(entity: leagueEntity!, insertInto: context)
        leagueObject.setValue(league.leagueKey, forKey: LeagueKeys.leagueKey.rawValue)
        leagueObject.setValue(league.leagueName, forKey: LeagueKeys.leagueName.rawValue)
        leagueObject.setValue(league.leagueLogo, forKey: LeagueKeys.leagueLogo.rawValue)
        saveContext()
    }
    
    
    
    func getAllLeagues() -> [League] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: LeagueKeys.leagueTable.rawValue)
        do {
            let results = try context.fetch(fetchRequest)
            let leagues: [League] = results.compactMap { result in
                guard
                    let leagueKey = (result as? NSManagedObject)?.value(forKey: LeagueKeys.leagueKey.rawValue) as? Int,
                    let leagueName = (result as? NSManagedObject)?.value(forKey: LeagueKeys.leagueName.rawValue) as? String,
                    let leagueLogo = (result as? NSManagedObject)?.value(forKey:  LeagueKeys.leagueLogo.rawValue) as? String
                else {
                    return League()
                }
                return League(leagueKey: leagueKey, leagueName: leagueName, leagueLogo: leagueLogo)
            }
            return leagues
        } catch {
            print("Failed to fetch leagues: \(error)")
            return []
        }
    }
}

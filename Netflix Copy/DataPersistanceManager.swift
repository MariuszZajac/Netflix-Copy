//
//  DataPersistanceManager.swift
//  Netflix Copy
//
//  Created by Mariusz Zając on 29/10/2022.
//

import Foundation
import UIKit
import CoreData


class DataPersistanceManager {
    
    enum DatabaseError: Error {
        case failedToSaveData
    }
    static let shared = DataPersistanceManager()
    
    func downloadTitleWith(model: Title, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as?  AppDelegate else {
            return
            
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = TitleItem(context: context)
        
        item.original_title = model.original_title
        item.id = Int64(model.id)
        item.original_name = model.original_name
        item.overview = model.overview
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count)
        item.vote_average = model.vote_average
        
        do {
            try context.save()
            completion(.success(())) //void metod simple tip
        } catch {
            completion(.failure(DatabaseError.failedToSaveData))
        }
        
    }
    func fatchingTitlesFromDataBase(completion: @escaping (Result<[TitleItem], Error>) -> Void){
        
    }
}

    



//
//  coreDataManager.swift
//  ToDoList
//
//  Created by NTGMM-02 on 02/08/18.
//  Copyright © 2018 NTGMM-02. All rights reserved.
//

import CoreData
@available(iOS 10.0, *)
struct coreDataManager{
    static let shared = coreDataManager()
    let persistantConatiner:NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoList")
        container.loadPersistentStores(completionHandler: { (storeDiscription, error) in
            if error != nil{
                print(error!)
                return
            }
        })
        return container
    }()
    
func createToDo(id:Double,title:String,status:Bool){
    let context = persistantConatiner.viewContext
    let toDo = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: context)
    toDo.setValue(id,forKey:"id")
    toDo.setValue(title,forKey:"title")
    toDo.setValue(status,forKey:"status")
    
    do{
        try context.save()
    }catch let err{
        print("failed to save context with new toDo:",err)
       }
    }
    func deleteToDo(id:Double){
       let context = persistantConatiner.viewContext
        let fetchRequest = NSFetchRequest<ToDo>(entityName: "ToDo")
        do{
            let toDos = try context.fetch(fetchRequest)
            toDos.forEach { (data) in
              if  data.id == id{
                context.delete(data)
                }
            }
        }catch let err{
            print(err)
        }
    }
    func fetchToDo()->[ToDo]{
        let context = persistantConatiner.viewContext
        let fetchRequest = NSFetchRequest<ToDo>(entityName:"ToDo")
        do{
            let todos = try context.fetch(fetchRequest)
            return todos
        }catch let err{
            print(err)
            return []
        }
    }
    
    
    
    
    
}

//
//  Handler.swift
//  S.O.L.I.D principle iOS
//
//  Created by Ajeet on 26/08/20.
//  Copyright © 2020 Personal. All rights reserved.
//

// ##########  Problem ######
/* The Single Responsibility Principle (SRP)
 "A class should have one, and only one, reason to change."

 */
class DataHandler {
    
    func handle() {
        let data = requestDataToAPI()
        let array = parse(data: data)
        saveToDB(array: array)
    }
    private func requestDataToAPI() -> Data {
        // send API request and wait the response
    }
    private func parse(data: Data) -> [String] {
        // parse the data and create the array
    }
    private func saveToDB(array: [String]) {
        // save the array in a database (CoreData/Realm/...)
    }
}

/*
 ######## Solution
 How many responsibilities does this class have?

 (1) DataHandler retrieves the data from the API
 (2) Parses the API response, creating an array of String
 (3) Saves the array in a database
 
 Failing the First Principle of S.O.L.I.D that is "The Single Responsibility Principle (SRP)"
 
 You can solve this problem break down the responsibilities to each classes:

 */
class DataHandlerV {
    let apiHandler: APIHandler
    let parseHandler: ParseHandler
    let dbHandler: DBHandler
    init(apiHandler: APIHandler, parseHandler: ParseHandler, dbHandler: DBHandler) {
        self.apiHandler = apiHandler
        self.parseHandler = parseHandler
        self.dbHandler = dbHandler
    }
    func handle() {
        let data = apiHandler.requestDataToAPI()
        let array = parseHandler.parse(data: data)
        dbHandler.saveToDB(array: array)
    }
    func save(string: String) {
        // Save string in the Cloud
    }
}
class APIHandler {
    func requestDataToAPI() -> Data {
        // send API request and wait the response
    }
}
class ParseHandler {
    func parse(data: Data) -> [String] {
        // parse the data and create the array
    }
}
class DBHandler {
    func saveToDB(array: [String]) {
        // save the array in a database (CoreData/Realm/...)
    }
}


/*
 The Liskov Substitution Principle (LSP):
 "Derived classes must be substitutable for their base classes."
                                    or
 "Functions that use pointers of references to base classes must be able to use objects of derived classes without knowing it"
 
 ####Problem
 Inheritance may be dangerous.
 
 ### Solution
 We have a class Handler, it has the responsibility to save a string in a DB. Then, the business logic changes, and, sometimes, you must save the string just if its length is greater than six. Therefore, we decide to create a subclass FilteredHandler like below
 */

class FilteredHandler: DataHandlerV {
    override func save(string: String) {
        guard string.count > 6 else { return }
        super.save(string: string)
    }
}

// But this example breaks LSP because, in the subclass, we add the precondition that string must have a length greater than 6. A client of DataHandlerV doesn’t expect that FilteredHandler has a different precondition, since it should be the same for DataHandlerV and all its subclasses.

//We can solve this problem getting rid of FilteredHandler and adding a new parameter to inject the minimum length of characters to filter. No need to inherit


func save(string: String, minChars: Int = 0) {
       guard string.count >= minChars else { return }
       // Save string in the Cloud
   }

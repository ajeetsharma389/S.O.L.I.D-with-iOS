//
//  Logger.swift
//  S.O.L.I.D principle iOS
//
//  Created by Ajeet on 26/08/20.
//  Copyright © 2020 Personal. All rights reserved.
//

/*
 The Open-Closed Principle (OCP)
 "Software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification."
 
 // ##########  Problem ######
 If you want to create a class that is easy to maintain, it must have two important characteristics:

 1) Open for extension: You should be able to extend or change the behaviors of a class without efforts.
 2) Closed for modification: You can extend a class without changing the implementation.
 
 */
class PrintLogger {
    
    func printData() {
        let vehicles = [
                        Vehicle(name: "Honda", color: "Black"),
                        Vehicle(name: "Maruti", color: "Red"),
                        Vehicle(name: "Amaze", color: "Blue")
                       ]
        
        vehicles.forEach { vehicle in
            print(vehicle.printDetails())
        }
    }
}
class Vehicle {
    let name: String
    let color: String
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    func printDetails() -> String {
        return "I am \(name) and my color is \(color)"
    }
}
/*
 If you want to add the possibility to print also the details of a some new class, we would have to change the implementation of printData of PrintLogger class every time we want to log a new class so breaking OCP
 
 We can solve this problem creating a new 'protocol' Printable, which will be implemented by the classes to log. Finally, printData will print an array of Printable.

 In this way, we create a new abstract layer between printData and the class to log, allowing the print of other classes like Bicycle and without changing the printData implementation.
 */
// ###### Solution ######
protocol Printable {
    func printDetails() -> String
}
class Logger {
    func printData() {
        let cars = [
                        Car(name: "Honda", color: "Black"),
                        Car(name: "Maruti", color: "Red"),
                        Car(name: "Amaze", color: "Blue")
                    ]
        
        cars.forEach { car in
            print(car.printDetails())
        }
    }
}
class Car: Printable {
    let name: String
    let color: String
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    func printDetails() -> String {
        return "I'm \(name) and my color is \(color)"
    }
}
class Bicycle: Printable {
    let type: String
    init(type: String) {
        self.type = type
    }
    func printDetails() -> String {
        return "I'm a \(type)"
    }
}

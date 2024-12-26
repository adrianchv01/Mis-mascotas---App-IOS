//
//  Mascota+CoreDataProperties.swift
//  Proyect-Vet
//
//  Created by DAMII on 22/12/24.
//
//

import Foundation
import CoreData


extension Mascota {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mascota> {
        return NSFetchRequest<Mascota>(entityName: "Mascota")
    }

    @NSManaged public var nombre: String?
    @NSManaged public var tipo: String?
    @NSManaged public var raza: String?
    @NSManaged public var sexo: String?

}

extension Mascota : Identifiable {

}

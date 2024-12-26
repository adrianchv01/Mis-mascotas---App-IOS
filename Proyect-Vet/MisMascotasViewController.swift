//
//  MisMascotasViewController.swift
//  Proyect-Vet
//
//  Created by DAMII on 22/12/24.
//

import UIKit
import CoreData

class MisMascotasViewController: UIViewController, UITableViewDelegate,
                                 UITableViewDataSource {
    
    
    
    @IBOutlet weak var listMascotatableView: UITableView!
    
    
    var mascotasData = [Mascota]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mis Mascotas"
        showData()
        configureTableView()
        listMascotatableView.delegate = self
        listMascotatableView.dataSource = self

        
          
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listMascotatableView.reloadData()
    }
    
    //funcion para conectar la base de dajos
    func connectBD() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    //para la configuracion de la table
    func configureTableView() {
        listMascotatableView.delegate = self
        listMascotatableView.dataSource = self
        listMascotatableView.rowHeight = 140
        }
    
    func showData() {
        let context = connectBD()
        let fethRequest: NSFetchRequest<Mascota> = Mascota.fetchRequest()
        
        
        
        do {
            mascotasData = try context.fetch(fethRequest)
            print("Se mostraron los datos en la tabla")
        } catch let error as NSError {
            print("Error al mostrar: \(error.localizedDescription)")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mascotasData.count
    }
    
    //conectar con la configuracion de la celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MascotaTableViewCell", for: indexPath) as? MascotaTableViewCell
        let mascotas = mascotasData[indexPath.row]
        cell?.configureMascota(mascota: mascotas, viewController: self)
        return cell ?? UITableViewCell()
    }
    
    //para poder eliminar la mascota de la base de datos
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let context = connectBD()
        let mascota = mascotasData[indexPath.row]
        if editingStyle == .delete {
            context.delete(mascota)
            do {
                try context.save()
                print("Se elimino la mascota")
            } catch let error as NSError {
                print("Error al eliminar la mascota: \(error.localizedDescription)")
            }
        }
        showData()
        tableView.reloadData()
    }
    
    

      //Es para recargar los datos de la lista
    func cargarMascotass() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<Mascota> = Mascota.fetchRequest()
        do {
            mascotasData = try context.fetch(fetchRequest)
            listMascotatableView.reloadData()
            } catch {
                print("Error al cargar mascotas: \(error)")
                }
            }
    @IBAction func btnActualizar(_ sender: Any) {
            cargarMascotass()
        }
    
}

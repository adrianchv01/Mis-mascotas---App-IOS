//
//  RegisterMascotaViewController.swift
//  Proyect-Vet
//
//  Created by DAMII on 22/12/24.
//

import UIKit
import CoreData
class RegisterMascotaViewController: UIViewController {
    
    
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var txtRaza: UITextField!
    
    
    @IBOutlet weak var txtNombreCliente: UITextField!
    
    @IBOutlet weak var txtEdad: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnRegistrar(_ sender: Any) {
        
        guard let nombre = txtNombre.text, !nombre.isEmpty,
                      let raza = txtRaza.text, !raza.isEmpty,
                      let nombreCliente = txtNombreCliente.text, !nombreCliente.isEmpty,
                      let edad = txtEdad.text, !edad.isEmpty else {
                    mostrarAlerta(titulo: "Error", mensaje: "Por favor, completa todos los campos.")
                    return
                }
                
                // Guardar los datos en Core Data
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let nuevaMascota = NSEntityDescription.insertNewObject(forEntityName: "Mascota", into: context)
                nuevaMascota.setValue(nombre, forKey: "nombre")
                nuevaMascota.setValue(raza, forKey: "raza")
                nuevaMascota.setValue(nombreCliente, forKey: "nombreCliente")
                nuevaMascota.setValue(edad, forKey: "tipo") // Usando "tipo" para almacenar la edad
                
                do {
                    try context.save()
                    mostrarAlerta(titulo: "Éxito", mensaje: "Mascota registrada correctamente.") {
                        // Redirigir a la pantalla anterior
                        self.navigationController?.popViewController(animated: true)
                    }
                } catch {
                    print("Error al guardar mascota: \(error)")
                    mostrarAlerta(titulo: "Error", mensaje: "No se pudo registrar la mascota. Inténtalo de nuevo.")
                }
            }
            
            // Función para mostrar alertas
            private func mostrarAlerta(titulo: String, mensaje: String, accion: (() -> Void)? = nil) {
                let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    accion?()
                }))
                self.present(alerta, animated: true)
            }
   
}

//
//  loginViewController.swift
//  Proyect-Vet
//
//  Created by DAMII on 22/12/24.
//

import UIKit
import CoreData

class loginViewController: UIViewController {
    
    
    
    @IBOutlet weak var txtUsernameTxt: UITextField!
    
    @IBOutlet weak var txtPasswordTxt: UITextField!
    
    override func viewDidLoad() {
            super.viewDidLoad()
        //apra ocultar la contraseña
            txtPasswordTxt.isSecureTextEntry = true
        }
    
        @IBAction func didTapLogin(_ sender: Any) {
            // para validar que los camnpos no esten vacios
            guard let username = txtUsernameTxt.text, !username.isEmpty,
                  let password = txtPasswordTxt.text, !password.isEmpty else {
                mostrarAlerta(titulo: "Error", mensaje: "Por favor, completa todos los campos.")
                return
            }

            // obtener los datos del core data
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext

            // para buscar el usuario dentro del core data
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Usuarios")
            fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
            
            //do para buscar el usuario en caso de manejo de error
            do {
                let usuarios = try context.fetch(fetchRequest)
                if usuarios.isEmpty {
                    mostrarAlerta(titulo: "Error", mensaje: "Credenciales incorrectas.")
                } else {
                    // redirigir al MisMascotasViewController
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let misMascotasVC = storyboard.instantiateViewController(withIdentifier: "MisMascotasViewController") as? MisMascotasViewController {
                        self.navigationController?.pushViewController(misMascotasVC, animated: true)
                    }
                }
            } catch {
                print("Error al buscar usuario: \(error)")
                mostrarAlerta(titulo: "Error", mensaje: "Ocurrió un problema al iniciar sesión. Inténtalo de nuevo.")
            }
        }

        // pra mostrar alertas
        private func mostrarAlerta(titulo: String, mensaje: String) {
            let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alerta, animated: true)
        }
    
    
    
}
    
    



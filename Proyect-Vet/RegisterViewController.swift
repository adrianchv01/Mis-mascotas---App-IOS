//
//  RegisterViewController.swift
//  Proyect-Vet
//
//  Created by DAMII on 22/12/24.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtUsernameTxt: UITextField!
    @IBOutlet weak var txtPasswordTxt: UITextField!
    
    @IBOutlet weak var txtConfirmPasswordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Aqui se esta oculando las contraseñas
        txtPasswordTxt.isSecureTextEntry = true
        txtConfirmPasswordTxt.isSecureTextEntry = true
        // Mi simulador estaba fallando y que se permita que le recomiende contraseñas
        txtPasswordTxt.textContentType = .newPassword
        txtConfirmPasswordTxt.textContentType = .newPassword
                
        txtPasswordTxt.autocorrectionType = .no
        txtConfirmPasswordTxt.autocorrectionType = .no


    }

    //Aqui se validan los campos en caso esten vacios o no
    @IBAction func registrarUsuario(_ sender: Any) {
        
        guard let username = txtUsernameTxt.text, !username.isEmpty,
              let password = txtPasswordTxt.text, !password.isEmpty,
              let confirmPassword = txtConfirmPasswordTxt.text, !confirmPassword.isEmpty else {
            mostrarAlerta(titulo: "Error", mensaje: "Por favor, completa todos los campos.")
            return
        }

        // Aqui se validan los campos en caso no coincidan
        guard password == confirmPassword else {
            mostrarAlerta(titulo: "Error", mensaje: "Las contraseñas no coinciden.")
            return
        }

        // Conexion con coredata
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        // para crear un objeto
        let nuevoUsuario = NSEntityDescription.insertNewObject(forEntityName: "Usuarios", into: context)
        nuevoUsuario.setValue(username, forKey: "username")
        nuevoUsuario.setValue(password, forKey: "password")

        // para guardar el usuario
        do {
            try context.save()
            mostrarAlerta(titulo: "Éxito", mensaje: "Usuario registrado correctamente.") {
                // es para redirigir a la pantalla inicial
                self.navigationController?.popViewController(animated: true)
            }
        } catch {
            print("Error al guardar usuario: \(error)")
            mostrarAlerta(titulo: "Error", mensaje: "No se pudo registrar el usuario. Inténtalo de nuevo.")
        }
    }

    // motras alernas
    private func mostrarAlerta(titulo: String, mensaje: String, accion: (() -> Void)? = nil) {
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            accion?()
        }))
        self.present(alerta, animated: true)
    }
}

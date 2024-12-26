//
//  MascotaTableViewCell.swift
//  Proyect-Vet
//
//  Created by DAMII on 22/12/24.
//

import UIKit

class MascotaTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nombreLabel: UILabel!
    
    @IBOutlet weak var razaLabel: UILabel!
    
    
    @IBOutlet weak var nombreCliente: UILabel!
    
    
    @IBOutlet weak var edadLabel: UILabel!
    
    var mascota: Mascota?
    var viewcontroller: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //esto es lo que saldra en la celda con la informacion
    func configureMascota(mascota: Mascota, viewController: UIViewController){
        
        self.nombreLabel.text = "Nombre: \(mascota.nombre ?? "")"
        self.nombreCliente.text = "Nombre del cliente: \(mascota.nombreCliente ?? "")"
        self.razaLabel.text = "Raza: \(mascota.raza ?? "")"
        self.edadLabel.text = "Edad: \(mascota.tipo ?? "")"
        self.mascota = mascota
        self.viewcontroller = viewController
        
    }

}

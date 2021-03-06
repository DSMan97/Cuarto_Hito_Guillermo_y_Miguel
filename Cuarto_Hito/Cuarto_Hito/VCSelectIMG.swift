//
//  VCSelectIMG.swift
//  Cuarto_Hito
//
//  Created by GUILLERMO CRESPO AGUAYO on 18/5/18.
//  Copyright © 2018 GUILLERMO CRESPO AGUAYO. All rights reserved.
//

import UIKit

class VCSelectIMG: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imgView:UIImageView?
    let imagePicker = UIImagePickerController()
    var imgData:Data?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BotonGaleria(){
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func BotonCamara(){
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func subirConfirmarBoton(){
        let addtiempoMilis:Int = Int((Date().timeIntervalSince1970 * 1000.0).rounded())
          let ruta_img:String = String(format: "perfiles/miimagen%d.jpg", addtiempoMilis)
        let imagenRef = DataHolder.sharedInstance.firStorageRef?.child(ruta_img)
        let uploadTask = imagenRef!.putData(imgData!,metadata:nil){ (metadata,error)
            in
            guard let metadata = metadata else{
                return
            }
            let downloadURL = metadata.downloadURL()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        imgData = UIImageJPEGRepresentation(img!, 0.5)! as Data
        imgView?.image = img
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ViewController.swift
//  PhotoTest
//
//  Created by 黒川龍之介 on 2023/01/11.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func takePhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }else{
            print("Camera not available")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else{
            print("Image not found")
            return
        }
        
        imageView.image = image
    }
    
    func getFileURL(fileName: String) -> URL{
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDir.appendingPathComponent(fileName)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? SaveViewController{
            nextVC.sendImage = imageView.image
            nextVC.sendImage = imageView.image
        }
    }
    
    @IBAction func savePhoto(_ sender: Any) {
//        guard let imageData = imageView.image?.jpegData(compressionQuality: 1.0) else{
//            return
//        }
//        do {
//            try imageData.write(to: getFileURL(fileName: "aaa.jpg"))
//            print("Image Saved")
//        } catch {
//            print("Failed to save the image", error)
//        }
    }
    
    @IBAction func clearPhoto(_ sender: Any) {
        imageView.image = nil
    }
    
    @IBAction func loadPhoto(_ sender: Any) {
        let path = getFileURL(fileName: name).path

            if FileManager.default.fileExists(atPath: path) {
                if let imageData = UIImage(contentsOfFile: path) {
                    imageView.image = imageData
                }
                else {
                    print("Failed to load the image.")
                }
            }
            else {
                print("Image file not found.")
            }
    }
}


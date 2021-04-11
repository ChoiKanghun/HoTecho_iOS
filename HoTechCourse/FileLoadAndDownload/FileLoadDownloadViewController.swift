//
//  FileLoadDownloadViewController.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/04/11.
//

import UIKit

class FileLoadDownloadViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    @IBAction func touchUpDownloadButton(_ sender: Any) {
        
        let filenameIWant: String = "hotecho" + Date().description + ".jpg"
        guard let documentsURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else {
            print("documentsURL을 가져올 수 없습니다.")
            return
        }
        let destinationFileURL =
            documentsURL.appendingPathComponent(filenameIWant)
        
        let nakimImageURL = "https://cdn.pixabay.com/photo/2020/09/11/10/46/landscape-5562780__480.jpg"
        let fileURL = URL(string: nakimImageURL)
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        
        let request = URLRequest(url: fileURL!)
        let task = session.downloadTask(with: request) {
            (tempLocalURL, response, error) in
            if let tempLocalURL = tempLocalURL, error == nil {
                // 성공 시
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("successfully downloaded.")
                    print("statusCode: \(statusCode)")
                }
                
                do {
                    let data = try Data(contentsOf: tempLocalURL)
                    try data.write(to: destinationFileURL)
                    print("destionationFileURL: \(destinationFileURL)")
                    
                    do {
                        let savedImageData = try Data(contentsOf: destinationFileURL)
                        if let savedImage = UIImage(data: savedImageData) {
                            DispatchQueue.main.async{
                                self.imageView?.image = savedImage
                            }
                        }
                    } catch (let loadingImageError) {
                        print("Error - 이미지 로드중 에러")
                    }
                } catch (let writeError) {
                    print("Error - 파일을 쓰는 도중 에러가 남: \(writeError)")
                }
            } else {
                print("Error - 파일 다운로드 중 에러")
            }
        }
        task.resume()
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

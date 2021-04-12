//
//  PDFDownloadViewController.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/04/12.
//

import UIKit
import PDFKit

class PDFDownloadViewController: UIViewController {

    var pdfURL: URL?
    let pdfView = PDFView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        self.pdfView.frame = self.view.frame
    }
    
    @IBAction func downloadButton(_ sender: Any) {
        guard let url = URL(string: "https://www.tutorialspoint.com/swift/swift_tutorial.pdf")
        else {return}
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }

    @IBAction func openPDF(_ sender: Any) {
        self.view.addSubview(pdfView)
        if let document = PDFDocument(url: pdfURL!) {
            pdfView.document = document
        }
    }

}

extension PDFDownloadViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("temp file downloaded to", location)
        guard let url = downloadTask.originalRequest?.url else {return}
        let docsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let destinationPath = docsPath?.appendingPathComponent(url.lastPathComponent)
        
        try? FileManager.default.removeItem(at: destinationPath!)
        do {
            try FileManager.default.copyItem(at: location, to: destinationPath!)
            self.pdfURL = destinationPath
            print("file downloaded to:", self.pdfURL ?? "failed")
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

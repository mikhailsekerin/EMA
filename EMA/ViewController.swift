//
//  ViewController.swift
//  EMA
//
//  Created by Михаил Секерин on 25.10.18.
//  Copyright © 2018 Mikhail Sekerin. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    @IBOutlet weak var resLabel: UILabel!
    @IBOutlet weak var zProgressView: UIProgressView!
    @IBOutlet weak var resProgressView: UIProgressView!
    @IBOutlet weak var yProgressView: UIProgressView!
    @IBOutlet weak var xProgressView: UIProgressView!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    let manager: CMMotionManager = CMMotionManager()
    var dataArrray:[Dictionary<String, String>] =  Array()
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.accelerometerUpdateInterval = 0.1
    }
    
    @IBAction func onStartTap(_ sender: Any) {
        manager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let data = self.manager.accelerometerData{
                let x = data.acceleration.x * 9.81
                self.updateProgressView(progressView: self.xProgressView, progress: Float(data.acceleration.x))
                let y = data.acceleration.y * 9.81
                self.updateProgressView(progressView: self.yProgressView, progress: Float(data.acceleration.y))
                let z = data.acceleration.z * 9.81
                self.updateProgressView(progressView: self.zProgressView, progress: Float(data.acceleration.z))
                let res = sqrt(x * x + y * y + z * z)
                self.updateProgressView(progressView: self.resProgressView, progress: Float(res / 10))
                self.xLabel.text = String(x)
                self.yLabel.text = String(y)
                self.zLabel.text = String(z)
                self.resLabel.text = String(res)
                
                var dct = Dictionary<String, String>()
                dct.updateValue(String(x), forKey: "x")
                dct.updateValue(String(y), forKey: "y")
                dct.updateValue(String(z), forKey: "z")
                dct.updateValue(String(res), forKey: "res")
                self.dataArrray.append(dct)
            }
        }
    }
    
    @IBAction func onStopTap(_ sender: Any) {
        manager.stopAccelerometerUpdates()
    }
    
    func updateProgressView(progressView: UIProgressView, progress: Float){
        progressView.tintColor = progress > 0 ? UIColor.green : UIColor.red
        progressView.setProgress(abs(progress), animated: true)
    }
    
    func createCSV(from recArray:[Dictionary<String, String>]) {
        var csvString = "\("x"),\("y"),\("z"),\("res")\n\n"
        for dct in recArray {
            csvString = csvString.appending("\(String(describing: dct["x"]!)) ,\(String(describing: dct["y"]!)),\(String(describing: dct["z"]!)),\(String(describing: dct["res"]!))\n")
        }
        
        let fileManager = FileManager.default
        do {
            let path = try fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
            let fileURL = path.appendingPathComponent("EMA.csv")
            try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
            let vc = UIActivityViewController(activityItems: [path], applicationActivities: [])
            present(vc, animated: true, completion: nil)
        } catch {
            print("error creating file")
        }
        
    }
    @IBAction func onCreateFileTap(_ sender: Any) {
        self.createCSV(from: dataArrray)
    }
}


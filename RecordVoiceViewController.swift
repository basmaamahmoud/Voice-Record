//
//  ViewController.swift
//  ViceRecord
//
//  Created by Basma Ahmed Mohamed Mahmoud on 2/25/18.
//  Copyright © 2018 Basma Ahmed Mohamed Mahmoud. All rights reserved.
//

import UIKit
import AVFoundation

class RecordVoiceViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordButtnOutlet: UIButton!
    
    @IBOutlet weak var stopButtnOutlet: UIButton!
    
    
    var audioRecorder: AVAudioRecorder!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButtnOutlet.isEnabled = false
    
        recordButtnOutlet.imageView?.contentMode = .scaleAspectFit
        stopButtnOutlet.imageView?.contentMode = .scaleAspectFit
        
    }

    
    @IBAction func recordButtn(_ sender: Any) {
        stopButtnOutlet.isEnabled = true
        recordButtnOutlet.isEnabled = false
        
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        
        let session = AVAudioSession.sharedInstance()
        
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    
    }
    
    
   
    

  
    
    @IBAction func stopRecordButtn(_ sender: Any) {
   
        stopButtnOutlet.isEnabled = false
        recordButtnOutlet.isEnabled = true
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "PitchIdentifier", sender: audioRecorder.url)
        }else{
            
            self.alertTheUser(title: "Problem with recording, Please try again", message: "message")
            print("Recoding Failed")
        }
    
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "PitchIdentifier"{
            let playSoundVC = segue.destination as! VoiceChangingViewController
            let recordAudioURL = sender as? URL
            playSoundVC.recordedAudioURL = recordAudioURL
           
        }
        
        
    }
    
    private func alertTheUser(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        
        
    }
}

















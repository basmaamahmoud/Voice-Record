//
//  PitchViewController.swift
//  ViceRecord
//
//  Created by Basma Ahmed Mohamed Mahmoud on 2/26/18.
//  Copyright © 2018 Basma Ahmed Mohamed Mahmoud. All rights reserved.
//

import UIKit
import AVFoundation

class VoiceChangingViewController: UIViewController,AVAudioRecorderDelegate {

    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {case slow = 0, fast, chipmunk, vader, echo, reverb}
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()

        buttomScaleFit(buttom: [snailButton, chipmunkButton, rabbitButton, vaderButton, echoButton, reverbButton, stopButton])
        
    }

    func buttomScaleFit(buttom: [UIButton]) {
        
        for index in 0...buttom.count-1 {
            buttom[index].imageView?.contentMode = .scaleAspectFit
        }
      
    }

    @IBAction func PlaySoundForButton(_ sender: UIButton){
    
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)

    }
    
    @IBAction func StopButtonPressed(_ sender: UIButton){
        stopAudio()
        
    }
    

}








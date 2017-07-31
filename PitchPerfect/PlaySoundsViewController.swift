//
//  PlaySoundsViewController.swift
//  PitchPerfect
//


import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var parrotButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var buttonsStack: UIStackView!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, parrot, reverb
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        setStackViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(PlayingState.notPlaying)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setStackViewLayout()
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        print("Play Sound Button Pressed")
        
        switch (ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .parrot:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(PlayingState.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        print("Stop Audio Button Pressed")
        stopAudio()
    }
    
    func setStackViewLayout() {
        switch UIDevice.current.orientation{
        case .landscapeLeft, .landscapeRight :
            changeOrientation(vertical: false)
        case .portrait, .portraitUpsideDown:
            changeOrientation(vertical: true)
        default:
            break
        }
    }
    
    func changeOrientation(vertical: Bool) {
        
        let innerAxis = vertical ? UILayoutConstraintAxis.horizontal : UILayoutConstraintAxis.vertical
        buttonsStack.axis = vertical ? UILayoutConstraintAxis.vertical : UILayoutConstraintAxis.horizontal
        
        for view in buttonsStack.arrangedSubviews {
            if let innerButtonStak = view as? UIStackView {
                innerButtonStak.axis = innerAxis
            }
        }
    }
    
}

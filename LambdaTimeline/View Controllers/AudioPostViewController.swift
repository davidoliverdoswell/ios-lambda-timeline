//
//  AudioPostViewController.swift
//  LambdaTimeline
//
//  Created by David Doswell on 10/17/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPostViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBAction func record(_ sender: Any) {
        let isRecording = recorder?.isRecording ?? false
        if isRecording {
            recorder?.stop()
            if let url = recorder?.url {
                player = try! AVAudioPlayer(contentsOf: url)
                player?.delegate = self
            }
        } else {
            let format = AVAudioFormat(standardFormatWithSampleRate: 44100.0, channels: 1)
            recorder = try! AVAudioRecorder(url: newRecordingURL(), format: format!)
            recorder?.record()
        }
        updateViews()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        updateViews()
        playTimeTimer = nil
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        
        let isRecording = recorder?.isRecording ?? false
        let recordButtonTitle = isRecording ? "Stop" : "Record"
        recordButton.setTitle(recordButtonTitle, for: .normal)
    
        let components = DateComponentsFormatter()
        components.zeroFormattingBehavior = .pad
        components.allowedUnits = [.second, .minute]
    }
    
    
    private func newRecordingURL() -> URL {
        let fm = FileManager.default
        let documentsDir = try! fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return documentsDir.appendingPathComponent(UUID().uuidString).appendingPathExtension("caf")
    }
    
    private var playTimeTimer: Timer? {
        willSet {
            playTimeTimer?.invalidate()
        }
    }
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private var player: AVAudioPlayer?
    private var recorder: AVAudioRecorder?
    
}

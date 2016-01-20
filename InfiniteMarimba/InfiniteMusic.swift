//
//  InfiniteMusic.swift
//  InfiniteMarimba
//
//  Created by Bri Chapman on 19/01/16.
//  Copyright © 2016 com.bchapman. All rights reserved.
//

import Foundation
import AVFoundation

class InfiniteMusic : NSObject, AVAudioPlayerDelegate {
    var avPlayer : AVAudioPlayer?
    var initialized = false
    var progressionInt : Int = 0
    
    func playNote(note: String){
        print("trying to find \(note)")
        let fileURL = NSBundle.mainBundle().URLForResource(note, withExtension: ".m4a")
        print(fileURL)
        do {
            try avPlayer = AVAudioPlayer(contentsOfURL: fileURL!)
        } catch {
            print("could not create AVAudioPlayer \(error)")
            return
        }
        
        avPlayer!.delegate = self
        avPlayer!.prepareToPlay()
        avPlayer!.volume = 1.0
        avPlayer?.play()
    }
    
    func chooseProgression() {
        if !initialized {
            print("preparing a progression...")
            prepareMusicTheory()
            progressionInt = Int(arc4random_uniform(UInt32(scales!.count)))
            print("using progression \(progressionInt)")
            initialized = true
        }
    }
    
    func nextMelodyNote() -> String {
        chooseProgression()
        let amountOfTime = Double(1+(Int(arc4random_uniform(UInt32(8)))))*0.15
        print(amountOfTime)
        let scale = scales![progressionInt]
        let note = scale[Int(arc4random_uniform(UInt32(scale.count)))]
        let octave = 6+(Int(arc4random_uniform(UInt32(5))))
        let noteTitle = note + "\(octave)"
        print(noteTitle)
        return noteTitle
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        print("finished playing \(flag)")
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError?) {
        if let e = error {
            print("\(e.localizedDescription)")
        }
    }
    
    func stopAVPLayer() {
        if avPlayer!.playing {
            avPlayer!.stop()
        }
    }
    
    func toggleAVPlayer() {
        if avPlayer!.playing {
            avPlayer!.pause()
        } else {
            avPlayer!.play()
        }
    }
    
    func prepareMusicTheory() {
        scales = [cmajorscale, csharpmajorscale, dmajorscale, dsharpmajorscale, emajorscale,fmajorscale, fsharpmajorscale, gmajorscale, gsharpmajorscale, amajorscale,asharpmajorscale, bmajorscale, cminorscale, dminorscale, eminorscale, fminorscale,gminorscale, eminorscale, bminorscale]
        keycmajor = [cmajor, dminor, eminor, fmajor, gmajor, aminor]
        keycsharpmajor = [csharpmajor, dsharpminor, fminor, fsharpmajor, gsharpmajor, asharpminor]
        keydmajor = [dmajor, eminor, fsharpminor, gmajor, amajor, bminor]
        keydsharpmajor = [dsharpmajor, fminor, gminor, gsharpmajor, asharpmajor, cminor]
        keyemajor = [emajor, fsharpminor, gsharpminor, amajor, bmajor, csharpminor]
        keyfmajor = [fmajor, gminor, aminor, asharpmajor, cmajor, dminor]
        keyfsharpmajor = [fsharpmajor, gsharpminor, asharpminor, bmajor, csharpmajor, dsharpminor]
        keygmajor = [gmajor, aminor, bminor, cmajor, dmajor, eminor]
        keygsharpmajor = [gsharpmajor, asharpminor, cminor, csharpmajor, dsharpmajor, fminor]
        keyamajor = [amajor, bminor, csharpminor, dmajor, emajor, fsharpminor]
        keyasharpmajor = [asharpmajor, cminor, dminor, dsharpmajor, fmajor, gminor]
        keybmajor = [bmajor, csharpminor, dsharpminor, emajor, fsharpmajor, gsharpminor]
        keycminor = [cminor, dsharpmajor, fminor, gminor, gsharpmajor, asharpmajor]
        keydminor = [dminor, fmajor, gminor, aminor, asharpmajor, cmajor]
        keyeminor = [eminor, gmajor, aminor, bminor, cmajor, dmajor]
        keyfminor = [fminor, gsharpmajor, asharpminor, cminor, csharpmajor, dsharpmajor]
        keygminor = [gminor, asharpmajor, cminor, dminor, dsharpmajor, fmajor]
        keyaminor = [aminor, cmajor, dminor, eminor, fmajor, gmajor]
        keybminor = [bminor, dmajor, eminor, fsharpminor, gmajor, amajor]
        keys = [keycmajor!, keycsharpmajor!, keydmajor!, keydsharpmajor!, keyemajor!, keyfmajor!,keyfsharpmajor!, keygmajor!, keygsharpmajor!, keyamajor!, keyasharpmajor!, keybmajor!, keycminor!, keydminor!, keyeminor!, keyfminor!, keygminor!, keyaminor!, keybminor!]

    }
    
    var scales : Array<Array<String>>?
    var keys : Array<Array<Array<String>>>?
    
    // scales
    let cmajorscale = ["C", "D", "E", "F", "G", "A", "B"]
    let csharpmajorscale = ["C#", "D#", "F", "F#", "G#", "A#", "C"]
    let dmajorscale = ["D", "E", "F#", "G", "A", "B", "C#"]
    let dsharpmajorscale = ["D#", "F", "G", "G#", "A#", "C", "D"]
    let emajorscale = ["E", "F#", "G#", "A", "B", "C#", "D#"]
    let fmajorscale = ["F", "G", "A", "A#", "C", "D", "E"]
    let fsharpmajorscale = ["F#", "G#", "A#", "B", "C#", "D#", "F"]
    let gmajorscale = ["G", "A", "B", "C", "D", "E", "F#"]
    let gsharpmajorscale = ["G#", "A#", "C", "C#", "D#", "F", "G"]
    let amajorscale = ["A", "B", "C#", "D", "E", "F#", "G#"]
    let asharpmajorscale = ["A#", "C", "D", "D#", "F", "G", "A"]
    let bmajorscale = ["B", "C#", "D#", "E", "F#", "G#", "A#"]
    let cminorscale = ["C", "D", "D#", "F", "G", "G#", "A#"]
    let dminorscale = ["D", "E", "F", "G", "A", "A#", "C"]
    let eminorscale = ["E", "F#", "G", "A", "B", "C", "D"]
    let fminorscale = ["F", "G", "G#", "A#", "C", "C#", "D#"]
    let gminorscale = ["G", "A", "A#", "C", "D", "D#", "F"]
    let aminorscale = ["A", "B", "C", "D", "E", "F", "G"]
    let bminorscale = ["B", "C#", "D", "E", "F#", "G", "A"]
    
    //keys
    var keycmajor : Array<Array<String>>?
    var keycsharpmajor : Array<Array<String>>?
    var keydmajor : Array<Array<String>>?
    var keydsharpmajor : Array<Array<String>>?
    var keyemajor : Array<Array<String>>?
    var keyfmajor : Array<Array<String>>?
    var keyfsharpmajor : Array<Array<String>>?
    var keygmajor : Array<Array<String>>?
    var keygsharpmajor : Array<Array<String>>?
    var keyamajor : Array<Array<String>>?
    var keyasharpmajor : Array<Array<String>>?
    var keybmajor : Array<Array<String>>?
    var keycminor : Array<Array<String>>?
    var keydminor : Array<Array<String>>?
    var keyeminor : Array<Array<String>>?
    var keyfminor : Array<Array<String>>?
    var keygminor : Array<Array<String>>?
    var keyaminor : Array<Array<String>>?
    var keybminor : Array<Array<String>>?
    
    //notes in chords
    let cmajor = ["C", "E", "G"]
    let cminor = ["C", "D#", "G"]
    let csharpmajor = ["C#", "F", "G#"]
    let csharpminor = ["C#", "E", "G#"]
    let dmajor = ["D", "F#", "A"]
    let dminor = ["D", "F", "A"]
    let dsharpmajor = ["D#", "G", "A#"]
    let dsharpminor = ["D#", "F#", "A#"]
    let emajor = ["E", "G#", "B"]
    let eminor = ["E", "G", "B"]
    let fmajor = ["F", "A", "C"]
    let fminor = ["F", "G#", "C"]
    let fsharpmajor = ["F#", "A#", "C#"]
    let fsharpminor = ["F#", "A", "C#"]
    let gmajor = ["G", "B", "D"]
    let gminor = ["G", "A#", "D"]
    let gsharpmajor = ["G#", "C", "D#"]
    let gsharpminor = ["G#", "B", "D#"]
    let amajor = ["A", "C#", "E"]
    let aminor = ["A", "C", "E"]
    let asharpmajor = ["A#", "D", "F"]
    let asharpminor = ["A#", "C#", "F"]
    let bmajor = ["B", "D#", "F#"]
    let bminor = ["B", "D", "F#"]
}

//
//  SongDetailsViewController.swift
//  SuperDownloader
//
//  Created by Roman Bobelyuk on 13.11.2021.
//

import UIKit

class SongDetailsViewController: UIViewController {

    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var url: UILabel!

    var song: Song?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let song = song else { return }
        songName.text = "Song name: \(song.title)"
        artistName.text = "Artist name: \(song.artist)"
        url.text = "URL: \(song.url.absoluteString)"
    }

}

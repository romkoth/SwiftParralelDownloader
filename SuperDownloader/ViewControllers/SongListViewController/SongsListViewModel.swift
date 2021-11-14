//
//  SongListViewModel.swift
//  SuperDownloader
//
//  Created by Roman Bobelyuk on 10.11.2021.
//

import Foundation

// 100 MB example
//"http://212.183.159.230/100MB.zip"

protocol SongsListViewModelDelegate {
    func didFinishLoadingSongs()
}

final class SongsListViewModel {

    enum LoadingStatus {
        case notStarted
        case loading
        case paused
        case finished
    }

    lazy var songs = [
        Song(title: "Uprising", artist: "Muse", url: URL(string: "http://212.183.159.230/50MB.zip")!),
        Song(title: "Madness", artist: "Muse", url: URL(string: "http://212.183.159.230/50MB.zip")!),
        Song(title: "Stralight", artist: "Muse", url: URL(string: "http://212.183.159.230/50MB.zip")!),
        Song(title: "Pressure", artist: "Muse", url: URL(string: "http://212.183.159.230/50MB.zip")!)
    ]
    
    var cellViewModels = [SongCellViewModel]()
    var status: LoadingStatus = .notStarted
    var delegate: SongsListViewModelDelegate?

    private var loadedSongs = 0

    func loadSongs() {
        status = .loading
        cellViewModels.forEach({ $0.load(completionHandler: songLoaded) })
    }

    func pause() {
        status = .paused
        cellViewModels.forEach({ $0.pause() })
    }

    func resume() {
        status = .loading
        cellViewModels.forEach({ $0.resume() })
    }

    private func songLoaded() {
        loadedSongs += 1
        // Use this check instead of DispatchGroup.notify()
        if loadedSongs == cellViewModels.count {
            status = .finished
            delegate?.didFinishLoadingSongs()
        }
    }
}

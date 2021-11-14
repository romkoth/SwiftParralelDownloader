//
//  SongCellViewModel.swift
//  SuperDownloader
//
//  Created by Roman Bobelyuk on 13.11.2021.
//

import Foundation
protocol SongCellViewDelegate {
    func loading(progress: String)
    func didFinishLoading(taskId: Int)
}

final class SongCellViewModel {

    let url: URL
    let DownloadTask: DownloadTask
    var delegate: SongCellViewDelegate?

    private var loadingFinished: (()-> Void)?

    init(url: URL, DownloadTask: DownloadTask) {
        self.url = url
        self.DownloadTask = DownloadTask
        DownloadTask.delegate = self
    }

    func load(completionHandler: @escaping ()-> Void) {
        loadingFinished = completionHandler
        DownloadTask.load(url: url)
    }

    func pause() {
        DownloadTask.pauseLoading()
    }

    func resume() {
        DownloadTask.resumeLoading()
    }
}

extension SongCellViewModel: DownloadTaskProgressDelegate {
    func finishedLoading(taskId: Int) {
        DispatchQueue.main.async {
            self.loadingFinished?()
        }
    }

    func loading(progress: String) {
        DispatchQueue.main.async {
            self.delegate?.loading(progress: progress)
        }
    }
}

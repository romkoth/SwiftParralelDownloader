//
//  ViewController.swift
//  SuperDownloader
//
//  Created by Roman Bobelyuk on 10.11.2021.
//

import UIKit

class SongsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var startLoadingButton: UIButton!

    @IBAction func startLoadingAction(_ sender: Any) {
        var title = "Load songs"
        switch viewModel.status {
        case .notStarted:
            title = "Pause"
            viewModel.loadSongs()
        case .loading:
            title = "Resume"
            viewModel.pause()
        case .paused:
            title = "Pause"
            viewModel.resume()
        case .finished:
            title = "Load songs"
        }
        startLoadingButton.setTitle(title, for: .normal)
    }
    
    var coordinator: BaseCoordinator?
    private let viewModel = SongsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SongTableViewCell.self, forCellReuseIdentifier: "SongTableViewCell")
        self.startLoadingButton.titleLabel?.text = "Load songs"
        viewModel.delegate = self
    }

}

extension SongsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.songs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as? SongTableViewCell {
            let song = viewModel.songs[indexPath.row]
            let cellViewModel = SongCellViewModel(url: song.url, DownloadTask: DownloadTask())
            viewModel.cellViewModels.append(cellViewModel)
            cell.configure(song: song, viewModel: cellViewModel)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = viewModel.songs[indexPath.row]
        coordinator?.presentSongDetails(song: song)
        tableView.deselectRow(at: indexPath, animated: false)
    }

}

extension SongsListViewController: SongsListViewModelDelegate {
    func didFinishLoadingSongs() {
        startLoadingButton.setTitle("All songs loaded", for: .normal)
        startLoadingButton.isUserInteractionEnabled = false
    }
}

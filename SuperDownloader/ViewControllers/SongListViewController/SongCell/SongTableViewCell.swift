//
//  SongTableViewCell.swift
//  SuperDownloader
//
//  Created by Roman Bobelyuk on 10.11.2021.
//

import Foundation
import UIKit

class SongTableViewCell: UITableViewCell {

    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let artistLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var viewModel: SongCellViewModel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(song: Song, viewModel: SongCellViewModel) {
        self.viewModel = viewModel
        self.viewModel?.delegate = self
        songNameLabel.text = song.title
        artistLabel.text = song.artist
    }

    private func setup() {

        contentView.addSubview(artistLabel)
        contentView.addSubview(songNameLabel)
        contentView.addSubview(loadingLabel)

        NSLayoutConstraint.activate([
            songNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            songNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            artistLabel.bottomAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 16),
            artistLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loadingLabel.leadingAnchor.constraint(equalTo: artistLabel.leadingAnchor, constant: 100),
            loadingLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: -8),
            loadingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            loadingLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
}

extension SongTableViewCell: SongCellViewDelegate {
    func didFinishLoading(taskId: Int) {
        // update loading label ?
    }

    func loading(progress: String) {
        loadingLabel.text = "Loading \(progress)"
    }
}

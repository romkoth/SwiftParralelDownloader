//
//  DownloadTask.swift
//  SuperDownloader
//
//  Created by Roman Bobelyuk on 12.11.2021.
//

import Foundation
import UIKit

protocol DownloadTaskProgressDelegate {
    func loading(progress: String)
    func finishedLoading(taskId: Int)
}

class DownloadTask: NSObject {
    lazy var urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration:configuration,
                          delegate: self, delegateQueue: nil)
    }()
    var downloadTask: URLSessionDownloadTask?
    var downloadData: Data?

    var delegate: DownloadTaskProgressDelegate?

    func load(url: URL) {
        let request = URLRequest(url: url)
        downloadTask = urlSession.downloadTask(with: request)
        downloadTask?.resume()
    }

    func pauseLoading() {
        downloadTask?.cancel{ resumeDataOrNil in
            guard let resumeData = resumeDataOrNil else { return }
            self.downloadData = resumeData
            self.downloadTask = nil
        }
    }

    func resumeLoading() {
        if let downloadData = self.downloadData {
            downloadTask = self.urlSession.downloadTask(withResumeData: downloadData)
            downloadTask?.resume()
        }
    }
}


extension DownloadTask: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Finished")
        print("location: \(location)")
        delegate?.finishedLoading(taskId: downloadTask.taskIdentifier)
        // notify viewModel ?
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {

        let written: CGFloat = (CGFloat)(totalBytesWritten)
        let total: CGFloat = (CGFloat)(totalBytesExpectedToWrite)
        let progress: CGFloat = written/total
        delegate?.loading(progress: "\(Int(floor(progress * 100)))%")
        //print("Progress：\(progress)")
    }
}

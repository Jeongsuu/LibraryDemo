//
//  MoviesTableViewController.swift
//  Quick_Nimble_Example
//
//  Created by 여정수 on 2021/10/29.
//

import UIKit

class MoviesTableViewController: UITableViewController {

    private var movies: [Movie] {
        return MoviesDataHelper.getMovies()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - TableView Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = movie.genreString
        return cell
    }
}

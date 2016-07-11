import UIKit
import XCPlayground


struct Episode {
    var title: String
}

struct Season {
    var number: Int
    var title: String
}


final class EpisodesViewController: UITableViewController {
    var episodes: [Episode] = []
    let reuseIdentifier = "Cell"
    
    init(episodes: [Episode]) {
        super.init(style: .Plain)
        self.episodes = episodes
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        let item = episodes[indexPath.row]
        cell.textLabel?.text = item.title
        return cell
    }
}


let sampleEpisodes = [Episode(title: "First Episode"), Episode(title: "Second Episode"), Episode(title: "Third Episode")]

let episodesVC = EpisodesViewController(episodes: sampleEpisodes)
//let episodesVC = EpisodesViewController()
//episodesVC.episodes = sampleEpisodes

episodesVC.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
XCPlaygroundPage.currentPage.liveView = episodesVC.view


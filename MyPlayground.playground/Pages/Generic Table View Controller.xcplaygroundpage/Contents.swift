import UIKit
import XCPlayground


struct Episode {
    var title: String
}

struct Season {
    var number: Int
    var title: String
}


final class ItemsViewController<Item, Cell: UITableViewCell>: UITableViewController {
    var items: [Item] = []
    let reuseIdentifier = "Cell"
    let configure: (Cell, Item) -> ()
    var didSelect: (Item) -> () = { _ in }
    
    init(items: [Item], configure: (Cell, Item) -> ()) {
        self.configure = configure
        super.init(style: .Plain)
        self.items = items
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        tableView.registerClass(Cell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = items[indexPath.row]
        didSelect(item)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! Cell
        let item = items[indexPath.row]
        configure(cell, item)
        return cell
    }
}


let sampleEpisodes = [
    Episode(title: "First Episode"),
    Episode(title: "Second Episode"),
    Episode(title: "Third Episode")
]

let sampleSeasons = [
    Season(number: 1, title: "Season One"),
    Season(number: 2, title: "Season Two")
]


final class SeasonCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


let seasonsVC = ItemsViewController(items: sampleSeasons, configure: { (cell: SeasonCell, season) in
    cell.textLabel?.text = season.title
    cell.detailTextLabel?.text = "\(season.number)"
})
seasonsVC.title = "Seasons"

let nc = UINavigationController(rootViewController: seasonsVC)

seasonsVC.didSelect = { season in
    let episodesVC = ItemsViewController(items: sampleEpisodes, configure: { cell, episode in
        cell.textLabel?.text = episode.title
    })
    episodesVC.title = season.title
    nc.pushViewController(episodesVC, animated: true)
}

nc.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
XCPlaygroundPage.currentPage.liveView = nc.view



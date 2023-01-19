# StarWars

## iOS design Pattern
I used the MVC design pattern because of the simplicity of the project.

## UITableView & Diffable Datasource
I've decided to use a table view as opposed to a collection view because:
- No custom UI is needed (e.g. images)
- Simple and easy

## Project structure + Abstraction
I've chosen to extract many of my views out into custom views for reusability and scalability. All views that could be potentially reused I've marked with "BU"
at the front to make it clear they would be part of the design system. It may be cleaner to have all of these design system views in a separate folder called design
system. 

## UI
I've chosen to create my UI programatically due to personal preference, but I am also experienced creating views using xibs. I'd also like to note that there are no
images in the project as the endpoint doesn't return any images.

## Networking
- I decided to use a singleton NetworkManager class for networking. I used a singleton as it could be accessed through a shared instance throughout 
the app, keeping the project simple. This works well for now as there are only 2 API calls being made. I've added a NetworkManagerProtocol to be able to create a
MockNetworkManager and make it testable. 
- The main area which required the most thought was around how to structure the network calls. The API (annoyingly) doesn't give you a list of the character names
when calling the films API, rather it gives you a list of the character urls. I considered 3 options:
1) Do both API calls upon viewDidLoad and block the UI until both finished
2) Do both API calls upon viewDidLoad and render the tableView when the films api call succeeds
3) Do the fetchCharacterList upon clicking a film

I chose to go with option 2 for these main reasons:
1) the payload for both API calls is relatively small and reliable (given there is no need for an API key or any auth)
2) the user will not have to wait when clicking on a film to see the characters
3) it required fewer network calls (to for example doing a network call for each characterURL for a given film)

## Navigation
I considered using the Coordinator pattern to decouple navigation from the viewcontrollers, however since the only navigation happening was to the detailVC, 
I opted to not add that complexity, and instead just presented the detailVC in a modal. In a larger project, I'd most likely use the Coordinator pattern.

## Notes
- I would add images if they were available in the API
- For an API that returned more data I would consider adding pagination
- I could add a character detail VC 
- Possibly add a tab view for different endpoints

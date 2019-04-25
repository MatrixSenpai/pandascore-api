# PandaScoreAPI

![Package Managers](https://img.shields.io/badge/Package%20Managers-SPM%20%7C%20CocoaPods-important.svg?style=for-the-badge)
![Cocoapods platforms](https://img.shields.io/cocoapods/p/PandaScoreAPI.svg?style=for-the-badge)
![Cocoapods](https://img.shields.io/cocoapods/v/PandaScoreAPI.svg?style=for-the-badge)
![Discord](https://img.shields.io/discord/569027254550528030.svg?style=for-the-badge)

### A Swift implementation of the PandaScore API

A callback based API client with built-in reactive extensions

_Currently, this package does not support Live (`wss://`)_

#### Overview
To get started, create a client and pass in your token, like so:
```swift
let client: Client = Client("<PANDASCORE_API_TOKEN>")
```

##### Making a request
Each endpoint has a similar structure.

Simple endpoints like `getChampion` and `getItem` can take an ID or a list of IDs, and return a single object or a filtered list.

More complex endpoints, like those for `games`, `matches`, `series`, and `tournaments`, have a slightly more complex structure

There are 3 main parts to these requests: 
- page/per_page
- filter/range
- sort

Page and per_page are relatively self-explainatory. They deal with the pagination of the request
> Note: In future versions, a response will contain the next and previous paging information, to allow for easier pagination of requests

Filter and range allow the limitations on the data returned by applying filters on the properties _of the returning object_.

Sort allows the data returned to be sorted by a property _on the returning objects_

A quick sample of making requests
```swift
let filterObject = GetMatchesParametersObject(finished: true, number_of_games: 1)
let sortObject = GetMatchesSortObject(keys: [(.begin_at, true)])
client.getMatches(filter: filterObject) { response in 
  // Do something
}
```
This request gets only finished matches with one game, and sorts them in ascending order by when they began.


For further documentation on how the API works, check out [the PandaScore official documentation](https://developers.pandascore.co/doc/).

#### Problems?

Submit an issue

# PandaScoreAPI

### A Swift implementation of the PandaScore API

A callback based API client with built-in reactive extensions

##### Compatible Games
- [ ] CS:GO
- [ ] Dota2
- [x] League of Legends
- [ ] Overwatch
- [ ] PUBG

_Currently, this package does not support Live (`wss://`)_

#### Overview
To get started, create a client and pass in your token, like so:
```swift
let client: Client = Client("<PANDASCORE_API_TOKEN>")
```

##### Making a request
There are multiple endpoints, each with a similar structure

- Simple Endpoints
    - These endpoints cannot filter, sort, or use a range
    - These endpoints cannot page
    - Used for single items

Simple endpoints are:
```swift
getChampion(by: Int)
```
```swift
getGame(for: Int)
```
```swift
getItem(by: Int)
```

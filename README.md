# CriptoWatcher

POC crypto watcher client for iOS using UIKit + SPM

<p align="center">
  <img src="demo.gif" width="250" />
</p>

# Technologies

SPM dependencies used are my own 

* [MauriUtils](https://github.com/mchirino89/MauriUtils)
* [MauriNet](https://github.com/mchirino89/MauriNet)

The only external dependency is [Snapshot testing](https://github.com/pointfreeco/swift-snapshot-testing) from the guys of pointfree.

# Overview 

This project was built and compile on [XCode 12.4](https://download.developer.apple.com/Developer_Tools/Xcode_12.4/Xcode_12.4.xip).

The test API used was [Bitso's](https://bitso.com/api_info) public one.

# Reasoning

- [SOLID](https://www.youtube.com/watch?v=TMuno5RZNeE&ab_channel=Peoplecareer) is at the heart of this development, always favoring composition over inherence (that's why you can see so many files for such a "small" project). It was _lego oriented_ design 😁
- Use of StackViews wherever possible to laverage its flexibility and layout power.
- Break down every delegate/data source across the project in order to avoid fat classes. `MainListViewController` is the _commander_ (sort of speak) of it all.
- There are several `DataSource` classes around in order to use MVVM architecture and share them where appropiate. This way API communication never touches view model or view controller.
- Dark mode support
- Github action integration: CI setup on every PR and push made against the **main** branch

# Considerations 

There were tradeoffs in every major design decision behind the development. While it is true that SOLID principles are at the core of every choice made here, no peace of software is ever complete so there might be minor duplicated here and there for speeding sake. Some notes can be found across the project explaining the shortcomings of those implementations. 

# Things to improve
You might find odd for me to include this section since it looks like I'm sabotaging myself. The intention here is to acknowledge the things that, most likely due to lack of time, remain pending. Just to mention a few:

- Better error handling for network requests
- Improve code coverage
- Add more snapshot test case scenarios

# Monolith Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2021-04-18
### Added
- Enumerable interface
	- Allows data structures to be enumerated in for loops
- Collection interface
	- All Monolith data types are based on this interface. This allows them to
	  share common features.
	- Includes enumeration, element count, table conversion, element existence,
	  addition, and removal
- List interface
	- The root of all list style data structures
	- Includes all Collection functionality, indexing, insertion, deletion, and
	  searching
- AbstractList abstract class
	- A partial List implementation
- LinkedList class
	- A doubly linked List implementation
	- Implements all optional List methods
- ArrayList class
	- An array-based List implementation
	- Implements all optional List methods
- Queue interface
	- The root of all first in first out data structures
	- Includes all Collection functionality, insertion at the back, deletion at
	  the front, and peeking at the front
- LinkedQueue class
	- A doubly linked Queue implementation
	- Implements all optional Queue methods
- Deque interface
	- The root of all double ended Queues
	- Includes all Collection and Queue functionality, insertion at the front,
	  deletion at the back, and peeking at the back
- LinkedDeque class
	- A doubly linked Deque implementation
	- Implements all optional Deque methods
- Stack interface
	- The root of all last in first out data structures
	- Includes all Collection functionality, insertion at the front, deletion at
	  the front, and peeking at the front
- ArrayStack class
	- An array-based Stack implementation
	- Implements all optional Stack methods
- Set interface
	- The root of all unordered, non-associative data structures
	- Includes all Collection functionality, set comparision, and set
	  transformation
- HashSet class
	- A hashtable Set implementation
	- Implements all optional Set methods
- Map interface
	- The root of all unordered, associative data structures
	- Includes all Collection functionality, key/value/pair Collections and
	  constructors, and value accessors
- HashMap class
	- A hashtable Map implementation
	- Implements all optional Map methods

[unreleased]: https://github.com/IsoLogicGames/Monolith/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/IsoLogicGames/Monolith/releases/tag/v0.1.0

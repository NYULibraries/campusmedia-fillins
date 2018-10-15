[![Build Status](https://travis-ci.org/NYULibraries/campusmedia-fillins.svg?branch=master)](https://travis-ci.org/NYULibraries/campusmedia-fillins)

# campusmedia-fillins
Campus Media Reference Configuration

## Inheritence Hierarchy
  * [Rooms](https://github.com/NYULibraries/campusmedia-fillins/blob/master/rooms.yml) > [Buildings](https://github.com/NYULibraries/campusmedia-fillins/blob/master/buildings.yml) > [Default](https://github.com/NYULibraries/campusmedia-fillins/blob/master/rooms.yml#L2)
  
First, default values are applied to all rooms. Then, building values override default values. Finally, specific room values override values set by either by default or the building the room lives in.

## Merging Behavior

Lists and key-value dictionaries (i.e. arrays and hashes) are set to 'merge' by finding the [union](https://en.wikipedia.org/wiki/Union_(set_theory)) of both sets.

### Lists: `keywords`, `technology`, `features`
Lists are merged based on the unique values common to all the lists. The displayed order is `default`, `building`, then `room` values.

#### Example
`rooms.yml`
```yaml
default:
  keywords:
    - campus media
7890:
  title: Campus Media Center, Room 777
  url: campus-media-777
  keywords:
    - lucky
```
`buildings.yml`
```yaml
123:
  location: Campus Media Center
  keywords:
    - media lab
```
OUTPUT: `/classrooms/campus-media-777`
```yaml
title: Campus Media Center, Room 777
keywords:
  - campus media
  - media lab
  - lucky
```

### Dictionaries: `links`, `buttons`, `help`, `policies`
Lists are merged based on the unique values common to all the lists. The displayed order is `default`, `building`, then `room` values.

When the values of a dictionary are themselves dictionaries (i.e. `help`), these values are merged as well.

**Note**: `buttons` has been customized to only display the 'most important' (last) merged value, since the behavior to display multiple buttons (unlike `links` and `policies`) is undesirable.

#### Example
`rooms.yml`
```yaml
default:
  links:
    Library website: http://library.edu/
  buttons:
    Reserve Classroom Equipment: https://library.qualtrics.com/1234abcd
  help:
    text: University Library System
    phone: 212-555-5555
    email: uni@library.edu
7890:
  title: Campus Media Center, Room 777
  url: campus-media-777
  links:
    Room 777 Instructions: http://library.edu/room-777.pdf
  buttons:
    Reserve Room 777: https://library.qualtrics.com/1234abcd
  help:
    text: |
      *Note*: This room requires special access priviledges.
```
`buildings.yml`
```yaml
123:
  location: Campus Media Center
  links:
    Campus Media Center Accessibility Guide: http://library.edu/cm-guide.pdf
  help:
    email: campusmedia@library.edu
```
OUTPUT: `/classrooms/campus-media-777`
```yaml
title: Campus Media Center, Room 777
links:
  Library website: http://library.edu/
  Campus Media Center Accessibility Guide: http://library.edu/cm-guide.pdf
  Room 777 Instructions: http://library.edu/room-777.pdf
buttons:
  Reserve Room 777: https://library.qualtrics.com/1234abcd
help:
  text: |
    *Note*: This room requires special access priviledges.
  phone: 212-555-5555
  email: campusmedia@library.edu
```

## Images

By default, images are assigned from the library.nyu.edu S3 bucket that corresponds to the room `url`.

To prevent broken image icons showing up for a room that doesn't have an image:
```yaml
12345:
  # ...
  image: false
```

## Writing in YAML

[Writing in YAML Guide](https://github.com/NYULibraries/campusmedia-fillins/wiki/Writing-in-YAML)

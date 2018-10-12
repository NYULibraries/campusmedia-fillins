[![Build Status](https://travis-ci.org/NYULibraries/campusmedia-fillins.svg?branch=master)](https://travis-ci.org/NYULibraries/campusmedia-fillins)

# campusmedia-fillins
Campus Media Reference Configuration

## Inheritence Hierarchy
  * [Rooms](https://github.com/NYULibraries/campusmedia-fillins/blob/master/rooms.yml) > [Buildings](https://github.com/NYULibraries/campusmedia-fillins/blob/master/buildings.yml) > [Default](https://github.com/NYULibraries/campusmedia-fillins/blob/master/rooms.yml#L2)
  
First, default values are applied to all rooms. Then, building values override default values. Finally, specific room values override values set by either by default or the building the room lives in.

## Merging Behavior

Lists and key-value dictionaries (i.e. arrays and hashes) are set to 'merge' by finding the [union](https://en.wikipedia.org/wiki/Union_(set_theory)) of both sets.

### Lists: `keywords`, `technology`, `features`
Lists are merged based on the unique values common to all the lists. The displayed order is the reverse of the inheritence hierarchy.

#### Example
`rooms.yml`
```yaml
default:
  keywords:
    - campus media
'7890':
  title: Campus Media Center, Room 777
  url: campus-media-777
  keywords:
    - casino
```
`buildings.yml`
```yaml
'123'
  location: Campus Media Center
  keywords:
    - media lab
```
OUTPUT: `/classrooms/campus-media-777`
```
title: Campus Media Center, Room 777
keywords:
  - campus media
  - media lab
  - casino
```

### Dictionaries: `links`, `buttons`, `help`, `policies`
Lists are merged based on the unique values common to all the lists. The displayed order is the same as the inheritence hierarchy.

**Note**: `buttons` has been customized to only display the 'most important' merged value, since the behavior to display multiple buttons (unlike `links` and `policies`) is undesirable. Again, this follows the inheritence hierarchy.

#### Example
`forthcoming`


## Writing in YAML

YAML is a data creation language that is often used for configuration files. It uses whitespace (spaces and line breaks) in order to define the organization of information.

To inspect the validity of your YAML before publishing, use an online tool such as [YAML Validator](https://codebeautify.org/yaml-validator) or [YAML Lint](http://www.yamllint.com/)

**Key-value pairs**
Key value pairs can be thought of as a dictionary: every key (word) corresponds to a value (definition).

```yaml
key: value 1
key2: value 2
key 3: value 3 # keys can have spaces
12345: value 4 # keys can also be numbers
```

**Keys and whitespace**

It may help to think of yaml like a series of nested bullet-points:

* Top-level information here
  * sub-point 1
    * sub-sub-point
  * sub-point 2
* Another top-level piece of information

Similarly, data in YAML files is nested to indicate a hierarcy.

```yaml
'412':
  address: 19 University Place, New York, NY
  location: 19 University Place
  help:
    text: Silver Center Office, 100 Washington Square East, Room LL7A
    phone: +1 212 998 2655
```

**Multi-line values:** (for use with Markdown especially)
```yaml
body: |
  I can write arbitrary text here:
  Including [formatted markdown](https://guides.github.com/features/mastering-markdown/)!

  I can even write multiple lines.

  # With headers!
  * But I always make sure each subsequent line is indented!
  * YAML understands when my text ends when it sees an unindented line.
key:
  key2:
    body: |
      If my multi-line text is deeply nested, I make sure to continue indenting two more lines than the preceding key.
      So I can continue writing here!
    published: true
```
*but...*
```yaml
confused_yaml: # When we write markdown here (sees as comment)
```

**Lists:**
```yaml
key:
  - value 1
  - value 2
```

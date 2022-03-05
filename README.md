maildir2JSON
========
[![GitHub release](https://img.shields.io/github/release/amalfra/maildir2json.svg)](https://github.com/amalfra/maildir2json/releases)
![Build Status](https://github.com/amalfra/maildir2json/actions/workflows/test.yml/badge.svg?branch=main)
[![Gem Version](https://badge.fury.io/rb/maildir2json.svg)](https://badge.fury.io/rb/maildir2json)

A script to convert maildir format to JSON.

## Installation

The script is written in ruby and hence you need ruby installed. Run following command to install

```sh
gem install maildir2json
```

## Usage

The script can be used from commandline as

```sh
maildir2json /home/user/maildirfile /home/user/jsonfile.json
```

The input maildir file and output JSON files are passed as commandline arguments.
* The first argument is the absolute path to your maildir format file.
* The second argument is absolute path to where you need the output JSON file.

## Development

Questions, problems or suggestions? Please post them on the [issue tracker](https://github.com/amalfra/maildir2json/issues).

You can contribute changes by forking the project and submitting a pull request. Feel free to contribute :heart_eyes:

UNDER MIT LICENSE
=================

The MIT License (MIT)

Copyright (c) 2016 Amal Francis

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

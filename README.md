# nubis-travis

[![GitHub release](https://img.shields.io/github/release/nubisproject/nubis-travis.svg)](https://github.com/nubisproject/nubis-travis/releases/)

This is a collection of lint checks that we use for automatically linting code
through [TravisCi](https://travis-ci.org/).

## Local Usage

You can run the lint checks yourself using docker. Hint: Check out the release
version badge at the top.

```bash

docker run --mount type=bind,source="$(pwd)",target=/nubis/files nubisproject/nubis-travis:vX.X.X

```

## Using in your repository

To use in your repository you will need to create a `.travis.yaml` file in the
root directory containing:

```yaml

sudo: required

language: ruby

services:
  - docker

before_install:
  - docker pull nubisproject/nubis-travis:master

script:
  - docker run --mount type=bind,source="$(pwd)",target=/nubis/files nubisproject/nubis-travis:master

```

Once you have committed that file you need to enable the travis integration on
GitHub. Go to your repository settings page, under
'Branches' -> 'Protected Branches' select a branch and click 'Require status
checks to pass before merging' and then choose the
'continuous-integration/travis-ci' status check.

Finally, under your TravisCi profile you will need to turn on the check for the
repository. There are plentyof instructions online that are far more detailed
than this.

## Fin

Hopefully that got you where you need to be. If you run into any issue or have
any trouble feel free to reach out to us. We are happy to help and are quite
interested in improving the project in any way we can. We are on
mozilla.slack.com in #nubis-users or you can reach us on the mailing list at
nubis-users[at]googlegroups.com

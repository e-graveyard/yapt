<!-- badges -->
[![Tests][gh-tc-shield]][gh-tc-url]
[![Code Coverage][codecov-shield]][codecov-url]
[![Code Quality][lgtm-shield]][lgtm-url]
[![Docker Image Size][docker-img-size-shield]][docker-url]
[![GitHub tag][tag-shield]][tag-url]

# Yet Another Python Template

<img src=".docs/logo.svg" height="260px" align="right"/>

An opinionated template for Python projects that includes:

- Unit testing with **pytest**
- Type checking with **MyPy**
- Code coverage on **Codecov**
- **Docker** image
- Good-looking API documentation with **MkDocs**
- CI/CD pipeline on **GitHub Actions** with:
    - Python venv caching for faster pipelines
    - Linting, style and code duplication checking
    - Test execution and coverage report upload
    - Docker image build and push to DockerHub

The API documentation live preview is available at [yapt.upsetbit.co](yapt-docs).


## Compatibility

`yapt` is tested against all major python versions: `3.7`, `3.8` and `3.9`.


## How can I use it?

Take what suits you, ignore or change what you do not like, and apply according to his will.


## License

To the extent possible under law, [Caian Ertl][me] has waived __all copyright and related or neighboring rights to this
work__. In the spirit of _freedom of information_, I encourage you to fork, modify, change, share, or do whatever you
like with this project! [`^C ^V`][kopimi]

[![License][cc-shield]][cc-url]


<!-- badges refs -->
[yapt-docs]: https://yapt.upsetbit.co

[gh-tc-shield]: https://img.shields.io/github/workflow/status/caian-org/yapt/run-tests-and-upload-coverage?label=tests&logo=github&style=flat-square
[gh-tc-url]: https://github.com/caian-org/yapt/actions/workflows/test-with-cov.yml

[codecov-shield]: https://img.shields.io/codecov/c/github/caian-org/yapt.svg?logo=codecov&logoColor=FFF&style=flat-square
[codecov-url]: https://codecov.io/gh/caian-org/yapt

[lgtm-shield]: https://img.shields.io/lgtm/grade/python/g/caian-org/yapt.svg?logo=lgtm&style=flat-square
[lgtm-url]: https://lgtm.com/projects/g/caian-org/yapt/context:python

[docker-img-size-shield]: https://img.shields.io/docker/image-size/caian/yapt?sort=semver&logo=docker&logoColor=FFF&style=flat-square
[docker-url]: https://hub.docker.com/r/caian/yapt

[tag-shield]: https://img.shields.io/github/tag/caian-org/yapt.svg?logo=git&logoColor=FFF&style=flat-square
[tag-url]: https://github.com/caian-org/yapt/releases

<!-- license info refs -->
[me]: https://github.com/upsetbit
[cc-shield]: https://forthebadge.com/images/badges/cc-0.svg
[cc-url]: http://creativecommons.org/publicdomain/zero/1.0

[kopimi]: https://kopimi.com

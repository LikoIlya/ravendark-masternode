RavenDark Core 0.3.1
===============================


http://raven-dark.com


What is RavenDark?
----------------

RavenDark(XRD) is an attempt to provide a GPU secured blockchain with privacy.

The blockchain is based on Dash with the X16r algorithm from Ravencoin.

For more information, as well as an immediately useable, binary version of
the RavenDark Core software, see http://raven-dark.com/.


Build and Run with Docker
----------------

build:
`docker build -t ravendark .`

run:
`docker run -p 6666:6666 -p 6665:6665 -d -v ~/.ravendark:/root/.ravendark --name ravendark ravendark:latest`

License
-------

RavenDark Core is released under the terms of the MIT license. See [COPYING](COPYING) for more
information or see https://opensource.org/licenses/MIT.

Development Process
-------------------

The `master` branch is meant to be stable. Development is normally done in separate branches.
[Tags](https://github.com/raven-dark/raven-dark/tags) are created to indicate new official,
stable release versions of RavenDark Core.

The contribution workflow is described in [CONTRIBUTING.md](CONTRIBUTING.md).

Testing
-------

Testing and code review is the bottleneck for development; we get more pull
requests than we can review and test on short notice. Please be patient and help out by testing
other people's pull requests, and remember this is a security-critical project where any mistake might cost people
lots of money.

### Automated Testing

Developers are strongly encouraged to write [unit tests](/doc/unit-tests.md) for new code, and to
submit new unit tests for old code. Unit tests can be compiled and run
(assuming they weren't disabled in configure) with: `make check`

There are also [regression and integration tests](/qa) of the RPC interface, written
in Python, that are run automatically on the build server.
These tests can be run (if the [test dependencies](/qa) are installed) with: `qa/pull-tester/rpc-tests.py`

The Travis CI system makes sure that every pull request is built for Windows
and Linux, OS X, and that unit and sanity tests are automatically run.

### Manual Quality Assurance (QA) Testing

Changes should be tested by somebody other than the developer who wrote the
code. This is especially important for large or high-risk changes. It is useful
to add a test plan to the pull request description if testing the changes is
not straightforward.
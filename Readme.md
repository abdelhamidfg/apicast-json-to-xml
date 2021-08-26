# APICast json to XML policy

This is a APICast sample policy, not valid for production usage, that transform
response body from json to XML.

# Build

This apicast policy needs a new dependency, and this is desired to explain how
to add external dependencies on a base image.

## Lua-rover

By default, APICast uses lua-rover dependency management, this needs two new
files that help to pin dependencies:

```
$ --> cat Roverfile
luarocks {
        group 'production' {
                module { 'xml2lua' },
        }
}
$ --> cat Roverfile.lock
xml2lua 1.5-2||productionbash-4.4
$ -->
```

This will fetch dependencies from repositories, that maybe, are not managed by
Red Hat at all, so no support is added on this libraries without previous
hardening.

To build the policy, a sample Dockerfile is added, and from there all code is
created and it's possible to use on APICast or 3Scale operator.

To build, a simple makefile target is added:

```
make build
```

# Test

To test configuration, the easiest way it's to create a sample config file
`config.json` and use a fake backend auth handler. This is defined on the
makefile target `test`

```
make test
```

And to test directly, use the following target:

```
make test-call
```

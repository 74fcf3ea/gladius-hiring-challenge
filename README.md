# Solution to Gladius Hiring Challenge

[Hiring Challenge](https://github.com/gladiusio/gladius-hiring-challenge/)
solution by Ben Cottrell <tamino@wolfhut.org>

## Summary

The source code that comprises my solution to the challenge is
[gladiusapp](gladiusapp) in this directory.

I did this work between the evening of April 15 and the evening of
April 17. I was given the contract address by Marcelo McAndrew on
the morning of April 16.

Using my project, I submitted my application to the Ropsten test network
late at night on April 17. The address the application came from was
0x74fcf3ea15d440ebcb7954c50f3ae429a640ddfb, the transaction hash was
0xb3e64cf6a56494af20f722d6bc935e881f54e32ea1e3811a6d63cbda017e33f6,
and it became part of the Ropsten block chain in block number 3060852,
with block hash
0xebde79a33e5a74f991a656a0a2476d83b09aac97a6c6badbea1bb301fb9bc197.

## Details

I chose Python because it's what I'm best at cranking out large amounts
of code quickly in.

In order to build this project I needed three things:

- a web application framework
- a PGP encryption/decryption library
- an Ethereum JSON RPC library

For the web application framework I just chose to go with what I
know, and make it a plain, 1990s-style CGI script. I've worked on
projects at various employers that have been in more sophisticated
frameworks like Django, but I have no clue how to set up such a
project from scratch. Given the 48-hour time limit, CGI was the way
to go.

For the PGP library I chose the GPGME bindings for Python. I initially
wrote my own wrapper around the command-line `gpg` tool, passing the
passphrase in on a separate file descriptor with `--passphrase-fd`,
which... worked... but when I discovered that there were official
bindings, I switched over to using them because it seemed cleaner.
Either way requires a temporary directory; I use Python's `tempfile`
module to create temporary directories in a way that automatically
cleans them up afterwards.

Because I was new to Ethereum and I was feeling conservative, I chose
the `web3py` library. It was the "safe" choice. I didn't want to end up
going my own way and doing something different, and then finding that
I'd painted myself into an "if you had just used the library..." corner.

Usually I prefer Python 2, but since I was using `web3py`, and since
`web3py` only supports Python 3, I had to use Python 3 for the challenge.

The finished CGI script is [gladiusapp](gladiusapp) in this directory.
If you're trying to run this on your own, you might need to change the
shebang line to a Python 3 virtualenv that has `web3py` and the GPGME
bindings installed into it. You might also need to change the value of
the `g_form_url` variable (towards the top of the file) if the name you
install it into your `cgi-bin` directory as, is different from the
filename in github.

There is a more detailed design writeup in the code itself, towards
the top. This more detailed writeup covers details about how the
web application itself is designed and works.

## Wishlist / possible future enhancements

If I could do it over again, and if I had more time, I might choose to
roll my own Ethereum JSON RPC library. The `web3py` library is complex,
pulls in a lot of dependencies, and even just importing it takes almost
10 seconds. (Yes, really!)

As far as I can tell, there are three main components that make up an
Ethereum JSON RPC library like `web3py`:

- an HTTP client
- an ABI encoder/decoder (takes as input the ABI description in JSON, and
  allows you to encode function arguments and decode return values,
  according to what the JSON ABI description says)
- gas price estimation (allows you to choose between a gas price that
  will be low but might take a while, versus a gas price that will get
  your transactions done quickly if you're willing to spend a little more)

None of these seem to me like they ought to be that hard:

- HTTP client: the builtin Python one should be plenty
- ABI encoder/decoder: Not inherently difficult. I was noodling around
  and I came up with an implementation that, at the very least, passes
  the test cases at the bottom of the
  [ABI spec](http://solidity.readthedocs.io/en/v0.4.21/abi-spec.html).
- gas price estimation: This seems like the tricky bit. My first idea
  was to request the current gas price from the server and then apply
  a multiplier, but it seems like the server doesn't answer intelligently
  and only returns a fixed value. I'd have to look at this more.

My goal would be to make a library whose only dependency would be a Keccak
implementation, and which would take a fraction of a second to import.

## Appendix

[gladius_simulator.sol](gladius_simulator.sol), in this directory, is
the Solidity source of the contract I used to test my code with before
actually running it against the "official" contract. It supports some
additional operations that are aimed at debugging; for example, you can
change the schemas and the public key, in case you want to test what
happens if there are syntax errors in either one.

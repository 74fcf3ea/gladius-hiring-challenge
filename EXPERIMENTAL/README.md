# Experimental Noodling Around

When I said in [the main README](../README.md) that I'd been noodling
around with making my own JSON RPC client, this is what I'd been playing
with. (It's Python 2, not Python 3.) I got it to the point where it had
enough features and was working well enough to run my own `gladiusapp`
against it.

This directory also includes a version of `gladiusapp` that is made to
work with my client. It, likewise, has been converted to work under Python 2.

It still needs the GPGME bindings, but it no longer needs web3. It can
be run in a Python 2 virtualenv that has had the GPGME bindings installed into
it with `pip`, and that has had my JSON RPC library installed into it
with `easy_install`.

This library code is not very polished. It should not be considered
the "main part" of my submission to the challenge. `:-)` My challenge
submission stands, as the code I submitted last night. But in case you
guys are curious where I was going with the idea.

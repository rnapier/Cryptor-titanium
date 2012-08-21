This is a wrapper around [RNCryptor](https://github.com/rnapier/RNCryptor) for
Titanium. It assists in correctly encrypting and decrypting data with AES. See
the RNCryptor docs for full details.

There are several important caveats:

* I don't actively support this wrapper anymore. Anyone interested in doing
  so, please contact me.

* This wrapper requires CommonCryptor, which is specific to iOS. That means
  that it only works on iOS. This is not a cross-platform solution.

* This wrapper is based on the synchronous form of RNCryptor. Trying to add
  asynchronous support is what made me give up on Titanium. Not because the
  JavaScript was difficult. Obviously JavaScript handles asynchronous
  operations just fine. It was the incredible pain of trying to develop and
  debug using Titanium Studio. If you're using Titanium to avoid learning
  ObjC, I assure you that ObjC is much, much simpler.

Given the above, I don't especially recommend this module. I don't really
recommend Titanium at all, and particularlly don't recommend Titanium as an
iOS-only development platform. But if using CommonCrypto is important to you,
then this is an option. RNCryptor also optionally interoperates with OpenSSL,
which can be useful (though OpenSSL is not a very secure format and I don't
recommend it if you can avoid it).

For an excellent JavaScript-only implementation of AES, see the [Stanford
Javascript Crypto Library](http://crypto.stanford.edu/sjcl/). Dan Boneh, who
taught me much of what I know about crypto, is one of the authors. I highly
recommend his [crypto course](https://class.coursera.org/crypto/), available
for free through Coursera.
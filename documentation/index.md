# cryptor Module

## Description

Encryptor/Decryptor for iOS

Provides an easy-to-use, Titanium interface to the AES functionality of CommonCrypto. Simplifies correct handling of
password stretching (PBKDF2), salting, and IV. For more information on these terms, see ["Properly encrypting with AES
with CommonCrypto,"](http://robnapier.net/blog/aes-commoncrypto-564) and [iOS 5 Programming Pushing the Limits](http://iosptl.com), Chapter 11. Also includes automatic HMAC handling to integrity-check messages.

For full details of the underlying ObjC code and data format, see [RNCryptor](https://github.com/rnapier/RNCryptor).

## Accessing the cryptor Module

To access this module from JavaScript, you would do the following:

    var module = require('net.robnapier.cryptor');
    var cryptor = module.createAES256Cryptor;

The cryptor variable is a reference to the Cryptor object.

## Reference

### encryptStringWithPassword(plaintextString, passwordString)

Returns a blob containing the encrypted data, along with required metadata and HMAC authentication tag.

### decryptDataWithPassword(encryptedBlob, passwordString)

Returns a blob containing the decrypted data. `encryptedBlob` must be in the format created by the encryption functions. If there is any error decrypting the data, the result will be nil.

### encryptFileToFileWithPassword(plaintextFile, encryptedFile, passwordString)

Encrypts the contents of `plaintextFile` (`Ti.File`), writing to `encryptedFile`. Encryption is handled block by block, so this can handle files of arbitrary size. Output file is overwritten if possible.

Returns a boolean indicating whether the encryption was successful. If unsuccessful, `encryptedFile` may still exist.

### decryptFileToFileWithPassword(encryptedFile, plaintextFile, passwordString)

Decrypts the contents of `encryptedFile` (`Ti.File`), writing to `plaintextFile`. Decryption is handled block by block, so this can handle files of arbitrary size. Output file is overwritten if possible.

Returns a boolean indicating whether the encryption was successful. If unsuccessful, `plaintextFile` may still exist. You must check the return value and discard the output file on error. An error generally indicates a bad password, but may indicate that the file has been modified.

## Usage

	var module = require('net.robnapier.cryptor');
	var cryptor = module.createAES256Cryptor;

	var password = "PassW0rd";

	// String -> blob encryption
	var encryptedBlob = cryptor.encryptStringWithPassword("Test data", password);

	// Blob -> blob decryption. Note use of .text to extract the string.
	label.text = cryptor.decryptDataWithPassword(encryptedBlob, password).text;

	var fileToEncrypt = Ti.Filesystem.getFile(Ti.Filesystem.applicationDataDirectory, 'someFile.txt');
	fileToEncrypt.write("Some data to encrypt");

	var encryptedFile = Ti.Filesystem.getFile(Ti.Filesystem.applicationDataDirectory, 'encryptedFile.txt');

	// File -> file encryption
	cryptor.encryptFileToFileWithPassword(fileToEncrypt, encryptedFile, password);
	fileToEncrypt.deleteFile();

	// File -> file decryption. Note check for success
	result = cryptor.decryptFileToFileWithPassword(encryptedFile, fileToEncrypt, password);
	if (! result) {
		fileToEncrypt.deleteFile();
	}

## Author

Rob Napier robnapier@gmail.com http://robnapier.net

## License

Commercial license. See LICENSE file for details.

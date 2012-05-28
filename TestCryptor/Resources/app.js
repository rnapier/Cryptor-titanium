// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var window = Ti.UI.createWindow({
	backgroundColor:'white'
});
var label = Ti.UI.createLabel();
window.add(label);
window.open();

var module = require('net.robnapier.cryptor');
var cryptor = module.createAES256Cryptor;
Ti.API.info("module is => " + cryptor);

var password = "PassW0rd";

var encryptedBlob = cryptor.encryptStringWithPassword("Test data", password);

label.text = cryptor.decryptDataWithPassword(encryptedBlob, password).text;

var fileToEncrypt = Ti.Filesystem.getFile(Ti.Filesystem.applicationDataDirectory, 'someFile.txt');
fileToEncrypt.write("Some data to encrypt");

var encryptedFile = Ti.Filesystem.getFile(Ti.Filesystem.applicationDataDirectory, 'encryptedFile.txt');

cryptor.encryptFileToFileWithPassword(fileToEncrypt, encryptedFile, password);

fileToEncrypt.deleteFile();

cryptor.decryptFileToFileWithPassword(encryptedFile, fileToEncrypt, password);
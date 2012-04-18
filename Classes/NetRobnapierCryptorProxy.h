//
//  NetRobnapierCryptorProxy.h
//  cryptor
//
//  Created by Robert Napier on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TiProxy.h"

@interface NetRobnapierCryptorProxy : TiProxy

+ (NetRobnapierCryptorProxy *)AES256Cryptor;

// blob = encryptStringWithPassword(string, passwordString)
- (id)encryptStringWithPassword:(id)args;

// blob = decryptDataWithPassword(blob, passwordString)
- (id)decryptDataWithPassword:(id)args;

// resultBool = encryptFileToFileWithPassword(inFile, outFile);
- (BOOL)encryptFileToFileWithPassword:(id)args;

// resultBool = decryptFileToFileWithPassword(inFile, outFile);
- (BOOL)decryptFileToFileWithPassword:(id)args;


@end

//
//  NetRobnapierCryptorProxy.m
//  cryptor
//
//  Created by Robert Napier on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NetRobnapierCryptorProxy.h"
#import <RNCryptor/RNCryptor.h>
#import "TiBlob.h"
#import "TiFile.h"

@interface NetRobnapierCryptorProxy ()
@property (nonatomic, readonly, strong) RNCryptor *cryptor;
@end

@implementation NetRobnapierCryptorProxy
@synthesize cryptor = __cryptor;

+ (NetRobnapierCryptorProxy *)AES256Cryptor
{
  return [[[self alloc] initWithCryptor:[RNCryptor AES256Cryptor]] autorelease];
}

- (id)initWithCryptor:(RNCryptor *)aCryptor
{
  self = [super init];
  if (self)
  {
    __cryptor = [aCryptor retain];
  }
  return self;
}

- (void)dealloc
{
  [__cryptor release]; __cryptor = nil;
  [super dealloc];
}

- (id)encryptStringWithPassword:(id)args
{
  NSString *string = [args objectAtIndex:0];
  NSString *password = [args objectAtIndex:1];
  
  NSData *encryptedData = [self.cryptor encryptData:[string dataUsingEncoding:NSUTF8StringEncoding] password:password error:NULL];
  return [[[TiBlob alloc] initWithData:encryptedData mimetype:nil] autorelease];
}

- (id)decryptDataWithPassword:(id)args
{
  TiBlob *blob = [args objectAtIndex:0];
  NSString *password = [args objectAtIndex:1];
  
  NSData *decryptedData = [self.cryptor decryptData:blob.data password:password error:NULL];
  return [[[TiBlob alloc] initWithData:decryptedData mimetype:@"application/octet-stream"] autorelease];
}

- (BOOL)encryptFileToFileWithPassword:(id)args
{
  TiFile *inFile = [args objectAtIndex:0];
  TiFile *outFile = [args objectAtIndex:1];
  NSString *password = [args objectAtIndex:2];

  NSInputStream *inStream = [NSInputStream inputStreamWithFileAtPath:inFile.path];
  NSOutputStream *outStream = [NSOutputStream outputStreamToFileAtPath:outFile.path append:NO];

  return [self.cryptor encryptFromStream:inStream toStream:outStream password:password error:NULL];
}

- (BOOL)decryptFileToFileWithPassword:(id)args
{
  TiFile *inFile = [args objectAtIndex:0];
  TiFile *outFile = [args objectAtIndex:1];
  NSString *password = [args objectAtIndex:2];

  NSInputStream *inStream = [NSInputStream inputStreamWithFileAtPath:inFile.path];
  NSOutputStream *outStream = [NSOutputStream outputStreamToFileAtPath:outFile.path append:NO];

  return [self.cryptor decryptFromStream:inStream toStream:outStream password:password error:NULL];
}


@end

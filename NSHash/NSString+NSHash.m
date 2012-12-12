//
//  Copyright 2012 Christoph Jerolimov
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License
//

#import "NSString+NSHash.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (NSHash)

- (NSMutableString*) md5 {
	unsigned int inputLength = (unsigned int) [self lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
	unsigned int outputLength = CC_MD5_DIGEST_LENGTH;
	unsigned char output[outputLength];
	
	CC_MD5(self.UTF8String, inputLength, output);
	return [self toHexString:output length:outputLength];;
}

- (NSMutableString*) sha1 {
	unsigned int inputLength = (unsigned int) [self lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
	unsigned int outputLength = CC_SHA1_DIGEST_LENGTH;
	unsigned char output[outputLength];
	
	CC_SHA1(self.UTF8String, inputLength, output);
	return [self toHexString:output length:outputLength];;
}

- (NSMutableString*) sha256 {
	unsigned int inputLength = (unsigned int) [self lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
	unsigned int outputLength = CC_SHA256_DIGEST_LENGTH;
	unsigned char output[outputLength];
	
	CC_SHA256(self.UTF8String, inputLength, output);
	return [self toHexString:output length:outputLength];;
}

- (NSMutableString*) toHexString:(unsigned char*) data length: (unsigned int) length {
	NSMutableString* hash = [NSMutableString stringWithCapacity:length * 2];
	for (unsigned int i = 0; i < length; i++) {
		[hash appendFormat:@"%02x", data[i]];
		data[i] = 0;
	}
	return hash;
}

@end

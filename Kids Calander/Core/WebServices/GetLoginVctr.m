//
//  GetLoginVctr.m
//  School Kal
//
//  Created by Puja Ankit Vyas on 19/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import "GetLoginVctr.h"

@implementation GetLoginVctr
- (void)GetLoginServiceRequest:(NSString *)SerVerUrl Controller:(UIViewController *)ViewCtr{
    self.vctr = ViewCtr;
    [APP_DEL showProgressHUDaView:self.vctr.view];
    self.webData=[NSMutableData data];
    NSString *StrReq = [JFUrlUtil encodeUrl:SerVerUrl];
    NSMutableURLRequest *theReq = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:StrReq]];
    [NSURLConnection connectionWithRequest:theReq delegate:self];
}
#pragma mark -
#pragma mark NSURLConnection

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.webData setLength: 0];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[self.webData appendData:data];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[APP_DEL hideProgressHUD];
    [self didFailWithError:[error debugDescription]];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	NSString *str = [[NSString alloc] initWithData:self.webData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.webData];
    parser.delegate=self;
    [parser parse];
    [APP_DEL hideProgressHUD];
}
#pragma mark -
#pragma mark Parsing

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	[APP_DEL hideProgressHUD];
    if([self.arrForResult count]>0)
        [self didFinishFetchingRecords:self.arrForResult];
    else
        [self didFailWithError:@"No Records Found"];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if([elementName isEqualToString:@"root"]) {
        self.arrForResult = [NSMutableArray array];
    } else if ([elementName isEqualToString:@"subroot"]) {
        self.dMain = [NSMutableDictionary dictionary];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if(!self.string) self.string = [NSMutableString string];
    [self.string appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if([elementName isEqualToString:@"root"]) {
        
    } else if ([elementName isEqualToString:@"subroot"]) {
        [self.arrForResult addObject:self.dMain];
    } else {
        [self.dMain setValue:self.string forKey:elementName];
        self.string=nil;
    }
}
#pragma mark -
- (void)didFinishFetchingRecords:(id)response{
    if([self.vctr respondsToSelector:@selector(SuccessfullyReceivedLoginresponse:)]) {
        id <GetLoginDelegate> obj = (id)self.vctr;
        [obj SuccessfullyReceivedLoginresponse:response];
	}
}
- (void)didFailWithError:(id)sender{
    if([self.vctr respondsToSelector:@selector(LoginFailWithError:)]) {
        id <GetLoginDelegate> obj = (id)self.vctr;
        [obj LoginFailWithError:sender];
	}
}
@end

//
//  SYSoapTool.m
//  BestSoapTool
//
//  Created by Serdar YILLAR on 12/28/12.
//  Copyright (c) 2012 yillars. All rights reserved.
//

#import "SYSoapTool.h"
#import "SYXmlParser.h"

@implementation SYSoapTool{
    
    NSURLConnection *theConnection;
    NSMutableData *receivedData;
    NSXMLParser *XParser;
    NSString *LaStr;
    NSMutableArray *resultArray;
    SYXmlParser *parser;
    
    
    NSString *functionName;
    NSString *soapUrl;
    NSMutableArray *tags;
    NSMutableArray *vars;
    NSMutableData *webData;
    NSString *GetSourcename;
    
}
@synthesize delegate;

-(void)startSoapTool:(int)__status{
    
    //0 = withoutParameter
    //1 = withParameter
    
    
    NSURL *urlm = [NSURL URLWithString:soapUrl];
    NSMutableString *log = [NSMutableString string];
    
    [log appendString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
     "<soap:Body>"];
    
    
    if (__status == 1) {
        [log appendString:[NSString stringWithFormat:@"\n<%@ xmlns=\"%@/\">\n",functionName,GetSourcename]];
    }else{
        [log appendString:[NSString stringWithFormat:@"\n<%@ xmlns=\"%@\"/>",functionName,GetSourcename]];
    }
    
    
    for (int i=0; i<[tags count]; i++) {
        
        if(__status == 1){
            NSString *strResult = [NSString stringWithFormat:@"<%@>%@</%@>", [tags objectAtIndex:i],[vars objectAtIndex:i],[tags objectAtIndex:i]];
            
            [log appendString:strResult];
        }
        
        
        
    }
    if (__status == 1) {
        [log appendString:[NSString stringWithFormat:@"\n</%@>\n</soap:Body>\n</soap:Envelope>",functionName]];
    }else{
        [log appendString:[NSString stringWithFormat:@"\n</soap:Body>\n</soap:Envelope>"]];
    }
    NSLog(@"log %@",log);
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:urlm];
	NSString *msgLength = [NSString stringWithFormat:@"%d", [log length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"urn:examples:contentservice" forHTTPHeaderField:@"SOAPAction"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [log dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"the request %@",theRequest);
//    NSData* aData;
//    aData = [log dataUsingEncoding: NSUTF8StringEncoding];
//    
//    [url setHTTPBody:aData];
    
    theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		webData = [NSMutableData data];
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}
    
}

-(void)callSoapServiceWithoutParameters__functionName:(NSString*)___functionName wsdlURL:(NSString*)___url{
    
    functionName =     ___functionName;
    soapUrl      =     ___url;
    
    [self startSoapTool:0];
    
}


-(void)callSoapServiceWithParameters__functionName:(NSString*)___functionName tags:(NSMutableArray*)___tags vars:(NSMutableArray*)___vars wsdlURL:(NSString*)___url sourcename:(NSString *)Sourcename{
    
    functionName =     ___functionName;
    soapUrl      =     ___url;
    tags         =     ___tags;
    vars         =     ___vars;
    GetSourcename   =     Sourcename;
    
    [self startSoapTool:1];
    
  
}

-(void)serviceDone{
    
    
    [delegate retriveFromSYSoapTool:resultArray];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	if(connection == theConnection)
	{
		receivedData=[[NSMutableData alloc] init];
	}
	
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)datas
{
	if(connection == theConnection)
	{
		[receivedData appendData:datas];
        NSLog(@"recieveddata %@",receivedData);
		LaStr = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
        NSLog(@"latstr %@",LaStr);
	}
	
}
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    
}
- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
	if(connection == theConnection)
	{
		
		
		//NSString * hold = [[NSString alloc] initWithFormat:@"Connection failed! Error - %@",[error localizedDescription]];
        
		NSLog(@"error  %@",error.description);
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		
	}
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	
	
	if(connection == theConnection)
	{
		
		NSLog(@"LaStr %@",LaStr);
		NSString * tmp = [[NSString alloc] initWithFormat:@"%@",LaStr];
		
		//NSLog(@"bu kadar  %@",tmp);
        
		NSData* tmp_Data = [tmp dataUsingEncoding: NSUTF8StringEncoding];
		
        
        
        parser = [[SYXmlParser alloc]initWithData:tmp_Data];
        
        [parser startParser];
        
        if([parser theDataArray] != nil && [[parser theDataArray]count] != 0)
        {
            resultArray = [[NSMutableArray alloc]initWithArray:[parser theDataArray]];
            
            [self performSelectorOnMainThread:@selector(loadFinished) withObject:nil waitUntilDone:YES];
        }
        
		
	}
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
    
}

-(void)loadFinished{
    
    [self serviceDone];
}


-(NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse
{
	NSURLRequest *newRequest=request;
	if (redirectResponse)
	{
		newRequest=nil;
	    
	}
	
	return newRequest;
}
@end
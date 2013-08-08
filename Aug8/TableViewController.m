//
//  TableViewController.m
//  Aug8
//
//  Created by david morton on 8/8/13.
//  Copyright (c) 2013 David Morton Enterprises. All rights reserved.
//

#import "TableViewController.h"
#import "Airport.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
	self = [super initWithStyle: style];
	if (self) {
		cellReuseIdentifier = @"airports";
		
		//Three default values from class UIScrollView.
		self.tableView.bounces = YES;
		self.tableView.scrollsToTop = YES;
		self.tableView.decelerationRate = UIScrollViewDecelerationRateNormal;
		
		//Start of work on sections
		//self.tableView.
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	//self.sections = [NSArray arrayWithObjects:@"#", @"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", nil];

	[self.tableView registerClass: [UITableViewCell class]
		   forCellReuseIdentifier: cellReuseIdentifier];	

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation
{
	// Return YES for supported orientations
	//return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _airports.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	UITableViewCell *cell =[tableView cellForRowAtIndexPath: indexPath];
	
	if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellReuseIdentifier] ;
    }else{
		cell =
		[tableView dequeueReusableCellWithIdentifier: cellReuseIdentifier forIndexPath: indexPath];
	}
	
	// Configure the cell...
	//The .textLabel and .detailTextLabel properties are UILabels.
	//The .imageView property is a UIImage.
	Airport *thisAirport=[_airports objectAtIndex: indexPath.row];
	
	NSMutableString *labelText=[[NSMutableString alloc] init];
	[labelText appendString:thisAirport.city];
	[labelText appendString:@", "];
	[labelText appendString:thisAirport.stateProvince];
	[labelText appendString:@" ("];
	[labelText appendString:thisAirport.code];
	[labelText appendString:@" )"];

	cell.textLabel.text = labelText;
	
	NSMutableString *detailText=[[NSMutableString alloc] init];
	[detailText appendString:thisAirport.name];
	cell.detailTextLabel.text=detailText;
	
	//NSString *fileName = [cell.textLabel.text stringByAppendingString: @".jpg"];
	//cell.imageView.image = [UIImage imageNamed: fileName];	//nil if .jpg file doesn't exist
	return cell;
	
	
	
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"didSelectRowAtIndexPath");
	Airport *thisAirport=[_airports objectAtIndex: indexPath.row];
	
	NSString *string = [@"http://www.flightstats.com/go/Mobile/airportDetails.do?airportCode=" stringByAppendingString: thisAirport.code];
	NSURL *url = [NSURL URLWithString: string];
	NSData *data = [NSData dataWithContentsOfURL: url];
	
	if (data == nil) {
		NSLog(@"could not load URL %@", url);
	} else {
		UIWebView *webView = [[UIWebView alloc] initWithFrame: CGRectZero];
		webView.scalesPageToFit = YES;
		[webView loadData: data
				 MIMEType: @"text/html"
		 textEncodingName: @"NSUTF8StringEncoding"
				  baseURL: url
		 ];
		
		//Give the web view a generic view controller.
		UIViewController *viewController =
		[[UIViewController alloc] initWithNibName: nil bundle: nil];
		viewController.title = thisAirport.code;
		viewController.view = webView;
		[self.navigationController pushViewController: viewController animated: YES];
	}
	
	
	
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end

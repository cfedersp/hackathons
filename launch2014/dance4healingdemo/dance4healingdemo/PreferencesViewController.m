//
//  ViewController.m
//  dance4healingdemo
//
//  Created by Charlie Federspiel on 2/21/14.
//  Copyright (c) 2014 Charlie Federspiel. All rights reserved.
//

#import "PreferencesViewController.h"
#import "MoodViewController.h"

@interface PreferencesViewController ()

@end

@implementation PreferencesViewController

@synthesize genres;
@synthesize preferences;
@synthesize genresTableView;

- (id)init
{
        self = [super init];
    if (self) {

    //[genresTableView setDelegate:self]; // this is indicated in the storyboard's connection inspector
    //[genresTableView setDataSource:self]; // only use these when creating views dynamically
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.genres = [[NSArray alloc] initWithObjects:@"a cappella", @"abstract hip hop", @"acid house", @"acid jazz", @"acid techno", @"acousmatic", @"acoustic blues", @"acoustic pop", @"adult album alternative", @"adult standards", @"african percussion", @"african rock", @"afrikaans", @"afrobeat", @"afrobeats", @"aggrotech", @"albanian pop", @"album rock", @"alternative americana", @"alternative country", @"alternative dance", @"alternative emo", @"alternative hip hop", @"alternative metal", @"alternative new age", @"alternative pop", @"alternative r&b", @"alternative rock", @"ambeat", @"ambient", @"ambient idm", @"andean", @"anime", @"anti-folk", @"arab folk", @"arab pop", @"argentine rock", @"art rock", @"atmospheric black metal", @"atmospheric post rock", @"austindie", @"australian alternative rock", @"australian hip hop", @"australian indie", @"australian pop", @"austropop", @"avant-garde", @"avant-garde jazz", @"avantgarde metal", @"axe", @"azonto", @"bachata", @"baile funk", @"balearic", @"balkan brass", @"banda", @"bangla", @"barbershop", @"baroque", @"basque rock", @"bass music", @"beach music", @"beatdown", @"bebop", @"belgian indie", @"belgian rock", @"belly dance", @"benga", @"bhangra", @"big band", @"big beat", @"black death", @"black metal", @"bluegrass", @"blues", @"blues-rock", @"bolero", @"boogaloo", @"boogie-woogie", @"bossa nova", @"bounce", @"bouncy house", @"brass band", @"brazilian gospel", @"brazilian hip hop", @"brazilian indie", @"brazilian pop music", @"brazilian punk", @"breakbeat", @"breakcore", @"breaks", @"brega", @"breton folk", @"brill building pop", @"british blues", @"british folk", @"british invasion",
                   @"britpop", @"broken beat", @"brostep", @"brutal death metal", @"brutal deathcore", @"bubble trance", @"bubblegum dance", @"bubblegum pop", @"bulgarian rock", @"c-pop", @"c86", @"cabaret", @"calypso", @"canadian indie", @"canadian pop", @"cantautor", @"canterbury scene", @"cantopop", @"capoeira", @"carnatic", @"ccm", @"cello", @"celtic", @"celtic christmas", @"celtic rock", @"chalga", @"chamber pop", @"chanson", @"chaotic black metal", @"chaotic hardcore", @"charred death", @"chicago blues", @"chicago house", @"chicago soul", @"chicano rap", @"children's music", @"chilean rock", @"chill lounge", @"chill-out", @"chillwave", @"chinese indie rock", @"chinese traditional", @"chiptune", @"choral", @"choro", @"chr", @"christian alternative rock", @"christian christmas", @"christian dance", @"christian hardcore", @"christian hip hop", @"christian metal", @"christian music", @"christian punk", @"christian rock", @"christmas", @"christmas product", @"cinematic dubstep", @"classic chinese pop", @"classic danish pop", @"classic finnish pop", @"classic funk rock", @"classic garage rock", @"classic italian pop", @"classic norwegian pop", @"classic polish pop", @"classic rock", @"classic russian rock", @"classic swedish pop", @"classical", @"classical christmas", @"classical guitar", @"classical period", @"classical piano", @"comedy", @"comic", @"complextro", @"contemporary classical", @"contemporary country", @"contemporary jazz", @"contemporary post-bop", @"cool jazz", @"corrosion", @"country", @"country blues", @"country christmas", @"country gospel", @"country rock", @"coupe decale", @"coverchill",
                   @"cowpunk", @"crack rock steady", @"croatian pop", @"crossover thrash", @"crunk", @"crust punk", @"cuban rumba", @"cumbia", @"cumbia villera", @"current", @"czech folk", @"dance pop", @"dance rock", @"dance-punk", @"dancehall", @"dangdut", @"danish pop", @"danish pop rock", @"dansband", @"dark ambient", @"dark black metal", @"dark cabaret", @"dark psytrance", @"dark wave", @"darkstep", @"death core", @"death metal", @"deathgrind", @"deep ambient", @"deep chill", @"deep disco house", @"deep flow", @"deep funk", @"deep house", @"deep liquid", @"deep soul house", @"deep tech house", @"deep trap", @"deeper house", @"delta blues", @"demoscene", @"desert blues", @"desi", @"detroit techno", @"digital hardcore", @"dirty south rap", @"disco", @"disco house", @"discovery", @"djent", @"doo-wop", @"doom metal", @"doomcore", @"downtempo", @"downtempo fusion", @"dream pop", @"dreamo", @"drill and bass", @"drone", @"drum and bass", @"drumfunk", @"dub", @"dub techno", @"dubstep", @"duranguense", @"dutch hip hop", @"dutch house", @"dutch pop", @"dutch rock", @"early music", @"east coast hip hop", @"easy listening", @"ebm", @"ecuadoria", @"edm", @"electric blues", @"electro", @"electro dub", @"electro house", @"electro latino", @"electro swing", @"electro trash", @"electro-industrial", @"electroacoustic improvisation", @"electroclash", @"electronic", @"emo", @"emo punk", @"enka", @"entehno", @"environmental", @"estonian pop", @"ethereal gothic", @"ethereal wave", @"ethiopian pop", @"eurobeat", @"eurodance", @"europop", @"eurovision", @"exotica", @"experimental", @"experimental psych", @"experimental rock",
                   @"fado", @"fallen angel", @"faroese pop", @"fast melodic punk", @"filmi", @"filter house", @"filthstep", @"fingerstyle", @"finnish hardcore", @"finnish hip hop", @"finnish pop", @"flamenco", @"flick hop", @"folk", @"folk christmas", @"folk metal", @"folk punk", @"folk rock", @"folk-pop", @"folkmusik", @"footwork", @"forro", @"fourth world", @"freak folk", @"freakbeat", @"free improvisation", @"free jazz", @"freestyle", @"french folk", @"french folk pop", @"french hip hop", @"french indie pop", @"french pop", @"french rock", @"full on", @"funeral doom", @"funk", @"funk metal", @"funk rock", @"future garage", @"futurepop", @"g funk", @"gabba", @"gamelan", @"gangster rap", @"garage pop", @"garage rock", @"geek folk", @"geek rock", @"german hip hop", @"german indie", @"german oi", @"german pop", @"german punk", @"ghettotech", @"glam metal", @"glam rock", @"glitch", @"glitch hop", @"goa trance", @"goregrind", @"gospel", @"gothic alternative", @"gothic americana", @"gothic doom", @"gothic metal", @"gothic post-punk", @"gothic rock", @"gothic symphonic metal", @"grave wave", @"greek hip hop", @"grim death metal", @"grime", @"grindcore", @"groove metal", @"grunge", @"grunge pop", @"grupera", @"guidance", @"gujarati", @"gypsy jazz", @"hands up", @"happy hardcore", @"hard alternative", @"hard bop", @"hard glam", @"hard house", @"hard rock", @"hard trance", @"hardcore", @"hardcore breaks", @"hardcore hip hop", @"hardcore punk", @"hardcore techno", @"hardstyle", @"harmonica blues", @"harp", @"hawaiian", @"heavy alternative", @"heavy christmas", @"hi nrg", @"highlife", @"hindustani classical",
                   @"hip hop", @"hip house", @"hip pop", @"hiplife", @"horror punk", @"hot", @"hot adult contemporary", @"house", @"hungarian hip hop", @"hungarian pop", @"hurban", @"hyphy", @"icelandic pop", @"idol", @"illbient", @"indian classical", @"indian pop", @"indian rock", @"indie christmas", @"indie folk", @"indie pop", @"indie rock", @"indie shoegaze", @"indietronica", @"indonesian pop", @"industrial", @"industrial metal", @"industrial rock", @"intelligent dance music", @"irish folk", @"irish rock", @"israeli rock", @"italian disco", @"italian hip hop", @"italian indie pop", @"italian pop", @"italian progressive rock", @"j-alt", @"j-ambient", @"j-core", @"j-dance", @"j-idol", @"j-indie", @"j-metal", @"j-pop", @"j-poprock", @"j-punk", @"j-rap", @"j-rock", @"j-theme", @"jam band", @"jangle pop", @"japanese psychedelic", @"japanese r&b", @"japanese standards", @"japanese traditional", @"japanoise", @"jazz", @"jazz blues", @"jazz christmas", @"jazz funk", @"jazz fusion", @"jazz metal", @"jazz orchestra", @"jerk", @"judaica", @"jug band", @"juggalo", @"jump blues", @"jump up", @"jungle", @"k-hop", @"k-indie", @"k-pop", @"k-rock", @"kabarett", @"kannada", @"kirtan", @"kiwi rock", @"kizomba", @"klezmer", @"kompa", @"kraut rock", @"kuduro", @"kwaito", @"la indie", @"laiko", @"latin", @"latin alternative", @"latin christian", @"latin christmas", @"latin hip hop", @"latin jazz", @"latin metal", @"latin pop", @"latvian pop", @"lds", @"liedermacher", @"lilith", @"liquid funk", @"lithumania", @"lo star", @"lo-fi", @"louisiana blues", @"lounge", @"lovers rock", @"lowercase", @"luk thung", @"madchester",
                   @"maghreb", @"makossa", @"malagasy folk", @"malayalam", @"malaysian pop", @"mambo", @"mande pop", @"mandopop", @"manele", @"marching band", @"mariachi", @"martial industrial", @"mashup", @"math pop", @"math rock", @"mathcore", @"mbalax", @"medieval", @"medieval rock", @"meditation", @"mellow gold", @"melodic death metal", @"melodic hard rock", @"melodic hardcore", @"melodic metalcore", @"melodic progressive metal", @"memphis blues", @"memphis soul", @"merengue", @"merengue urbano", @"merseybeat", @"metal", @"metalcore", @"metropopolis", @"mexican indie", @"mexican son", @"miami bass", @"microhouse", @"minimal", @"minimal dub", @"minimal dubstep", @"minimal techno", @"minimal wave", @"mizrahi", @"modern blues", @"modern classical", @"modern country rock", @"modern uplift", @"monastic", @"moombahton", @"more baroque", @"more ccm", @"more classical piano", @"more indie pop", @"more melodic death metal", @"more melodic metalcore", @"more orchestral", @"more pop punk", @"more progressive house", @"more tech house", @"more thrash metal", @"more turkish pop", @"more vocal jazz", @"motown", @"movie tunes", @"mpb", @"musique concrete", @"nasheed", @"nashville sound", @"native american", @"neo classical metal", @"neo soul", @"neo soul-jazz", @"neo-industrial rock", @"neo-pagan", @"neo-progressive", @"neo-psychedelic", @"neo-rockabilly", @"neo-singer-songwriter", @"neo-synthpop", @"neo-trad metal", @"neoclassical", @"neofolk", @"nepali", @"nerdcore", @"neue deutsche harte", @"neue deutsche welle", @"neurofunk", @"neurostep", @"new age", @"new age piano", @"new beat", @"new jack swing",
                   @"new orleans blues", @"new orleans jazz", @"new rave", @"new romantic", @"new tribe", @"new wave", @"new weird america", @"ninja", @"nintendocore", @"nl folk", @"no wave", @"noise pop", @"noise punk", @"noise rock", @"nordic folk", @"norteno", @"northern soul", @"norwegian jazz", @"norwegian pop", @"norwegian rock", @"nu age", @"nu disco", @"nu gaze", @"nu jazz", @"nu metal", @"nu skool breaks", @"nu-cumbia", @"nueva cancion", @"nursery", @"nwobhm", @"nwothm", @"oi", @"old school hip hop", @"old-time", @"opera", @"operatic pop", @"opm", @"oratory", @"orchestral", @"orgcore", @"outlaw country", @"outsider", @"pagan black metal", @"pagode", @"pakistani pop", @"persian pop", @"peruvian rock", @"piano blues", @"piano rock", @"piedmont blues", @"pipe band", @"poetry", @"polish hip hop", @"polish indie", @"polish pop", @"polish reggae", @"polka", @"polynesian pop", @"pop", @"pop christmas", @"pop emo", @"pop punk", @"pop rap", @"pop rock", @"portuguese rock", @"post rock", @"post-disco", @"post-grunge", @"post-hardcore", @"post-metal", @"post-post-hardcore", @"post-punk", @"power blues-rock", @"power electronics", @"power metal", @"power noise", @"power pop", @"power violence", @"power-pop punk", @"progressive bluegrass", @"progressive electro house", @"progressive house", @"progressive metal", @"progressive psytrance", @"progressive rock", @"progressive trance", @"progressive uplifting trance", @"protopunk", @"psych gaze", @"psychedelic blues-rock", @"psychedelic rock", @"psychedelic trance", @"psychill", @"psychobilly", @"pub rock", @"punjabi", @"punk", @"punk blues", @"punk christmas",
                   @"qawwali", @"quebecois", @"quiet storm", @"r&b", @"r-neg-b", @"ragtime", @"rai", @"ranchera", @"rap", @"rap metal", @"rap rock", @"raw black metal", @"reggae", @"reggae fusion", @"reggae rock", @"reggaeton", @"regional mexican", @"renaissance", @"retro metal", @"riddim", @"riot grrrl", @"rock", @"rock 'n roll", @"rock catala", @"rock en espanol", @"rock gaucho", @"rock noise", @"rock steady", @"rockabilly", @"romanian pop", @"romantic", @"roots reggae", @"roots rock", @"rumba", @"russian hip hop", @"russian pop", @"russian punk", @"russian rock", @"salsa", @"samba", @"schlager", @"schranz", @"scottish rock", @"screamo", @"screamo punk", @"sega", @"serialism", @"sertanejo", @"sertanejo tradicional", @"sertanejo universitario", @"sexy", @"shibuya-kei", @"shimmer pop", @"shimmer psych", @"shiver pop", @"shoegaze", @"show tunes", @"singer-songwriter", @"ska", @"ska punk", @"skate punk", @"skiffle", @"skweee", @"slam death metal", @"slash punk", @"sleaze rock", @"slovak pop", @"slovenian rock", @"slow core", @"sludge metal", @"smooth jazz", @"soca", @"soft rock", @"soukous", @"soul", @"soul blues", @"soul christmas", @"soul flow", @"soul jazz", @"soundtrack", @"south african jazz", @"southern gospel", @"southern hip hop", @"southern rock", @"southern soul", @"space rock", @"spanish folk", @"spanish hip hop", @"spanish indie pop", @"spanish pop", @"spanish punk", @"speed garage", @"speed metal", @"speedcore", @"spoken word", @"steampunk", @"stomp and holler", @"stomp pop", @"stoner metal", @"stoner rock", @"straight edge", @"street punk", @"stride",
                   @"string quartet", @"suomi rock", @"surf music", @"swamp blues", @"swedish hip hop", @"swedish indie pop", @"swedish pop", @"swedish punk", @"swing", @"swiss rock", @"sxsw", @"symphonic black metal", @"symphonic metal", @"symphonic rock", @"synthpop", @"taiwanese pop", @"talent show", @"tamil", @"tango", @"tech house", @"technical death metal", @"techno", @"teen pop", @"tejano", @"tekno", @"telugu", @"texas blues", @"texas country", @"thai pop", @"thrash core", @"thrash metal", @"throat singing", @"tibetan", @"tico", @"tin pan alley", @"traditional blues", @"traditional british folk", @"traditional country", @"traditional folk", @"trance", @"trance hop", @"trap music", @"trapstep", @"tribal house", @"tribute", @"trip hop", @"tropical", @"trova", @"turbo folk", @"turkish classical", @"turkish folk", @"turkish pop", @"turntablism", @"twee pop", @"twin cities indie", @"uk garage", @"uk post-punk", @"ukrainian rock", @"underground hip hop", @"underground latin hip hop", @"underground power pop", @"underground rap", @"uplifting trance", @"urban contemporary", @"vallenato", @"vaporwave", @"vegan straight edge", @"velha guarda", @"venezuelan rock", @"video game music", @"vienna indie", @"vietnamese pop", @"viking metal", @"violin", @"viral pop", @"visual kei", @"vocal house", @"vocal jazz", @"vocaloid", @"volksmusik", @"warm drone", @"welsh rock", @"west coast rap", @"western swing", @"wind ensemble", @"witch house", @"wonky", @"workout", @"world", @"world christmas", @"world fusion", @"worship", @"wrock", @"ye ye", @"yugoslav rock", @"zeuhl", @"zim", @"zolo", @"zouglou", @"zouk", @"zydeco", nil];
}
- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.genres = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Number of rows is the number of time zones in the region for the specified section.
    
    
    return [self.genres count];
    
}





- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    // The header for the section is the region name -- get this from the region at the section index.
    
    
    return @"Your Favorite Genres";
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"GenreCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    // Configure the cell.
    cell.textLabel.text = [self.genres objectAtIndex: [indexPath row]];
    
    /*
    if ([indexPath compare:tableView.lastIndexPath] == NSOrderedSame)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    */
    
    return cell;
}

- (IBAction)savePreferencesButtonPressed:(id)sender {
    //NSLog(@"Search Button was Pressed!");
    //NSLog(@"sender: %@,", sender);
    
    //NSLog(@"cap: %@, res: %@", capacityTextBox.text, resolutionTextBox.text);

    //url = [NSURL URLWithString:@"http://www.apple.com/index.html"];
    //MoodViewController *webViewController =
    //[[MoodViewController alloc] initWithURL:url andTitle:@"Apple"];
    //[self presentModalViewController:webViewController animated:YES];
}


- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell* cell = [self tableView:aTableView cellForRowAtIndexPath:indexPath];
    UITableViewCell *cell = [aTableView cellForRowAtIndexPath:indexPath];
    
    
    NSMutableArray *favoriteGenres = [preferences objectForKey:@"FavoriteGenres"];
    if(favoriteGenres == nil) {
        NSLog(@"no genres prefs");

    } else {
        if([favoriteGenres containsObject:cell.textLabel.text]) {
            [favoriteGenres removeObject:cell.textLabel.text];
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell setSelected:FALSE animated:TRUE];
            NSLog(@"%@ item was un-selected! %d", cell.textLabel.text, [favoriteGenres count]);
        } else {
            [favoriteGenres addObject:cell.textLabel.text];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [cell setSelected:TRUE animated:TRUE];
            
            NSLog(@"%@ item was selected! %d", cell.textLabel.text, [favoriteGenres count]);
        }
    }
    
    
    /*
     UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityView startAnimating];
    cell.accessoryView = activityView;
     */
}

/*
- (void)aTableView:(UITableView *)aTableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [aTableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [cell setSelected:TRUE animated:TRUE]; // select
    NSLog(@"%@ item was highlighted!", cell.textLabel.text);
}

- (void)aTableView:(UITableView *)aTableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [aTableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    [cell setSelected:FALSE animated:TRUE]; // select
    NSLog(@"%@ item was un-highlighted!", cell.textLabel.text);
}
*/

// In a story board-based application, you will often want to do a little preparation before navigation
//assemble the url and pass it to the next controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://ohterrariums.com/dance/assets/www/healing.html"];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"SavedPreferencesSegue"]) {
        MoodViewController *destViewController = segue.destinationViewController;
        destViewController.preferences = preferences;
        destViewController.theTitle = @"Apple";
        destViewController.theURL = url;
    }
}
@end

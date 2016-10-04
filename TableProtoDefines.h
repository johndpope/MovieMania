//
//  TableProtoDefines.h
//  tableProto
//
//  Created by Myra Hambleton on 2/25/16.
//  Copyright © 2016 Hammond Development International. All rights reserved.
//

#ifndef TableProtoDefines_h
#define TableProtoDefines_h

//////////////////////////////////////////////////////
//    T K     C E L L     D E F A U L T S
//below used by all toolkit cell types as default.
//So, when nil is passed to an initializer, this is what they use for default foreground text color
//and default background color
#define TK_TEXT_COLOR    [UIColor whiteColor]   //use like [UIColor colorWithRed:0.1f green:0.004f blue:0.3f alpha:0.3f]
#define TK_TRANSPARENT_COLOR [UIColor clearColor]
#define TK_TEXTCELL_SEPARATOR_COLOR [UIColor whiteColor]


#define TK_VIEW_BackColor  [UIColor colorWithRed:(32/255.0) green:(32/255.0) blue:(32/255.0) alpha:1] ;  // very dark gray
#define TK_CELL_BackColor  [UIColor colorWithRed:(47/255.0) green:(47/255.0) blue:(47/255.0) alpha:1] ;  // dark gray
#define TK_HEADER_BackColor  [UIColor colorWithRed:(204/255.0) green:(0/255.0) blue:(0/255.0) alpha:1] ; // reddish
#define TK_FOCUSBORDER_COLOR [UIColor orangeColor]
#define TK_FOCUSBORDER_SIZE 3
//#define globalColor [UIColor colorWithRed:0.1f green:0.004f blue:0.3f alpha:0.3f]   //example

#define TK_IOS_ButtonWidth 60
#define TK_IOS_ButtonHeight 30
#define TK_IOS_PictureWidth 100 //80
#define TK_IOS_PictureHeight 150  //120
#define TK_IOS_VideoWidth 80
#define TK_IOS_VideoHeight 60
#define TK_IOS_TextFontBig 20
#define TK_IOS_TextFontMiddle 16
#define TK_IOS_TextFontSmall 12

#define TK_TVOS_ButtonWidth 120
#define TK_TVOS_ButtonHeight 60
#define TK_TVOS_PictureWidth 200
#define TK_TVOS_PictureHeight 300
#define TK_TVOS_VideoWidth 160
#define TK_TVOS_VideoHeight 120

#define TK_TVOS_TextFontBig 40
#define TK_TVOS_TextFontMiddle 32
#define TK_TVOS_TextFontSmall 24


///////////////////////////////////////////////////////
#define  DISK_STORAGE_ENABLED YES               // if this is NO, none of the archive and unarchive methods work
#define  DISK_DOCSTORE @"STORE"                 //storage files located at .../Documents/<DISK_DOCSTORE>
#define  DISK_DOCDEBUG  @"DEBUG"                //debug files located at .../Documents/<DISK_DOCDEBUG>
#define  DISK_IMAGESTORE @"storeIMG.dat"        //movieImageDictionary archive to disk
#define  DISK_TRAILERSTORE @"storeTRAIL.dat"    //allMovieTrailersHDI archive to disk
#define  DISK_EFSTORE @"storeEF.dat" //entry fields storage, specifically current zip code


#define  HUD_SHOW_HOSTINFO  YES               //when NO HUD shows static "aQuery active...." ;YES shows aQuery.errorDisplayText

#define EFKEY_ZIPCODE @"movieZipcode"
#define DEFAULT_ZIPCODE @"75248"


#define  DEF_TITLEWIDTH 40
#define  DEF_TITLEHEIGHT 100
#define  DEF_TITLEFONTSIZE 16

#define  DEF_TABLEHDR_WIDTH 40
#define  DEF_TABLEHDR_HEIGHT 100


#define kAUTOMATIC 1
#define kUSERBUTTON 2
#define kHOSTERROR 3

#define  DEF_SECTIONFONTSIZE 14

#define  DEF_CELLFONTSIZE 12
#define  DEF_CELLHEIGHT 100

#define TAG_ID 0
#define TAG_PW 1
#define TAG_VERIFY 2

#define CELLCLASS_UNKNOWN 0
#define CELLCLASS_TEXT 1
#define CELLCLASS_IMAGE_ONLY 2
#define CELLCLASS_BUTTONS_SCROLL 3
#define CELLCLASS_UIVIEW 4
#define CELLCLASS_STACKVIEW 5
#define CELLCLASS_IMAGELEFT_TEXTRIGHT 6
#define CELLCLASS_INPUTFIELD 7


#define FIXED_HEADER_Y_OFFSET 25
//#define TranCodeTrailerForMovie @"GetTrailersForMovie" //OLD
#define TranCodeTrailerForMovie @"GetAllVideoAssetsAndTrailersForMovie"
#define TranCodeLocForZip @"LocationsForZipCode"
#define TranCodeMoviesForZip @"MoviesPlayingForZipCode"
#define TranCodeAllInv @"AllInventory"
#define TranCodeAllLocs @"AllLocations"
#define TranCodeDeleteAll @"DeleteAll"
#define TranCodeDeleteRecord @"DeleteRecord"
#define TranCodeAddRecord @"AddRecord"
#define TranCodeQueryProduct @"QueryProduct"
#define TranCodeQueryLocation @"QueryLocation"
#define QueryLocationName @"LocationName"
#define QueryProductName @"ProductName"
#define QueryLocationID @"LocationIDQuery"
#define QueryProductID @"ProductIDQuery"
#define QueryMovieYouTubeTrailers @"MovieTrailerQuery"
#define TranCodeKey @"TranCode"
#define ZipCodeKey @"ZipCode"
//#define TVCScrollButtonPress 99994


#define TVCChangeZip 99993
#define TVCERROR 99994
#define TVCInitMovieInfoDict 99995
#define TVCInitProducts 99996
#define TVCInitLocations 99997
#define TVCInitDBs   99998   // stuff sql database with locations and movies
#define TVCStartUp  99999      // get log on TVC data
#define TVC0 0          // log on TVC
#define TVC1 1          // Theaters TVC
#define TVC2 2          // All Movies Btn TVC
#define TVC3 3          // All Movies Table TVC
#define TVC4 4          // Theater Movies Showing TVC
#define TVC5 5          // Movie Detail TVC
#define TVC6 6          // purchase TVC
#define TVC7 7          // Build Purchase Order
#define TVC8 8          // Process purchess
#define TVC9 9          // Change Date For Search
#define TVC10 10        // All Theaters showing a movie

#define kDISP_ALIGN_VERTICAL 0      //CellUIView, for CellTextDef
#define kDISP_ALIGN_HORIZONTAL 1    //CellUIView, for CellTextDef

#define kDISP_TEMPLATE_IMAGELEFT_LABLESRIGHT 0
#define kDISP_TEMPLATE_IMAGERIGHT_LABELSLEFT 1
#define kDISP_TEMPLATE_IMAGETOP_LABELSBOTTOM 2
#define kDISP_TEMPLATE_IMAGEBOTTOM_LABELSTOP 3

#define kDISP_TEMPLATE_BUTTONSLEFT_LABLESRIGHT 4
#define kDISP_TEMPLATE_BUTTONSLEFT_IMAGERIGHT 5
#define kDISP_TEMPLATE_BUTTONSRIGHT_LABLESLEFT 6
#define kDISP_TEMPLATE_BUTTONSRIGHT_IMAGELEFT 7
#define kDISP_TEMPLATE_BUTTONSTOP_LABLESBOTTOM 8
#define kDISP_TEMPLATE_BUTTONSTOP_IMAGEBOTTOM 9
#define kDISP_TEMPLATE_BUTTONSBOTTOM_LABLESTOP 10
#define kDISP_TEMPLATE_BUTTONSBOTTOM_IMAGETOP 11
#define kDISP_TEMPLATE_LABELS_ONLY 12
#define kDISP_TEMPLATE_TRIPLE_IMAGELEFT_BUTTONSBOTTOM_LABELTOP 13
#define kDISP_TEMPLATE_TRIPLE_IMAGELEFT_BUTTONSTOP_LABELBOTTOM 14
#define kDISP_TEMPLATE_INPUTFIELDS_ONLY 15


#define BUTTONS_FILLER_NAME @"FILLER_BUTTON"


// Locations
#define BUTTONS_SEC_HEADER 5
#define BUTTONS_SEC_FOOTER 4
#define BUTTONS_TITLE_FOOTER 3
#define BUTTONS_TITLE_HEADER 2
#define BUTTONS_NORMAL_CELL 1


#define M_PI   3.14159265358979323846264338327950288   /* pi */
#define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI)
#define kCellRowModulus 100;
#define kCellSectionModulus 10000
#define kLocationModulus 1000000
#define kNumberOfDaysInHeader 5


#define kDictionaryTypeProduct @"ProductDictonary"
#define kDictionaryTypeLocation @"LocationDictionary"
#define kDictionaryTypeMovieInfo @"MovieInfoDictionary"

#define kProductNameKey @"title"    //TMS
#define kProductIDKey @"rootId"     //TMS
#define kProductDescriptionKey  @"ProductDescription"
#define kProductDescriptionShortKey @"shortDescription" //TMS
#define kProductDescriptionLongKey @"longDescription"  //TMS
#define kProductImageKey  @"ProductImage"
#define kProductInventoryKey @"showtimes" //TMS
#define kProductQualsKey @"quals"
#define kTicketURIKey @"ticketURI"   //TMS
#define kProductVideoArray @"ProductVideoArray"
#define kProductReleaseDateKey @"ProductDescription.Released"
#define kProductRatingKey @"ProductDescription.Rated"
#define kProductGenreKey @"ProductDescription.Genre"
#define kProductRuntimeKey @"ProductDescription.Runtime"

#define kProductShowingTheatreIDKey @"theatre.id" //TMS
#define kProductShowingDateTimeKey @"dateTime"    //TMS

// for data stuffer only
#define kProductImplodedTimesKey @"ProductTimes"
//#define kProductInfoDictKey  @"ProductInfoDictionary"
#define kProductTimesArrayKey  @"ProductTimesArray"
//#define kProductLocationsArrayKey @"ProductLocationsArray"

//#define kNSDateShowTimeKey @"ShowTime"

#define kProductQualsArrayKey @"QualsArray"
#define kProductQualsDictKey @"QualsDictionary"
#define kProduct3DKey @"RealD 3D"
#define kProductClosedCaptioned @"Closed Captioned"
#define kProductDigitalCinema @"Digital Cinema"

#define kTrailerBtnName @"Trailer"

//#define KProductPurchasesKey @"Purchases"


//HDI DECRYPT_REQ  required
//HDI DECRYPT_OPT  optional
//HDI DECRYPT_P    process specific
#define kDECRYPT_REQ_REVKEY @"HDI_REQ Revision"   //required - string version number
#define kDECRYPT_REQ_UNIQUEKEY @"HDI_REQ UniqueKey"   //required - array of key strings
#define kDECRYP_REQ_FUNCTION_NAME @"HDI_REQ FName"   //required = phpFunctionName.phpFileName.php
#define kDECRYPT_OPT_PROCESS @"HDI_OPT Process" //OPTIONAL ARRAY process identifiers with required associated Dictionaries...

//---MERGE PREPROCESS ---REQUIRED FOR MERGE this is dictionary
#define kDECRYPT_P_MERGEPROCESS @"HDI_PROCESS MERGE"   //preprocessing   not this could be done on PHP side
#define kDECRYPT_P_MERGEONKEY @"MERGE Key" //string - key that will be unique after merge happens EXACT KEY SEEN IN JSON DUMP (preprocessing)
#define kDECRYPT_P_MERGEFIELDS @"MERGE Fields" //array of key strings defining what is merged
//--------------
#define kDECRYPT_P_REMOVE_RECORD_STRINGBEGINS @"HDI_PROCESS REMOVERECORDstringBegins"
#define kDECRYPT_P_REPLACE_FIELD_STRINGTRAILS @"HDI_PROCESS REPLACEFIELDstringTrails"
#define kDECRYPT_P_FLATTEN_ARRAY_TOSTRING @"HDI_PROCESS FLATTENARRAY_TOSTRING"


#define kVideoPath      @"trailerPath"
#define kVideoImagePath @"trailerImagePath"
#define kVideoImage     @"trailerImage"

#define kVideoUrl       @"Url"
#define kVideoBitrateID @"BitrateId"
#define kVideoClipID    @"EClipId"



//HDI LOCATION DICT
#define kLocationCountry @"LocationCountry"
#define kLocationIDKey @"LocationID"
#define kLocationNameKey @"LocationName"
#define kLocationAddressKey @"LocationStreetAddress"
#define kLocationCityKey @"LocationCity"
#define kLocationStateKey @"LocationState"
#define kLocationZipKey @"LocationZip"
#define kLocationProducts @"LocationProduct"
#define kLocationDate @"LocationDate"

//HDI MOVIEINFO DICT
#define kMovieUniqueKey @"UniqueKey"
#define kMovieTitle @"Title"
#define kMovieID @"MovieID"
#define kMovieReleased @"Released"
#define kMovieYear @"MovieYear"
#define kNoMovieYear @"NoMovieYearThisCannotBeNil"
#define kMovieRated @"Rated"
#define kMovieRuntime @"Runtime"
#define kMovieGenre @"Genre"
#define kMovieDirector @"Director"
#define kMovieWriter @"Writer"
#define kMovieActors @"Actors"
#define kMoviePlot @"Plot"
#define kMovieImage @"Image" 
#define kMovieShowTimes @"ShowTimes"
#define kMovieShortDescr @"ShortDescription"

#define kMovieTicketBuyPath @"TicketBuyPath"
#define kMovieShowDateTime @"ShowDateTime"
#define kMovieAdvisories @"Advisories"
#define kMovieTheaterName @"TheaterName"
#define kMovieTheaterID @"TheaterID"
#define kShowBarg @"ShowBarg"
#define kShowQuals @"ShowQuals"

//#define kPurchaseKey @"PurchaseName"
//#define kPurchaseLocationKey @"PurchaseLocation"
#define kPurchaseTypeKey @"PurchaseType"
#define kPurchasePriceKey @"PurchasePrice"
#define kPurchaseQuantityKey @"PurchaseQuantity"
#define kPurchaseDictionaryArrayKey @"PurchaseArray"

// Button Type Assignments
#define kButtonTypeDate 1
#define kButtonTypeLocation 2
#define kButtonTypeProduct 3
#define kButtonTypeShowTime 4
#define kButtonTypeTrailer 5

#endif /* TableProtoDefines_h */



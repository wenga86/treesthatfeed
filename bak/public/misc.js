//Routine to randomize display of home page banner image
//The JavaScript Source!! http://javascript.internet.com 
//======================================================

//Set up the image files to be used.
var theImages = new Array() // do not change this

//To add more image files, continue with the
//pattern below, adding to the array.
theImages[0] = 'images/bg1.jpg'
theImages[1] = 'images/bg3.jpg'
theImages[2] = 'images/bg4.jpg'
theImages[3] = 'images/bg5.jpg'
theImages[4] = 'images/bg7.jpg'
theImages[5] = 'images/bg8.jpg'
theImages[6] = 'images/bg9.jpg'
theImages[7] = 'images/bg10.jpg'
theImages[8] = 'images/bg12.jpg'
theImages[9] = 'images/bg13.jpg'
theImages[10] = 'images/bg14.jpg'
theImages[11] = 'images/bg15.jpg'
theImages[12] = 'images/bg16.jpg'
theImages[13] = 'images/bg17.jpg'
theImages[14] = 'images/bg18.jpg'
theImages[15] = 'images/bg19.jpg'
theImages[16] = 'images/bg20.jpg'
theImages[17] = 'images/bg21.jpg'
theImages[18] = 'images/bg22.jpg'
theImages[19] = 'images/bg23.jpg'
theImages[20] = 'images/bg24.jpg'
theImages[21] = 'images/bg25.jpg'
theImages[22] = 'images/bg26.jpg'
theImages[23] = 'images/bg27.jpg'
theImages[24] = 'images/bg28.jpg'
theImages[25] = 'images/bg29.jpg'
theImages[26] = 'images/bg30.jpg'

//do not edit anything below this line
var cookiename = 'lastbanner';
var sLastIndex = '';
var iLastIndex = -1;

var j = 0
var p = theImages.length;
var preBuffer = new Array()
for (i = 0; i < p; i++){
    preBuffer[i] = new Image()
    preBuffer[i].src = theImages[i]
}
//Get index setting for last banner displayed, if any
sLastIndex = Get_Cookie(cookiename);
if (sLastIndex) {
    iLastIndex = parseInt(sLastIndex);
}
//Get random index of banner to display now; if same as last index, retry until different;
var whichImage = Math.round(Math.random() * (p - 1));
if (iLastIndex > -1) {
    while (whichImage == iLastIndex) {
        whichImage = Math.round(Math.random() * (p - 1));
    }
}
//Write image tag based on computed image index;
function showImage(){
    document.write('<img src="' + theImages[whichImage] + '" width="775" height="108" alt="Trees That Feed Foundation">');
    Set_Cookie(cookiename, whichImage, '', '/', '', ''); //save index of banner displayed
}

//Routine to validate Contact Us form and submit if ok
//=====================================================
function checkContactUs() {
    var fm = document.forms["ContactUs"];
    var fName = fm.FirstName;
    var lName = fm.LastName;
    var eMail = fm.eMail;
    var phone = fm.Phone;
    var sMsg = "";
    
    //Validate first name
    if (fName.value == "") {
        sMsg = "Please enter your first name.";
        alert(sMsg);
        fName.focus();
        return false;
    }

    //Validate last name
    if (lName.value == "") {
        sMsg = "Please enter your last name.";
        alert(sMsg);
        lName.focus();
        return false;
    }

    //Validate that either e-mail or phone entered
    if (eMail.value == "" && phone.value == "") {
        sMsg = "Please enter either an e-mail address or phone number so we can contact you. ";
        alert(sMsg);
        eMail.focus();
        return false;
    }

    //Validate that at least one checkbox is checked.
    var noChk = true;  //assume no box checked
    for (var i = 1; i < 7; i++) {
        var cbox = document.getElementById("Checkbox" + i);
        if (cbox && cbox.checked) {
            noChk = false;
            break;
        }
    }
    if (noChk) {
        sMsg = "Please check at least one box so we can properly direct your inquiry.";
        alert(sMsg);
        fm.Checkbox1.focus();
        return false;
    }

    //Validate Comments non-null for checkbox 1 and 2
    if ((fm.Checkbox1.checked || fm.Checkbox2.checked) && fm.comments.value == "") {
        sMsg = "Please enter comments based on your checkbox selection.";
        alert(sMsg);
        fm.comments.focus();
        return false;
    }
    //Submit if we got this far
    fm.submit();
}

/***************************************************************************
Script Name: Javascript Cookie Script
Author: Public Domain, with some modifications
Script Source URI: http://techpatterns.com/downloads/javascript_cookies.php
Version 1.1.1
Last Update: 4 October 2007

Changes:
1.1.1 fixes a problem with Get_Cookie that did not correctly handle case
where cookie is initialized but it has no "=" and thus no value, the 
Get_Cookie function generates a NULL exception. This was pointed out by olivier, thanks

1.1.0 fixes a problem with Get_Cookie that did not correctly handle
cases where multiple cookies might test as the same, like: site1, site

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
*****************************************************************************/

// this fixes an issue with the old method, ambiguous values 
// with this test document.cookie.indexOf( name + "=" );

// To use, simple do: Get_Cookie('cookie_name'); 
// replace cookie_name with the real cookie name, '' are required
function Get_Cookie(check_name) {
    // first we'll split this cookie up into name/value pairs
    // note: document.cookie only returns name=value, not the other components
    var a_all_cookies = document.cookie.split(';');
    var a_temp_cookie = '';
    var cookie_name = '';
    var cookie_value = '';
    var b_cookie_found = false; // set boolean t/f default f

    for (i = 0; i < a_all_cookies.length; i++) {
        // now we'll split apart each name=value pair
        a_temp_cookie = a_all_cookies[i].split('=');


        // and trim left/right whitespace while we're at it
        cookie_name = a_temp_cookie[0].replace(/^\s+|\s+$/g, '');

        // if the extracted name matches passed check_name
        if (cookie_name == check_name) {
            b_cookie_found = true;
            // we need to handle case where cookie has no value but exists (no = sign, that is):
            if (a_temp_cookie.length > 1) {
                cookie_value = unescape(a_temp_cookie[1].replace(/^\s+|\s+$/g, ''));
            }
            // note that in cases where cookie is initialized but no value, null is returned
            return cookie_value;
            break;
        }
        a_temp_cookie = null;
        cookie_name = '';
    }
    if (!b_cookie_found) {
        return null;
    }
}

/*
only the first 2 parameters are required, the cookie name, the cookie
value. Cookie time is in milliseconds, so the below expires will make the 
number you pass in the Set_Cookie function call the number of days the cookie
lasts, if you want it to be hours or minutes, just get rid of 24 and 60.

Generally you don't need to worry about domain, path or secure for most applications
so unless you need that, leave those parameters blank in the function call.
*/
function Set_Cookie(name, value, expires, path, domain, secure) {
    // set time, it's in milliseconds
    var today = new Date();
    today.setTime(today.getTime());
    // if the expires variable is set, make the correct expires time, the
    // current script below will set it for x number of days, to make it
    // for hours, delete * 24, for minutes, delete * 60 * 24
    if (expires) {
        expires = expires * 1000 * 60 * 60 * 24;
    }
    //alert( 'today ' + today.toGMTString() );// this is for testing purpose only
    var expires_date = new Date(today.getTime() + (expires));
    //alert('expires ' + expires_date.toGMTString());// this is for testing purposes only

    document.cookie = name + "=" + escape(value) +
		((expires) ? ";expires=" + expires_date.toGMTString() : "") + //expires.toGMTString()
		((path) ? ";path=" + path : "") +
		((domain) ? ";domain=" + domain : "") +
		((secure) ? ";secure" : "");
}

// this deletes the cookie when called
function Delete_Cookie(name, path, domain) {
    if (Get_Cookie(name)) document.cookie = name + "=" +
			((path) ? ";path=" + path : "") +
			((domain) ? ";domain=" + domain : "") +
			";expires=Thu, 01-Jan-1970 00:00:01 GMT";
}
//  ============================================================
//  COMPUNAUT FLEET CONTROLLER BACKGROUND PARALLAX SCROLL SCRIPT
//  
//  ©2019 Calyo Delphi (dragon-architect)
//  ============================================================

//  This only works if the user has scripts enabled
//  It changes the background-attachment property of the background-image from scroll to fixed
//  Otherwise, the background-image scrolls with the document
//  Graceful degradation ftw \o/
document.documentElement.style.backgroundAttachment = "fixed";

var debug = false;

//  Declare some initial variables in the outermost scope to avoid scoping issues
//  Their values will be set in a function below
var aspectRatio, mainTopMargin, scrollHeight, overflowHeight, scrollPercent;
//  Placeholder variable
var mainElt = document.getElementsByTagName('main')[0];

//  Call the alluded function to set the values of the variables declared above
document.body.onload = recomputeVars;

//  Just debug output to the console
if(debug)
{
    console.group();
        console.log("Aspect Ratio: " + aspectRatio);
        console.log("Body Scroll Height: " + document.body.scrollHeight);
        console.log("Main Scroll Height: " + document.getElementsByTagName('main')[0].scrollHeight);
        console.log("Main Top Margin: " + window.getComputedStyle(document.getElementsByTagName('main')[0]).marginTop);
        console.log("Inner Height: " + window.innerHeight);
        console.log("Overflow Height: " + overflowHeight);
    console.groupEnd();
}

//  Stuff that needs to be recalculated whenever the viewport resizes
document.body.onresize = recomputeVars;

//  Whenever the document scrolls, call scrollBG()
document.body.onscroll = scrollBG;

//  This function sets the values of the variables declared above
function recomputeVars()
{
    //  Find the new aspect ratio of hte viewport
    aspectRatio = screen.width / screen.height;
    //  Another placeholder variable
    mainTopMargin = window.getComputedStyle(mainElt).marginTop;
    //  FINALLY we compute the scrollHeight
    //  mainTopMargin is stored as a string with "px" on the end, so that needs to be removed and the string converted to a number to prevent unpredictable type juggling
    scrollHeight = mainElt.scrollHeight + Number(mainTopMargin.replace("px",''));
    //  Find the new overflow height of the content
    overflowHeight = scrollHeight - window.innerHeight;
    //  Call scrollBG to properly reposition the background as the viewport resizes
    scrollBG();
}

function scrollBG()
{
    //  If the aspect ratio is greater than 3/2 (1.5), do all this; otherwise, pass just to save compute cycles
    if(aspectRatio > 1.5)
    {
        //  Recompute the scroll percentage
        //  Round to the nearest integer just to keep things clean
        scrollPercent = Math.round(window.scrollY / overflowHeight * 1000) / 10;
        //  Apply the new scroll percentage to the background-position
        document.documentElement.style.backgroundPosition = "50% " + scrollPercent + "%";
        // Debug output
        if(debug) { console.log(window.scrollY + "\t" + scrollPercent); }
    }
}

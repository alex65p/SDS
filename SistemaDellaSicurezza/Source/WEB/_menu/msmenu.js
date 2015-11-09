/**   ======================================================================== */
/**                                                                            */
/** @copyright Copyright (c) 2010-2015, S2S s.r.l. */
/** @license   http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2 */
/** @version   6.0  */
/** This file is part of SdS - Sistema della Sicurezza  . */
/** SdS - Sistema della Sicurezza   is free software: you can redistribute it and/or modify */
/** it under the terms of the GNU General Public License as published by  */
/** the Free Software Foundation, either version 3 of the License, or  */
/** (at your option) any later version.  */

/** SdS - Sistema della Sicurezza  is distributed in the hope that it will be useful, */
/** but WITHOUT ANY WARRANTY; without even the implied warranty of */
/** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the */
/** GNU General Public License for more details. */

/** You should have received a copy of the GNU General Public License */
/** along with SdS - Sistema della Sicurezza .  If not, see <http://www.gnu.org/licenses/gpl-2.0.html>  GNU Public License v.2 */
/**                                                                            */
/**   ======================================================================== */

var menus = new Array();
function MenuRegister(item)
{
    menus[menus.length] = item;
    return (menus.length - 1);
}

//*****************************************************************************
// Function:   MenuItem
// Arguments:  isDisabled-- (true|false) display this menu item disabled
//			   caption   -- a string to be used for the menu item caption
//             command   -- a url string or a function reference
//             image     -- a url to a 16x16 image.  Pass in null for no image
//             submenu   -- a reference to a Menu object.  It will display the 
//                       -- arrow to the right of the caption and display the
//                       -- submenu. Pass in null for no submenu
//             separator -- (true|false) display this menu item as a line
//			   	
// Purpose:    For each menu item in a menu, there is one MenuItem object to
//             describe it.
//*****************************************************************************

function MenuItem(isDisabled, caption, command, image, submenu, separator)
{
    this.caption = caption;
    this.command = command;
    this.image = image;
    this.submenu = submenu;
    this.separator = (separator) ? true : false;
    this.id = MenuRegister(this);
    this.disabled = (isDisabled) ? true : false;
}

//*****************************************************************************
// Function:   MenuItemOnClick()
// Arguments:  obj  -- This is always a reference to the table row for the menu
//                     item.
// Purpose:    When the user clicks on a menu item, the table row will call 
//             this function.  If the MenuItem.command is a function, it gets
//             run, and if it is a string (url), the window.location gets set
//             to it.
//*****************************************************************************

function MenuItemOnClick(obj, event) {
    var item = menus[obj.getAttribute("menuid")];
    if (item.disabled)
        return;
    var menub1 = document.all["MENU" + item.parent + "B1"];
    event.cancelBubble = true;
    if (item == null)
        return;
    if ((typeof item.command) == "function")
        item.command();
    if ((typeof item.command) == "string")
        g_LoadView(item.command);///////////////////////// ZORRRROOOOOOOOOOOOOOOOOOOO
    //window.parent.location=item.command;
}
//*****************************************************************************
// Function:   MenuItemOnMouseOver()
// Arguments:  obj  -- This is always a reference to the table row for the menu
//                     item.
// Purpose:    This is the onMouseOver event for the menu table rows.  It will
//             highligh the row and display the submenu if there is one.
//*****************************************************************************

function MenuItemOnMouseOver(obj, event) {
    var item = menus[obj.getAttribute("menuid")];
    var parent = menus[item.parent];
    var menub1 = document.all['MENU' + item.parent + 'B1'];
    var fromElement = event.fromElement;
    var toElement = event.toElement;

    event.cancelBubble = true;

    // If just moving around within the row, then return
    // This improves performance and avoids a flicker
    if ((fromElement != null) && (toElement != null))
    {
        if (fromElement.getAttribute("menuid") == toElement.getAttribute("menuid"))
            return;
    }

    /*obj.style.backgroundColor ="#000084";  // Change background to dark blue
     obj.style.color = "white";              // Change text to white*/
    obj.className = "menuRowSel";


    // If a submenu is open that is not for this menu item, close it
    if ((parent.submenu != null) && (parent.submenu != item.submenu))
    {
        parent.submenu.hide();
        parent.submenu = null;
    }

    // If this item has a submenu, open it
    if ((item.submenu != null) && (parent.submenu != item.submenu))
    {
        item.submenu.top = menub1.offsetTop + obj.offsetTop;
        item.submenu.left = menub1.offsetLeft + obj.offsetWidth;
        item.submenu.show();
        parent.submenu = item.submenu;
        return;
    }

}

//*****************************************************************************
// Function:   MenuItemOnMouseOut()
// Arguments:  obj  -- This is always a reference to the table row for the menu
//                     item.
// Purpose:    This is the onMouseOut event for the menu table rows.  It will
//             return the row to a non-highlighted state and will close the
//             close the submenu unless the mouse was moved over to the submenu
//*****************************************************************************

function MenuItemOnMouseOut(obj, event) {

    var item = menus[obj.getAttribute("menuid")];
    var parent = menus[item.parent];
    var toElement = event.toElement;

    event.cancelBubble = true;

    if ((toElement != null) && (toElement.getAttribute("menuid") == parent.id)) {
        if ((parent.submenu != null) && (parent.submenu != item))
        {
            parent.submenu.hide();
            parent.submenu = null;
        }
    }

    if ((event.fromElement != null) && (event.toElement != null))
    {
        if (event.fromElement.getAttribute("menuid") == event.toElement.getAttribute("menuid"))
            return;

    }

    /*obj.style.backgroundColor = "transparent";
     obj.style.color ="black";*/
    obj.className = "menuRow";
}

//*****************************************************************************
// Function:   MenuItemToString()
// Arguments:  none
// Purpose:    This is used by the Menu object when creating each row of the 
//             menu table.
//*****************************************************************************

function MenuItemToString()
{
    if (this.separator)
        return '<tr style="height:1px"><td colspan=3 style="height:1px"><hr style="height:1px"></td></tr>\n';

    return '<tr class="menuRow" onMouseOver="MenuItemOnMouseOver(this, event)" ' + ((this.disabled) ? 'disabled' : '') + ' onMouseOut="MenuItemOnMouseOut(this, event)" onClick="MenuItemOnClick(this, event)" menuid="' + this.id + '"><td class=menuImageCell noWrap=noWrap menuid="' + this.id + '">' + ((this.image != null) ? '&nbsp;&nbsp;<img class=menuImage menuid="' + this.id + '" src="' + this.image + '">&nbsp;&nbsp;' : '&nbsp;&nbsp;') + '</td><td class=menuCaptionCell noWrap=noWrap menuid="' + this.id + '">' + this.caption + '</td><td class=menuArrowCell noWrap=noWrap menuid="' + this.id + '" ' + ((this.submenu != null) ? 'style="font-family:Arial Unicode MS">&#8883;' : 'style="font-family:times">&nbsp;&nbsp;&nbsp;') + '</td></tr>\n';
}

MenuItem.prototype.toString = MenuItemToString;

//*****************************************************************************
// Function:   Menu
// Arguments:  top   -- The top coordinate for the menu
//             left  -- The left coordinate for the menu
// Purpose:    This is used to create a menu
//*****************************************************************************

function Menu(top, left)
{
    this.items = new Array();
    this.top = top;
    this.left = left;
    this.id = MenuRegister(this);
    this.update = true;

    MENUINSERT.insertAdjacentHTML("BeforeEnd", this.borders());
}

//*****************************************************************************
// Function:   MenuAddItem
// Arguments:  item -- a menu item to add to the end of the menu.
// Purpose:    Used to add a new menu item to the end of the menu.
//*****************************************************************************

function MenuAddItem(item)
{
    this.items[this.items.length] = item;
    item.parent = this.id;
}

//*****************************************************************************
// Function:   MenuShow
// Arguments:  noDisplay  -- use true when the menu is created to initialize
//                        -- the menu
// Purpose:    Menu.show() is called from code to show the menu when needed and
//             Menu.show(true) should be called to initialize the menu.
//*****************************************************************************

function MenuShow(noDisplay)
{
    var menub1 = document.all["MENU" + this.id + "B1"];
    var menub2 = document.all["MENU" + this.id + "B2"];

    if (this.update)
    {
        menub2.innerHTML = this.getTable();
        this.update = false;
    }

    var menu = document.all["MENU" + this.id];

    menub1.style.top = this.top;
    menub1.style.left = this.left;

    //menub2.style.width = menu.offsetWidth + 2;
    //menub2.style.height = menu.offsetHeight + 2;

    menub1.style.width = menu.offsetWidth + 4;
    menub1.style.height = menu.offsetHeight + 12;

    //menub1.style.display="none"

    // BUG: some offset factors are used here to compensate for scroll bars and 
    //      differences between large and small fonts

    // If the menu goes past the bottom of the body, move it up
    if ((menub1.offsetTop + menub1.offsetHeight) > (MenuBodyRef.offsetHeight - 4))
        menub1.style.top = MenuBodyRef.offsetHeight - menub1.offsetHeight - 4;

    // If the menu goes past the right of the body, move it left
    if ((menub1.offsetLeft + menub1.offsetWidth) > (MenuBodyRef.offsetWidth - 24))
        menub1.style.left = MenuBodyRef.offsetWidth - menub1.offsetWidth - 24;

    // If the menu is too far up, make the top at 0
    if (menub1.offsetTop < 0)
        menub1.style.top = 0;

    // If the menu is too far left, make the left at 0
    if (menub1.offsetLeft < 0)
        menub1.style.left = 0;

    // BUG: Removing this causes the highlight to be broken up between cells
    MENUINSERT.insertAdjacentHTML("BeforeEnd", "");

    if (noDisplay)
    {
        menub1.style.top = -1000;
        menub1.style.left = -1000;
    } else {
        menub1.style.visibility = "visible";
    }
}

//*****************************************************************************
// Function:   MenuHide
// Arguments:  none
// Purpose:    Menu.hide() is called from code to make the menu disappear.
//*****************************************************************************

function MenuHide()
{
    var menub1 = document.all["MENU" + this.id + "B1"];
    if (this.submenu != null)
        this.submenu.hide()

    // BUG: the use of style.display='none' causes the menu to turn into a 
    //      little 5x20px gray block that never again displays correctly 

    menub1.style.visibility = "hidden";
    menub1.style.top = -1000;
    menub1.style.left = -1000;
}

//*****************************************************************************
// Function:   MenuBorders()
// Arguments:  none
// Purpose:    The borders create the 3D effect and serve as a container for
//             the menu table.
//*****************************************************************************

function MenuBorders() {
    return  '<div id="MENU' + this.id + 'B1" style="position: absolute" class="menuBorder1" menuid="' + this.id + '" onClick="event.cancelBubble=true">\n' + '<div id="MENU' + this.id + 'B2" class="menuBorder2" menuid="' + this.id + '">\n</div>\n</div>\n';
}

//*****************************************************************************
// Function:   MenuTable()
// Arguments:  none
// Purpose:    This creates the HTML table used to represent the menu.
//*****************************************************************************

function MenuTable()
{
    var str;

    str = "<table id=MENU" + this.id + "\n" +
            "       cellpadding=0 cellspacing=0 border=0 class=menuTable>\n";

    for (var i = 0; i < this.items.length; i++)
        str += this.items[i];

    str += "</table>\n";

    return str;
}

Menu.prototype.addItem = MenuAddItem;
Menu.prototype.borders = MenuBorders;
Menu.prototype.getTable = MenuTable;
Menu.prototype.show = MenuShow;
Menu.prototype.hide = MenuHide;

//*****************************************************************************
// Function:   MenuInit()
// Arguments:  none
// Purpose:    This creates the object used to insert the HTML menu objects 
//             into at runtime.  It should be called only once, probably during
//             The window's onLoad event and it must be called before Menu()
//             objects are created.
//*****************************************************************************

var MenuBodyRef;
function MenuInit() {
    var allChild = document.getElementsByTagName("BODY");
    
    for (var i=0; i<allChild.length; i++) {
        if (allChild[i].tagName == "BODY")
        {
            MenuBodyRef = allChild[i];
            MenuBodyRef.insertAdjacentHTML("BeforeEnd", "<div id=MENUINSERT></div>");
            break;
        }
    }
}

var dispfr = false;
function DocOnClick(event) {
    MenuBarClose();
    show();//##
    checkm(event);
}

function getEventElement(event){
    // for Internet explorer
    if (event.srcElement) return event.srcElement;
    else
    // for all browser
    if (event.target) return event.target;
}

function MenuBarOnClick(event) {
    if (dispfr == false) {
        var obj = getEventElement(event);
        var menu;
        event.cancelBubble = true;
        hide();//##
        if (obj.parentElement.className == 'MenuBarItem') {
            if (current != null)
                MenuBarClose()

            /*obj.style.color = 'white'
             obj.style.backgroundColor = '#000084'*/
            // obj.className = 'MenuBarItemSel'
            obj.parentElement.className = 'MenuBarItemSel'

            menu = MenuBarMenus[obj.getAttribute("menu")]
            menu.left = obj.parentElement.offsetLeft + 2;
            menu.top = obj.parentElement.offsetTop + obj.offsetHeight -1;
            menu.show();

            current = obj;
        }
    }
}

function MenuBarClose() {
    if (current != null) {
        var menu = MenuBarMenus[current.getAttribute("menu")]
        menu.hide()
        menu = null
        /*current.style.backgroundColor = 'transparent'
         current.style.color = 'black'*/
        current.parentElement.className = 'MenuBarItem'
    }
}

function PupUpCmd() {
    if (helpbutton.value == 'Show Search') {
        popup.left = helpbutton.offsetLeft + helpbutton.offsetWidth
        popup.top = helpbutton.offsetTop
        popup.show()
        helpbutton.value = 'Hide Search'
    } else {
        popup.hide()
        helpbutton.value = 'Show Search'
    }
}

function hide() {
    for (var i = 0; i < document.applets.length; i++)
        document.applets[i].style.visibility = "hidden";
    
    var allChild = document.getElementsByTagName("SELECT"); 
    for (var i = 0; i < allChild.length; i++)
    {
        allChild[i].style.visibility = "hidden";
    }
    
    if (document.all["upTbl"]) {
        document.all["upTbl"].style.visibility = "hidden";
    }
    if (originalRowHeader) {
        originalRowHeader.style.visibility = "visible";
    }
}

function show() {
    for (var i = 0; i < document.applets.length; i++)
        document.applets[i].style.visibility = "";
    
    var allChild = document.getElementsByTagName("SELECT"); 
    for (var i = 0; i < allChild.length; i++)
    {
        allChild[i].style.visibility = "";
    }
    
    if (document.all["upTbl"])
        document.all["upTbl"].style.visibility = "";
    if (originalRowHeader)
        originalRowHeader.style.visibility = "hidden";
}

function checkm(event) {
    if (dispfr) {
        if (event.srcElement.id != "d1") {
            event.cancellBubble = true;
            event.returnValue = false;
            //return false;
        }
        ;
    }
}

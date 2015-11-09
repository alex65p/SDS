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

//*****************************************************************************************		
//							Scroll table script											 //
//*****************************************************************************************
var originalTable;
var headerTable;
var bIsTable = false;
var originalRowHeader;

function cloneHeader()
{
    tbl = originalTable;
    if (tbl.rows.length <= 1) {
        if (headerTable)
            headerTable.removeNode(true);
        bIsTable = false;
        return;
    }
    row_0 = tbl.rows[0];
    str = "<TABLE  id='upTbl' class='VIEW_TABLE'  style='tableLayout:fixed; ' border='0' >" + row_0.outerHTML + "</TABLE>"
    document.all['headerContainer'].innerHTML = str;
    headerTable = document.all["upTbl"];
    bIsTable = true;
    synchronizeHeader(row_0);
    originalRowHeader = row_0;
    row_0.style.visibility = "hidden";
}

function synchronizeHeader()
{
    try {
        if (!bIsTable)
            return;
        if (originalTable) {
            if (document.all["upTbl"]) {
                trOldHeader = originalTable.rows[0];
                trHeader = document.all["upTbl"].rows[0];
                for (i = 0; i < 2; i++) {
                    document.all['headerContainer'].style.width = originalTable.offsetWidth;
                    for (var j = 0; j < trHeader.cells.length; j++)
                    {
                        if (trHeader.cells[j].offsetWidth != trOldHeader.cells[j].offsetWidth)
                        {
                            trHeader.cells[j].style.width = trOldHeader.cells[j].offsetWidth;
                            trHeader.cells[j].noWrap = true;
                        }
                    }
                }
            }
        }
    }
    catch (ex) {
    }
}

function getScrollBraWidth()
{
    try
    {
        var elem = document.createElement("DIV");
        elem.id = "asdf";
        elem.style.width = 100;
        elem.style.height = 100;
        elem.style.overflow = "scroll";
        elem.style.position = "absolute";
        elem.style.visibility = "hidden";
        elem.style.top = "0";
        elem.style.left = "0";
        document.body.appendChild(elem);
        scrollWidth = document.all['asdf'].offsetWidth - document.all['asdf'].clientWidth;
        document.body.removeChild(elem);
        delete elem;
    }
    catch (ex)
    {
        return false;
    }
    return scrollWidth;
}

function OnInit(obj, pInitialize) {
    divTable.innerHTML = obj.outerHTML;
    tab = divContent.getElementsByTagName("TABLE")[0];
    tab.id = "dataTable";
    divTable.onresize = synchronizeHeader;
    g_Clear();
    pInitialize();
    window.status = "Loaded";
    originalTable = tab;
    cloneHeader();
}

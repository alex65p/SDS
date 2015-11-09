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

// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   HTMLEscaper.java

package org.webmacro.util;

import java.io.PrintStream;

public class HTMLEscaper
{

    public HTMLEscaper()
    {
    }

    public static void main(String args[])
    {
    }

    public static final String escape(String nonHTMLsrc)
    {
        StringBuffer res = new StringBuffer();
        int l = nonHTMLsrc.length();
        for(int i = 0; i < l; i++)
        {
            char c = nonHTMLsrc.charAt(i);
            int idx = entityMap.indexOf(c);
            if(idx == -1)
                res.append(c);
            else
                res.append(quickEntities[idx]);
        }

        return res.toString();
    }

    private static final String ENTITIES[][] = {
        {
            "&", "amp"
        }, {
            "<", "lt"
        }, {
            ">", "gt"
        }, {
            "\"", "quot"
        }, {
            "\203", "#131"
        }, {
            "\204", "#132"
        }, {
            "\205", "#133"
        }, {
            "\206", "#134"
        }, {
            "\207", "#135"
        }, {
            "\211", "#137"
        }, {
            "\212", "#138"
        }, {
            "\213", "#139"
        }, {
            "\214", "#140"
        }, {
            "\221", "#145"
        }, {
            "\222", "#146"
        }, {
            "\223", "#147"
        }, {
            "\224", "#148"
        }, {
            "\225", "#149"
        }, {
            "\226", "#150"
        }, {
            "\227", "#151"
        }, {
            "\231", "#153"
        }, {
            "\232", "#154"
        }, {
            "\233", "#155"
        }, {
            "\234", "#156"
        }, {
            "\237", "#159"
        }, {
            "\240", "nbsp"
        }, {
            "\241", "iexcl"
        }, {
            "\242", "cent"
        }, {
            "\243", "pound"
        }, {
            "\244", "curren"
        }, {
            "\245", "yen"
        }, {
            "\246", "brvbar"
        }, {
            "\247", "sect"
        }, {
            "\250", "uml"
        }, {
            "\251", "copy"
        }, {
            "\252", "ordf"
        }, {
            "\253", "laquo"
        }, {
            "\254", "not"
        }, {
            "\255", "shy"
        }, {
            "\256", "reg"
        }, {
            "\257", "macr"
        }, {
            "\260", "deg"
        }, {
            "\261", "plusmn"
        }, {
            "\262", "sup2"
        }, {
            "\263", "sup3"
        }, {
            "\264", "acute"
        }, {
            "\265", "micro"
        }, {
            "\266", "para"
        }, {
            "\267", "middot"
        }, {
            "\270", "cedil"
        }, {
            "\271", "sup1"
        }, {
            "\272", "ordm"
        }, {
            "\273", "raquo"
        }, {
            "\274", "frac14"
        }, {
            "\275", "frac12"
        }, {
            "\276", "frac34"
        }, {
            "\277", "iquest"
        }, {
            "\300", "Agrave"
        }, {
            "\301", "Aacute"
        }, {
            "\302", "Acirc"
        }, {
            "\303", "Atilde"
        }, {
            "\304", "Auml"
        }, {
            "\305", "Aring"
        }, {
            "\306", "AElig"
        }, {
            "\307", "Ccedil"
        }, {
            "\310", "Egrave"
        }, {
            "\311", "Eacute"
        }, {
            "\312", "Ecirc"
        }, {
            "\313", "Euml"
        }, {
            "\314", "Igrave"
        }, {
            "\315", "Iacute"
        }, {
            "\316", "Icirc"
        }, {
            "\317", "Iuml"
        }, {
            "\320", "ETH"
        }, {
            "\321", "Ntilde"
        }, {
            "\322", "Ograve"
        }, {
            "\323", "Oacute"
        }, {
            "\324", "Ocirc"
        }, {
            "\325", "Otilde"
        }, {
            "\326", "Ouml"
        }, {
            "\327", "times"
        }, {
            "\330", "Oslash"
        }, {
            "\331", "Ugrave"
        }, {
            "\332", "Uacute"
        }, {
            "\333", "Ucirc"
        }, {
            "\334", "Uuml"
        }, {
            "\335", "Yacute"
        }, {
            "\336", "THORN"
        }, {
            "\337", "szlig"
        }, {
            "\340", "agrave"
        }, {
            "\341", "aacute"
        }, {
            "\342", "acirc"
        }, {
            "\343", "atilde"
        }, {
            "\344", "auml"
        }, {
            "\345", "aring"
        }, {
            "\346", "aelig"
        }, {
            "\347", "ccedil"
        }, {
            "\350", "egrave"
        }, {
            "\351", "eacute"
        }, {
            "\352", "ecirc"
        }, {
            "\353", "euml"
        }, {
            "\354", "igrave"
        }, {
            "\355", "iacute"
        }, {
            "\356", "icirc"
        }, {
            "\357", "iuml"
        }, {
            "\360", "eth"
        }, {
            "\361", "ntilde"
        }, {
            "\362", "ograve"
        }, {
            "\363", "oacute"
        }, {
            "\364", "ocirc"
        }, {
            "\365", "otilde"
        }, {
            "\366", "ouml"
        }, {
            "\367", "divid"
        }, {
            "\370", "oslash"
        }, {
            "\371", "ugrave"
        }, {
            "\372", "uacute"
        }, {
            "\373", "ucirc"
        }, {
            "\374", "uuml"
        }, {
            "\375", "yacute"
        }, {
            "\376", "thorn"
        }, {
            "\377", "yuml"
        }, {
            "\200", "euro"
        }
    };
    private static String entityMap;
    private static String quickEntities[];

    static 
    {
        int l = ENTITIES.length;
        StringBuffer temp = new StringBuffer();
        quickEntities = new String[l];
        for(int i = 0; i < l; i++)
        {
            temp.append(ENTITIES[i][0]);
            quickEntities[i] = "&" + ENTITIES[i][1] + ";";
        }

        entityMap = temp.toString();
    }
}

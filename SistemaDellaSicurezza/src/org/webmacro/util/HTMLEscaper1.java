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
// Source File Name:   HTMLEscaper1.java

package org.webmacro.util;

import java.io.PrintStream;

public class HTMLEscaper1
{

    public HTMLEscaper1()
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

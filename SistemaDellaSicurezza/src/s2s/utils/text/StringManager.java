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

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package s2s.utils.text;

/**
 *
 * @author Dario
 */
public class StringManager {

    public StringManager(){
        //
    }

    public static String prepareForJavaScript(String stringToPrepare){
        if (stringToPrepare == null){
            return "";
        }
        return stringToPrepare
                .replace("'", "\\'")
                .replace("\"", "\\\"")
                .replace("\r\n", "\\n")
                .replace("\r", "")
                .replace("\n", "\\n");
    }

    public static String prepare(String stringToPrepare){
        if (stringToPrepare == null){
            return "";
        }
        return stringToPrepare
                .replace("\"", "'")
                .replace("\r\n", " ")
                .replace("\r", " ")
                .replace("\n", " ");
    }

    public static boolean isEmpty(String stringToTest){
        return (stringToTest == null || stringToTest.trim().equals(""));
    }
    
    public static boolean isNotEmpty(String stringToTest){
        return !isEmpty(stringToTest);
    }
    
    public static boolean isEmptyOrZero(String stringToTest){
        return (isEmpty(stringToTest) || stringToTest.trim().equals("0"));
    }
    
    public static boolean isNotEmptyOrZero(String stringToTest){
        return !isEmptyOrZero(stringToTest);
    }
    
    public static String bracket(String stringToBracket){
        return "(" + stringToBracket + ")";
    }
    
    public static String quote(String stringToQuote){
        return "'" + stringToQuote + "'";
    }
    
    public static String doubleQuote(String stringToQuote){
        return "\"" + stringToQuote + "\"";
    }
    
}

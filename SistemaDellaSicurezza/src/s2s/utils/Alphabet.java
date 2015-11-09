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

package s2s.utils;

import java.util.Properties;

/**
 *
 * @author Alessandro
 */
public class Alphabet {

    private Properties alphabetList = null;

    public Alphabet() {

        // 0 - In lavorazione
        // 1 - Emissione

        alphabetList = new Properties();
        alphabetList.setProperty("0","1");
        alphabetList.setProperty("1","A");
        alphabetList.setProperty("A","B");
        alphabetList.setProperty("B","C");
        alphabetList.setProperty("C","D");
        alphabetList.setProperty("D","E");
        alphabetList.setProperty("E","F");
        alphabetList.setProperty("F","G");
        alphabetList.setProperty("G","H");
        alphabetList.setProperty("H","I");
        alphabetList.setProperty("I","L");
        alphabetList.setProperty("L","M");
        alphabetList.setProperty("M","N");
        alphabetList.setProperty("N","O");
        alphabetList.setProperty("O","P");
        alphabetList.setProperty("P","Q");
        alphabetList.setProperty("Q","R");
        alphabetList.setProperty("R","S");
        alphabetList.setProperty("S","T");
        alphabetList.setProperty("T","U");
        alphabetList.setProperty("U","V");
        alphabetList.setProperty("V","Z");
        alphabetList.setProperty("Z","0");
    }

    public String getFirstElement(){
        return getNextElement("Z");
    }

    public String getNextElement(String Key){
        if (Key == null)
            return getNextElement(getFirstElement());
        else
            return alphabetList.getProperty(Key);
    }

    public String getLastElement(){
        return getNextElement("V");
    }
}

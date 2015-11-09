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
package s2s.luna.util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import javax.naming.InitialContext;
import javax.naming.NameClassPair;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;

/**
 *
 * @author Dario
 */
public class EnvironmentInfo {

    public String getEnvProperty(String property) throws Exception {
        String propertyValue = "";
        try {
            InitialContext EnvironmentContext = new InitialContext();
            propertyValue = (String) EnvironmentContext.lookup(property).toString();
        } catch (NamingException NE) {
            NE.printStackTrace();
            // Eccezione tracciata ma volutamente non rilancia.
            // Nel caso non trovasse la variabile è corretto che torni null.
        } finally {
            return propertyValue;
        }
    }

    public Collection getEnvProperties() throws Exception {
        return getEnvProperties("", false);
    }

    public Collection getEnvProperties(String envSubDir, boolean sortProperties) throws Exception {
        ArrayList envListReturn = new ArrayList();
        try {
            InitialContext EnvironmentContext = new InitialContext();
            NamingEnumeration<NameClassPair> envList =
                    EnvironmentContext.list("java:comp/env/"+envSubDir);

            if (envList != null) {
                NameClassPair item;
                while (envList.hasMore()) {
                    item = envList.next();
                    envListReturn.add(item.getName());
                }
            }
        } catch (NamingException NE) {
            NE.printStackTrace();
            // Eccezione tracciata ma volutamente non rilancia.
            // Nel caso non trovasse variabili definite è corretto che torni una lista vuota.
        }
        if (sortProperties) Collections.sort(envListReturn);
        return envListReturn;
    }
}

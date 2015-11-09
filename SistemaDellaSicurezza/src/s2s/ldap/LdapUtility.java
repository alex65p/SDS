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
 * ConnectionLdap.java
 *
 * Created on 24 luglio 2007, 15.06
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package s2s.ldap;

import s2s.luna.conf.ApplicationConfigurator;
import com.novell.ldap.LDAPConnection;

/**
 *
 * @author dario
 */
public class LdapUtility {

    /** Creates a new instance of ConnectionLdap */
    public LdapUtility() {
    }

    private boolean isNullValue(String source) {
        return source == null || source.trim().equals("");
    }

    public boolean checkLdapLoginCredential(String userName, String userPassword) throws Exception {
        LDAPConnection lc = new LDAPConnection();
        int ldapVersion = LDAPConnection.LDAP_V3;
        boolean ritorno = false;

        try {
            // check for required data
            if (isNullValue(ApplicationConfigurator.HOST)
                    || (isNullValue(ApplicationConfigurator.PORT)
                    && isNullValue(ApplicationConfigurator.PORT_SSL))
                    /*
                    || isNullValue(ApplicationConfigurator.SEARCH_PATH)
                    || isNullValue(ApplicationConfigurator.USER_DN_ATTRIBUTE_NAME)
                     */) {
                throw new Exception("Dati obbligatori per la connessione ad LDAP non presenti.");
            }

            // Connect to the server
            try {
                lc.connect(ApplicationConfigurator.HOST, Integer.parseInt(ApplicationConfigurator.PORT));
            } catch (Exception e) {
                e.printStackTrace();
                throw e;
            }

            // Try login with user credential
            try {
                if (isNullValue(userName) || isNullValue(userPassword)) return false;

                userName = isNullValue(ApplicationConfigurator.USER_DN_ATTRIBUTE_NAME)
                        ?userName
                        :ApplicationConfigurator.USER_DN_ATTRIBUTE_NAME + "=" + userName;
                userName += isNullValue(ApplicationConfigurator.SEARCH_PATH)
                        ?""
                        :"," + ApplicationConfigurator.SEARCH_PATH;

                lc.bind(ldapVersion,userName,userPassword);
            } catch (Exception e) {
                // Se si verifica un eccezione in questo punto significa che l'utente non è stato
                // trovato, per questo motivo risollevo l'eccezione con il messaggio standard di
                // utente e/o password errati.
                e.printStackTrace();
                throw new Exception(ApplicationConfigurator.LanguageManager.getString("LDAP.Msg4"));
            }
            ritorno = true;
        } finally {
            // disconnect with the server
            lc.disconnect();
            return ritorno;
        }
    }
}

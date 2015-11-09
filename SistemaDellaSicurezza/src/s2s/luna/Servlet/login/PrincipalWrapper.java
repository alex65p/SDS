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

package s2s.luna.Servlet.login;

import com.apconsulting.luna.ejb.Utente.IUtenteHome;
import com.apconsulting.luna.ejb.Utente.view_sc_users;
import java.security.Principal;
import java.util.Collection;
import java.util.Iterator;
import s2s.ejb.pseudoejb.PseudoContext;

/**
 *
 * @author Dario
 */
public class PrincipalWrapper extends Object implements Principal {

    private view_sc_users USER;
    private String[] USER_ROLES;

    public PrincipalWrapper(view_sc_users _user){
        this.USER = _user;
        this.USER_ROLES = this._getRoles();
    }

    public String getName(){
        return this.USER.LOGIN;
    }

    public String[] getRoles() {
        return this.USER_ROLES;
    }

    private String[] _getRoles() {
        String str[] = null;
        try {
            IUtenteHome home = (IUtenteHome) PseudoContext.lookup("UtenteBean");
            Collection userRolesList = home.getUserSecurityRoles(this.getName());
            if (userRolesList != null && !userRolesList.isEmpty()){
                Iterator userRolesIT = userRolesList.iterator();
                view_sc_users userRole = null;
                int index = 0;
                str = new String[userRolesList.size()];
                while (userRolesIT.hasNext()){
                    userRole = (view_sc_users)userRolesIT.next();
                    str[index] = userRole.ROLE;
                    index++;
                }
            }
        } catch (Exception E){
            E.printStackTrace();
        } finally {
            return str;
        }
    }

    public boolean isUser(){
        return this.USER.LOGIN_AS.equals("UTN")?true:false;
    }

    public boolean isConsultant(){
        return this.USER.LOGIN_AS.equals("CON")?true:false;
    }
}

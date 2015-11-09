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

package s2s.luna.ejb.Security;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: AP Consulting</p>
 * @author Artur Denysenko
 * @version 1.0
 */
import javax.ejb.*;
import java.util.*;
import s2s.luna.ejb.Security.Security.*;


public interface ISecurityHome extends EJBHome
{
        public static int ACCESS_OBJECT_NOT_FOUND=0;
        public static int ACCESS_OBJECT_WRONG_AZIENDA=1;
        public static int ACCESS_OBJECT_OK=2;

        public Collection getConsultantPermissions();
        public Collection getMultiConsultantPermissions();

        public Collection getUserPermissions(String strUser);
        public Collection getAllPermissions();

        public SecurityUserPermissionDetails getUserPermissionDetails(String strUser, String strPermission);
        public SecurityUserPermissionDetails getConsultantPermissionDetails(String strPermission);

        public void setSecurityModule(SecurityModule module);
        public SecurityModule getSecurityModule(String strName);

        public SecurityUserPermissionDetails  accessModule(String strModule, String strUser);
        public void setSecurityContextData(long lContextId, long lCurrentAzienda, String strUser);

        public int accessObject(long lObjectId, String strUser,  boolean isConsultant);
}

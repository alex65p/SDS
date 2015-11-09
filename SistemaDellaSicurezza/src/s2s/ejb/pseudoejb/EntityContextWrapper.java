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

	package s2s.ejb.pseudoejb;

import javax.ejb.*;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: AP Consulting</p>
 * @author Artur Denysenko
 * @version 1.0
 */

public class EntityContextWrapper implements EntityContext
{
  protected Object m_key;

  public EntityContextWrapper() {}

  public EntityContextWrapper(Object key) {
      m_key=key;
  }

  public java.lang.Object getPrimaryKey(){
    return m_key;
  }

  //<ejbcontext description="EJBContext implementation">

    //<ejb2-only description="EJB 2.* only">

      public EJBLocalObject getEJBLocalObject(){return null;}
      public EJBLocalHome getEJBLocalHome(){ return null;}
      public boolean isCallerInRole(java.lang.String strRole){ return false;}
      public TimerService getTimerService(){ return null;}

    //</ejb2-only>

    public EJBObject getEJBObject(){return null;}
    public EJBHome getEJBHome(){ return null;}

    public java.util.Properties getEnvironment(){ return null;}
    public java.security.Identity getCallerIdentity(){ return null;}
    public java.security.Principal getCallerPrincipal(){ return null;}
   	public boolean isCallerInRole(java.security.Identity role){ return true;}

    public javax.transaction.UserTransaction getUserTransaction(){ return null;}
    public void setRollbackOnly(){}

    public boolean getRollbackOnly(){ return false;}

  //</ejbcontext>

}

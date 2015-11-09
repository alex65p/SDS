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

import javax.naming.*;
/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: AP Consulting</p>
 * @author Artur Denysenko
 * @version 1.0
 */

public class PseudoContext
{

  public static java.util.HashMap m_hsObjects = new  java.util.HashMap();

  public static Object lookup(String name) throws NamingException{
    Object obj=m_hsObjects.get(name);
    if(obj==null) throw new NamingException("["+name+"] wasn't binded to PseudoContext");
    return obj;
    /*
    try{
      Class cl=(Class)m_hsObjects.get(name);
      return cl.newInstance();
    }
    catch(Exception ex){
      throw new NamingException(ex.getMessage());
    }
    */
  }

  public static void bind(String name, Object obj) throws NamingException{
    m_hsObjects.put(name, obj);
    //throw new NamingException(name);
  }

}

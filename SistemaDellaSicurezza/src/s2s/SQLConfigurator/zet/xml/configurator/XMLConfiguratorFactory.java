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

package s2s.SQLConfigurator.zet.xml.configurator;

import javax.naming.*;
import javax.naming.spi.*;
import java.util.*;
import s2s.luna.conf.ApplicationConfigurator;

/**
 * <p>Title: SQL Configurator</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author Artur Denysenko
 * @version 1.0
 */

public class XMLConfiguratorFactory implements ObjectFactory{
  protected XMLConfigurator m_config;

  public static class RefAddrTest extends RefAddr {
    String strType;
    Object obj;

    RefAddrTest(String strType, Object obj){
      super(strType);
      this.strType = strType;
      this.obj = obj;
    }

    public String getType() {
      return strType;
    }

    public Object getContent() {
      return obj;
    }

  }

  public Object getObjectInstance(Object obj, Name strName, Context nameCtx, Hashtable environment) throws Exception {
    TRACE("XMLConfiguratorFactory loading ...");
    Reference ref = (Reference) obj;
    Enumeration addrs = ref.getAll();
    if (m_config != null)       return m_config;
    m_config = new XMLConfigurator();
    while (addrs.hasMoreElements()) {
      RefAddr addr = (RefAddr) addrs.nextElement();
      String name = addr.getType();
      String value = (String) addr.getContent();

      if (name.equals("path")) {
        m_config.setPath(ApplicationConfigurator.getApplicationPath() + value);
      }
      else if (name.equals("tag")) {
        m_config.setTag(value);
      }
    }
    m_config.Config();
    TRACE("XMLConfiguratorFactory loaded ["+m_config.m_strTag+"] in ["+m_config.m_strPath+"]");
    return m_config;
  }

  public static void main(String str[]) throws Exception {
    XMLConfiguratorFactory f = new XMLConfiguratorFactory();
    Reference ref = new Reference("XMLConfiguratorFactory");
    ref.add(new XMLConfiguratorFactory.RefAddrTest("path", "C:\\_Tomcat\\webapps\\Jenesic\\Web-inf\\sql"));
    ref.add(new XMLConfiguratorFactory.RefAddrTest("tag", "de"));
    XMLConfigurator conf = (XMLConfigurator) f.getObjectInstance(ref, null, null, null);
    return;
  }
  public static void TRACE(String str){
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("HH:mm:ss:SS");
    String s = sdf.format(new java.util.Date());
    if(s.length()==11) s = s + " ";
  }

}

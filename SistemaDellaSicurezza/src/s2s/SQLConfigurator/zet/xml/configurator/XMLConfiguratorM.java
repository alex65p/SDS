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

/**
 * <p>Title: SQL Configurator</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author Artur Denysenko
 * @version 1.0
 */

import javax.naming.*;

public class XMLConfiguratorM implements XMLConfiguratorMMBean {

  private XMLConfigurator m_config= new XMLConfigurator();
  private String m_strJNDIName;

  public XMLConfiguratorM() {
  }

  public void init(){
  }

  public void start()throws Exception{
    InitialContext ctx = new InitialContext();
    ctx.rebind(m_strJNDIName, m_config);
  }

  public void stop()throws Exception{
    InitialContext ctx = new InitialContext();
    ctx.unbind(m_strJNDIName);
  }

  public void destroy(){
  }

  public String getPath(){
    return m_config.m_strPath;
  }

  public void setPath(String strPath){
    m_config.setPath(strPath);
  }

  public String getTag(){
    return m_config.m_strTag;
  }

  public void setTag(String strTag){
    m_config.setTag(strTag);
  }

  public String getJNDIName(){
    return m_strJNDIName;
  }

  public void setJNDIName(String strJNDIName){
   m_strJNDIName  = strJNDIName;
  }

  ////////////---------------------------------------------------------------------------------------------------------
  public static void main(String str[]) throws Exception {
    XMLConfiguratorM mb =  new XMLConfiguratorM();
    mb.setJNDIName("XXXX");
    mb.setPath("C:\\_Tomcat\\webapps\\luna\\Web-inf\\sql");
    mb.setTag("postgre");
    mb.init();
    mb.start();
    return;
  }

}

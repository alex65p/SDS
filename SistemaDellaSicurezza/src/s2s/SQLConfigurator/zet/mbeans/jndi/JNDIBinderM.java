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

package s2s.SQLConfigurator.zet.mbeans.jndi;

/**
 * <p>Title: SQL Configurator</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author Artur Denysenko
 * @version 1.0
 */
import javax.naming.*;


public class JNDIBinderM implements JNDIBinderMMBean {

  private Object m_object;
  private String m_strJNDIName;

  public JNDIBinderM() {
  }

  public void init() {
  }

  public void start() throws Exception {
     InitialContext ctx = new InitialContext();
     ctx.rebind(m_strJNDIName, m_object);
  }

  public void stop() throws Exception {
     InitialContext ctx = new InitialContext();
     ctx.unbind(m_strJNDIName);
  }

  public void destroy() {
  }

  public void setBoolean(Boolean b) {
    m_object=b;
  }

  public Boolean getBoolean() {
    return (Boolean)m_object;
  }

  public void setByte(Byte bt) {
     m_object=bt;
  }

  public Byte getByte() {
     return (Byte)m_object;
  }

  public String getJNDIName() {
   return m_strJNDIName;
  }

  public void setJNDIName(String strJNDIName) {
    m_strJNDIName=strJNDIName;
  }
  ///////////////////////////////////////////////////////////////////////////
  public static void main(String[] args) {
   JNDIBinderM JNDIBinderM1 = new JNDIBinderM();
  }

}

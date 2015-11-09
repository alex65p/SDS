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

import org.jdom.*;
import org.jdom.input.*;
import java.util.*;

import java.io.File;

//import org.jdom.xpath.XPath;

/**
 * <p>Title: SQL Configurator</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author Artur Denysenko
 * @version 1.0
 */

public class XMLConfigurator implements java.io.Serializable{
  protected String m_strPath, m_strTag;
  protected Hashtable m_hash= new Hashtable();

  private static class ConfigEntity{
    Hashtable m_hash = new Hashtable();
    File m_file;
    long m_lLastModified;

    public ConfigEntity(String strPath) {
        m_file = new File(strPath);
        m_lLastModified = m_file.lastModified();
    }

    public boolean isModified(){
      long l=m_lLastModified;
      m_lLastModified=m_file.lastModified();
      return m_lLastModified!=l;
    }

    public Object get(Object key){
      return m_hash.get(key);
    }
  }

  void setPath(String strPath){
    m_strPath=strPath;
  }

  void setTag(String strTag){
    m_strTag=strTag;
  }

  void Config(){
  }

  public synchronized String getString(String strBean, String strKey) throws Exception{
     if(!m_hash.containsKey(strBean)) loadFile(strBean);
     ConfigEntity entity= (ConfigEntity)m_hash.get(strBean);
     if(entity.isModified()){
       XMLConfiguratorFactory.TRACE("XMLConfigurator: file is modified: " + entity.m_file.getAbsolutePath());
       try{
         reloadEntity(entity);
       }
       catch(Exception ex){
         m_hash.remove(strBean);
         throw ex;
       }
     }
     return (String)entity.get(strKey);
  }

  protected synchronized ConfigEntity loadFile(String strBean) throws Exception{
    ConfigEntity entity=new ConfigEntity(m_strPath+"/"+strBean+".xml");
    reloadEntity(entity);
    m_hash.put(strBean, entity);
    return entity;
  }

  protected synchronized void reloadEntity(ConfigEntity entity) throws Exception {
      entity.m_hash.clear();
      XMLConfiguratorFactory.TRACE("XMLConfigurator: loading file: " + entity.m_file.getAbsolutePath());
      long l=System.currentTimeMillis();
      try{
        SAXBuilder builder = new SAXBuilder();
        Document doc = builder.build(entity.m_file);
        Element queries = doc.getRootElement().getChild("records");
        //XPath xp=XPath.newInstance("/config/sql-config/queries/query[./@enabled='true']|/config/sql-config/queries/query[ not(./@enabled)] ");
        //List ls=xp.selectNodes(doc);

        List ls = queries.getChildren();

        Iterator it = ls.iterator();
        String strKey, strValue;
        while (it.hasNext()) {
          Element el = (Element) it.next();
          strKey = el.getAttributeValue("enabled");
          if (strKey == null || strKey.equalsIgnoreCase("true")) {
            strKey = el.getAttributeValue("key");
            if (entity.m_hash.containsKey(strKey))
              throw new Exception("Dublicate key [" + strKey + "] in [" +
                                  entity.m_file.getAbsolutePath() + "]");
            Element e = el.getChild(m_strTag);
            if (e == null) {
              throw new Exception("Missing child [" + m_strTag +
                                  "] in tag [" + strKey + "] in [" +
                                  entity.m_file.getAbsolutePath() + "]");
            }
            strValue = e.getTextTrim();
            entity.m_hash.put(strKey, strValue);
          }
        }
        l = System.currentTimeMillis() - l;
      }
      catch(Exception ex){
        XMLConfiguratorFactory.TRACE("XMLConfigurator: failed to load file " + entity.m_file.getAbsolutePath()+"\n\r"+ex.getMessage());
        throw new Exception("XMLConfigurator: "+ ex.getMessage(), ex);
      }
      XMLConfiguratorFactory.TRACE("XMLConfigurator: file loaded in " +l+" ms: " + entity.m_file.getAbsolutePath());

  }

}

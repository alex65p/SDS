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

import java.security.Principal;
import javax.ejb.*;
import javax.sql.*;
import javax.naming.*;
import java.sql.*;
import java.util.*;

import org.apache.log4j.Logger;
import s2s.SQLConfigurator.zet.xml.configurator.XMLConfigurator;
import s2s.ejb.pseudoejb.BMPConnection.*;
import s2s.SQLConfigurator.sqlContainer.ContainerSQLFactory;
import s2s.SQLConfigurator.sqlContainer.ContainerSQL;
import s2s.luna.conf.ApplicationConfigurator;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: AP Consulting</p>
 * @author Artur Denysenko
 * @version 1.0
 */
public abstract class BMPEntityBean implements EntityBean, EJBLocalHome {
    //<configuration>

    protected Logger logger = Logger.getLogger(this.getClass());
    public static final boolean EJB_DEPLOYED = false;
    public static final boolean TRACE_SQL = true;
    public ContainerSQL SQLContainer = ContainerSQLFactory.getContainerSQLInstance();
    // Configurazione JNDI
    public static final String JNDI_SQL_CONFIG_POSTGRE =
            "java:comp/env/helper/SQLConfig_postgre";
    public static final String JNDI_SQL_CONFIG_ORACLE =
            "java:comp/env/helper/SQLConfig_oracle";
    public static final String JNDI_SQL_CONFIG_DB2 =
            "java:comp/env/helper/SQLConfig_db2";
    // Configurazione SEQUENCE
    public static final long INTEGER_MAX = Integer.MAX_VALUE;
    public static final long INTEGER_MIN = Integer.MIN_VALUE;
    public static final long INTEGER_RANGE = INTEGER_MAX - INTEGER_MIN;
    public static final int SEQUENCE_COUNT = 10;
    public static final String SEQUENCE_SQL_POSTGRE = "SELECT nextval('SQ_SC_CONTEXT')";
    public static final String SEQUENCE_SQL_ORACLE = "SELECT SQ_SC_CONTEXT.nextval + 1000 from dual";
    public static final String SEQUENCE_SQL_DB2 = "SELECT nextval for SQ_SC_CONTEXT from sysibm.sysdummy1";
    public static final String SEQUENCE_SQL_MYSQL_PREQUERY = "UPDATE SQ_SC_OBJECT SET id=LAST_INSERT_ID(id+1);";
    public static final String SEQUENCE_SQL_MYSQL = "SELECT LAST_INSERT_ID();";
    //</configuration>
    protected EntityContext m_entityContext;
    protected boolean m_isModified;
    protected boolean m_isOracle;

    protected void setModified() {
        m_isModified = true;
        if (!EJB_DEPLOYED) {
            try {
                ejbStore();
            } catch (Exception ex) {
                ex.printStackTrace();
                throw new EJBException(ex);
            }
        } // NOT EJB_DEPLOYED
    }

    ///<security> =========================================================================================
    public String Replace(String psWord, String psReplace, String psNewSeg) {
        StringBuffer lsNewStr = new StringBuffer();
        int liFound = 0;
        int liLastPointer = 0;
        do {
            liFound = psWord.indexOf(psReplace, liLastPointer);
            if (liFound < 0) {
                lsNewStr.append(psWord.substring(liLastPointer, psWord.length()));
            } else {
                if (liFound > liLastPointer) {
                    lsNewStr.append(psWord.substring(liLastPointer, liFound));
                }

                lsNewStr.append(psNewSeg);
                liLastPointer = liFound + psReplace.length();
            }
        } while (liFound > -1);
        return lsNewStr.toString();
    }

    private Object getUserPrincipal() {
        return PrincipalHolder.getPrincipal();
    }

    private long getCustomRoleValue(String strKey) throws Exception {

        //<reflection>
        Class c = getUserPrincipal().getClass();

        String str[] = new String[0];

        java.lang.reflect.Method method = c.getMethod("getRoles", new Class[]{});
        str = (String[]) method.invoke(getUserPrincipal(), new Object[]{});

        strKey += ":";
        //</reflection>

        for (int i = 0; i < str.length; i++) {
            if (str[i].indexOf(strKey) == -1) {
                continue;
            }
            String strr = Replace(str[i], strKey, "");
            return Long.parseLong(strr);
        }
        return -1;
    }

    private long getSecurityContextId() throws Exception {
        return getCustomRoleValue("SECURITY_CONTEXT");
    }

    //<security> ======================================================================================
    protected void setSecurityObjectProperties(BMPConnection bmp, long lID_OBJECT,
            long lCOD_AZL) {
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE SC_OBJECTS SET  ID_AZIENDA=? WHERE ID_OBJECT=? ");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lID_OBJECT);

            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
    }

    protected void registerSecurityObject(BMPConnection bmp, long lID_OBJECT, long lCOD_AZL,
            boolean bRegister) {
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM SC_OBJECTS WHERE ID_OBJECT=? ");
            ps.setLong(1, lID_OBJECT);
            ps.executeUpdate();

            if (bRegister) {
                createSecurityObject(bmp, lID_OBJECT, lCOD_AZL);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
    }

    protected void createSecurityObject(BMPConnection bmp, long lID_OBJECT, long lCOD_AZL) {
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO SC_OBJECTS "
                    + "(ID_OBJECT, "
                    + "ID_AZIENDA, "
                    + "TYPE, "
                    + "DATA) "
                    + "VALUES "
                    + "(?,?,?,?)");
            ps.setLong(1, lID_OBJECT);
            ps.setLong(2, lCOD_AZL);

            String strTemp = this.getClass().toString();
            {
                /*
                 * Gestisco il fatto che il bean al quale ci si riferisce sia
                 * nella cartella WEB\src, come file .jsp (Vecchia gestione) o
                 * che sia nella classe dei sorgenti java (src), come file .java
                 * (Nuova gestione).
                 */
                int i = strTemp.lastIndexOf('$');
                if (i == -1) {
                    i = strTemp.lastIndexOf('.');
                }
                strTemp = strTemp.substring(i + 1, strTemp.length());
                strTemp = Replace(strTemp, "Bean", "");
            }
            ps.setString(3, strTemp);
            ps.setDate(4, new java.sql.Date(System.currentTimeMillis()));
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex.toString() + "createSecurityObject Error");
        }
    }

    private String getSequence(BMPConnection bmp) throws java.sql.SQLException {
        ConnectionType ct = bmp.getType();
        if (ct == ConnectionType.POSTGRE) {
            return SEQUENCE_SQL_POSTGRE;
        }
        if (ct == ConnectionType.ORACLE) {
            return SEQUENCE_SQL_ORACLE;
        }
        if (ct == ConnectionType.DB2) {
            return SEQUENCE_SQL_DB2;
        }
        if (ct == ConnectionType.MYSQL) {
            bmp.prepareStatement(SEQUENCE_SQL_MYSQL_PREQUERY).execute();
            return SEQUENCE_SQL_MYSQL;
        }
        return null;
    }

    protected long NEW_SIMPLE_ID() {
        BMPConnection bmp = getConnection();
        try {
            long l = 0;
            {
                PreparedStatement ps = bmp.prepareStatement(getSequence(bmp));
                ResultSet rs = ps.executeQuery();
                rs.next();
                l = rs.getLong(1);
            }
            return l;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex.toString() + "NEW ID Error");
        } finally {
            bmp.close();
        }
    }

    protected long NEW_ID() {
        ///return System.currentTimeMillis()-1073836205562L;
        BMPConnection bmp = getConnection();
        try {
            long lContextId = 0;
            long l = 0;
            long lIdAzienda = 0;
            {
                PreparedStatement ps = bmp.prepareStatement(
                        "SELECT ID_AZIENDA FROM SC_CONTEXT WHERE ID_CONTEXT=?");
                lContextId = getSecurityContextId();
                ps.setLong(1, lContextId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    lIdAzienda = rs.getLong(1);
                } else {
                    lIdAzienda = lContextId;
                }
            }
            {
                PreparedStatement ps = bmp.prepareStatement(getSequence(bmp));
                ResultSet rs = ps.executeQuery();
                rs.next();
                l = rs.getLong(1);
            }
            createSecurityObject(bmp, l, lIdAzienda);
            logger.info("GENERATE NEW_ID: " + l);
            return l;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex.toString() + "NEW ID Error");
        } finally {
            bmp.close();
        }
    }

    protected void unsetModified() {
        m_isModified = false;
    }

    protected boolean isModified() {
        return m_isModified;
    }

    protected EntityContext getEntityContext() {
        return m_entityContext;
    }

    protected Object getEntityKey() {
        return m_entityContext.getPrimaryKey();
    }

    public void setEntityContext(EntityContext ctx) {
        this.m_entityContext = ctx;
    }

    public void unsetEntityContext() {
        this.m_entityContext = null;
    }

    //<EJBHome>
    public void remove(javax.ejb.Handle handle) {
    }

    //<EJBLocalHome>
    public void remove(Object obj) {
    }

    //<EJBLocalHome>
    public EJBMetaData getEJBMetaData() {
        return null;
    }

    public HomeHandle getHomeHandle() {
        return null;
    }

    //<EJBHome>
    //<EJBLocalObject>
    public EJBLocalHome getEJBLocalHome() {
        return this;
    }

    public boolean isIdentical(EJBLocalObject obj) {
        return false;
    }

    public void remove() {
    }

    //</EJBLocalObject>
    //</EJBObject>
    public boolean isIdentical(EJBObject obj) {
        return true;
    }

    public java.lang.Object getPrimaryKey() {
        return getEntityKey(); /*(return null;*/
    }

    public Handle getHandle() {
        return null;
    }

    public EJBHome getEJBHome() {
        return null;
    }

    //</EJBObject>
    private String getSqlConfig() {
        ConnectionType cmp = BMPConnection.getConnectionType();
        if (cmp == ConnectionType.POSTGRE) {
            return JNDI_SQL_CONFIG_POSTGRE;
        }
        if (cmp == ConnectionType.ORACLE) {
            return JNDI_SQL_CONFIG_ORACLE;
        }
        if (cmp == ConnectionType.DB2) {
            return JNDI_SQL_CONFIG_DB2;
        }
        if (cmp == ConnectionType.MYSQL) {
            return JNDI_SQL_CONFIG_POSTGRE;
        }
        return null;
    }

    public String getSQL(String strBeanName, String strResource) {
        try {
            Context initCtx = new InitialContext();
            XMLConfigurator conf = (XMLConfigurator) initCtx.lookup(getSqlConfig());
            return conf.getString(strBeanName, strResource);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
    }

    public String toString(java.util.ArrayList obj) {
        if (obj == null || obj.size() == 0) {
            if (BMPConnection.getConnectionType() == ConnectionType.DB2) {
                return " NULLIF(1,1) ";
            } else {
                return " NULL ";
            }
        }
        String cods = "";
        Iterator azl_ids = obj.iterator();
        while (azl_ids.hasNext()) {
            cods += azl_ids.next() + ",";
        }
        cods = cods.substring(0, cods.length() - 1);
        return cods;
    }

    //<extended object>
    public boolean isExtendedObject(String strTableName, long lCOD) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT COUNT(*) FROM "
                    + strTableName
                    + "_pk WHERE first_key IN ( SELECT first_key FROM "
                    + strTableName
                    + "_pk WHERE second_key=?) ");
            ps.setLong(1, lCOD);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                return false;
            }
            return rs.getLong(1) > 1;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public long getExtendedObjectNeibour(BMPConnection bmp, String strTableName,
            long lCOD, long lCOD_AZL_NEIGHBOUR) {
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT second_key FROM " + strTableName
                    + "_pk WHERE cod_azl=? AND first_key IN ( SELECT first_key FROM "
                    + strTableName + "_pk WHERE second_key=?) ");
            ps.setLong(1, lCOD_AZL_NEIGHBOUR);
            ps.setLong(2, lCOD);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                return -1;
            }
            return rs.getLong(1);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
    }

    public ResultSet getExtendedObjectsEx(BMPConnection bmp, String strTableName,
            long lCOD, long lCOD_AZL,
            java.util.ArrayList alAziende) throws
            java.sql.SQLException {
        strTableName += "_pk";
        PreparedStatement ps = bmp.prepareStatement(
                "SELECT cod_azl, second_key FROM " + strTableName
                + " WHERE cod_azl NOT IN (" + lCOD_AZL
                + ") AND first_key IN ( SELECT first_key FROM " + strTableName
                + " WHERE second_key=" + lCOD + " )");
        return ps.executeQuery();
    }

    public ResultSet getExtendedObjectsEx2(BMPConnection bmp, String strTableName,
            long lCOD, long lCOD_AZL,
            java.util.ArrayList alAziende) throws
            java.sql.SQLException {

        strTableName += "_pk";
        String alAziendeSQLString = "";

        if (alAziende.size() > 0) {
            for (int i = 0; i < alAziende.size(); i++) {
                if (!alAziendeSQLString.equals("")) {
                    alAziendeSQLString += ",";
                }
                alAziendeSQLString += alAziende.get(i).toString();
            }
        } else {
            alAziendeSQLString = "0";
        }

        logger.info("Get Extended Object 2 - DATI DELLA TABELLA \"" + strTableName + "\"");
        logger.info("Chiave secondaria: " + lCOD);
        logger.info("Lista Aziende: " + alAziendeSQLString);

        PreparedStatement ps = bmp.prepareStatement(
                "SELECT "
                + "   cod_azl, "
                + "   second_key "
                + "FROM "
                + strTableName + " "
                + "WHERE "
                + "   cod_azl IN (" + alAziendeSQLString + ") AND "
                + "   first_key IN ( "
                + "           SELECT "
                + "               first_key "
                + "           FROM "
                + strTableName
                + "           WHERE "
                + "               second_key=" + lCOD + " )");
        return ps.executeQuery();
    }

    public String getExtendedObjects(String strTableName,
            java.util.ArrayList alAziende) {
        strTableName += "_pk";
        return "SELECT second_key FROM " + strTableName
                + " WHERE first_key IN ( SELECT first_key FROM " + strTableName
                + " WHERE second_key=? )";
    }

    public void setExtendedObject(BMPConnection bmp, String strTableName,
            long lFirstKey, long lSecondKey, long lCOD_AZL) {
        try {
            logger.info("Set Extended Object - DATI DELLA TABELLA \"" + strTableName + "_PK\"");
            logger.info("Chiave primaria: " + lFirstKey);
            logger.info("Chiave secondaria: " + lSecondKey);
            logger.info("Azienda: " + lCOD_AZL);

            PreparedStatement ps = bmp.prepareStatement("INSERT INTO "
                    + strTableName
                    + "_pk (first_key,second_key,cod_azl) VALUES(?,?,?)");
            ps.setLong(1, lFirstKey);
            ps.setLong(2, lSecondKey);
            ps.setLong(3, lCOD_AZL);
            ps.executeUpdate();
            setSecurityObjectProperties(bmp, lSecondKey, lCOD_AZL);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
    }

    public void removeExtendedObject(BMPConnection bmp, String strTableName,
            long lSecondKey, long lCOD_AZL,
            java.util.ArrayList alAziende) {
        try {
            logger.info("Remove Extended Object - DATI DELLA TABELLA \"" + strTableName + "_PK\"");
            logger.info("Chiave secondaria: " + lSecondKey);
            logger.info("Azienda: " + lCOD_AZL);

            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM "
                    + strTableName + "_pk "
                    + "WHERE "
                    + "second_key IN "
                    + "(  SELECT "
                    + "second_key "
                    + "FROM "
                    + strTableName + "_pk "
                    + "WHERE "
                    + "(  cod_azl=? "
                    + "OR cod_azl IN (" + toString(alAziende) + ")) "
                    + "AND first_key IN "
                    + "(  SELECT "
                    + "first_key "
                    + "FROM "
                    + strTableName + "_pk "
                    + "WHERE "
                    + "second_key=?))");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lSecondKey);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
    }
//</extended object>

    public BMPConnection getConnection() {
        try {
            InitialContext ic = new InitialContext();
            Object obj = null;

            if (ApplicationConfigurator.DATABASE_CHANGE) {
                /* 
                 * Gestione multi-db
                 * Abilitato il meccanismo di cambio runtime del dababase 
                 * di utilizzo del "Sistema della sicurezza".
                 * 
                 */
                obj = ic.lookup("java:comp/env/jdbc/"
                        + ApplicationConfigurator.getDatabase());
            } else {
                // Gestione Standard 
                boolean isMultipleDB = false;
                isMultipleDB = ((Boolean) (new InitialContext()).lookup("java:comp/env/MultipleDatabase")).booleanValue();

                if (isMultipleDB) {
                    String strUser = "";
                    Principal P = PrincipalHolder.getPrincipal();
                    if (P != null) {
                        strUser = P.getName() != null ? P.getName() : "";
                    }
                    if (strUser.equalsIgnoreCase("luca")) {
                        obj = ic.lookup("java:comp/env/jdbc/luna_test");
                    } else if (strUser.equalsIgnoreCase("isr")) {
                        obj = ic.lookup("java:comp/env/jdbc/isr");
                    } else if (strUser.equalsIgnoreCase("autostrade")) {
                        obj = ic.lookup("java:comp/env/jdbc/atos");
                    } else if (strUser.equalsIgnoreCase("antony")) {
                        obj = ic.lookup("java:comp/env/jdbc/teknopera");
                    } else if (strUser.equalsIgnoreCase("oracle")) {
                        obj = ic.lookup("java:comp/env/jdbc/oracle");
                        m_isOracle = true;
                    } else {
                        obj = ic.lookup("java:comp/env/jdbc/luna");
                    }
                } else {
                    obj = ic.lookup("java:comp/env/jdbc/luna");
                }
            }

            DataSource ds = (DataSource) obj;
            return new BMPConnection(ds.getConnection());
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
    }
    //---------------------------------------------------------------------------------

    public static class PrincipalHolder {

        static java.security.Principal m_principal;

        public static void setPrincipal(java.security.Principal principal) {
            m_principal = principal;
        }

        public static java.security.Principal getPrincipal() {
            return m_principal;
        }
    }
}

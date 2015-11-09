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

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: AP Consulting</p>
 * @author Artur Denysenko
 * @version 1.0
 */
import com.ibm.db2.jcc.c.ic;
import java.sql.*;
import javax.ejb.*;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import org.apache.log4j.*;
import s2s.luna.conf.ApplicationConfigurator;

//<bmp-connection-helper>
//* static public*/
public class BMPConnection {

    private static Logger logger = Logger.getLogger(BMPConnection.class);

    public static class ConnectionType {

        public static ConnectionType POSTGRE = new ConnectionType("PostgreSQL");
        public static ConnectionType ORACLE = new ConnectionType("Oracle");
        public static ConnectionType MYSQL = new ConnectionType("MySQL");
        public static ConnectionType DB2 = new ConnectionType("DB2");
        private String DBName = "";

        public String getDBName() {
            return this.DBName;
        }

        public ConnectionType() {
            //
        }

        public ConnectionType(String _DBName) {
            this.DBName = _DBName;
        }
    }

    //<static part>
    public ConnectionType getType() {
        return s_connectionType;
    }
    protected /*static*/ ConnectionType s_connectionType;

    public static byte getNumericConnectionType() {
        byte bt = -1;
        try {
            if (ApplicationConfigurator.DATABASE_CHANGE) {
                /* 
                 * Gestione multi-db
                 * Abilitato il meccanismo di cambio runtime del dababase 
                 * di utilizzo del "Sistema della sicurezza".
                 * 
                 */
                bt = ((Byte) (new InitialContext()).lookup
                        ("java:comp/env/DatabaseType_" + ApplicationConfigurator.getDatabase())).byteValue();
            } else {
                // Gestione Standard 
                bt = ((Byte) (new InitialContext()).lookup
                        ("java:comp/env/DatabaseType")).byteValue();
            }
        } catch (NamingException NE) {
            NE.printStackTrace();
            throw new EJBException(NE);
        } finally {
            return bt;
        }
    }

    public static ConnectionType getConnectionType() {
        try {
            byte bt = getNumericConnectionType();
            switch (bt) {
                case 0:
                    return ConnectionType.POSTGRE;
                case 1:
                    return ConnectionType.ORACLE;
                case 2:
                    return ConnectionType.MYSQL;
                case 3:
                    return ConnectionType.DB2;

                default:
                    throw new Exception("Wrong [DatabaseType] settings");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }

    }

    protected /*static*/ void InitializeJNDI() {
        s_connectionType = getConnectionType();
    }
    //</static part>
    protected Connection m_con;
    protected java.util.Vector m_objects = new java.util.Vector();

    protected String parseSql(String strSql) throws SQLException {
        if (isOracle()) {
            // return Replace(strSql.toUpperCase(), " AS ", " ");
            return strSql;
        }
        if (isMySql()) {
            return Replace(strSql, "\"", "`");
        }
        if (isDB2()) {
            //
        }
        return strSql;
    }

    protected void trace(String str) {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("HH:mm:ss:SS");
        String s = sdf.format(new java.util.Date());
        if (s.length() == 11) {
            s = s + " ";
        }
    }

    public BMPConnection(Connection con) {
        m_con = con;
        //m_connectionType=connectionType;
        InitializeJNDI();
    }

    public Connection getConnection() {
        return m_con;
    }

    public boolean IsSequential() {
        return !isMySql();
    }

    public boolean isOracle() {
        return s_connectionType == ConnectionType.ORACLE;
    }

    public boolean isMySql() {
        return s_connectionType == ConnectionType.MYSQL;
    }

    public boolean isDB2() {
        return s_connectionType == ConnectionType.DB2;
    }

    public Statement createStatement() throws SQLException {
        Statement st = m_con.createStatement();
        m_objects.add(st);
        return st;
    }

    public PreparedStatement prepareStatement(String strSql) throws SQLException {
        strSql = parseSql(strSql);
        logger.info(strSql);
        if (BMPEntityBean.TRACE_SQL) {
            trace(strSql);
        }
        PreparedStatement ps = m_con.prepareStatement(strSql);
        m_objects.add(ps);
        return ps;
    }

    public void beginTrans() {
        try {
            this.getConnection().setAutoCommit(false);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
    }

    public void commitTrans() {
        try {
            this.getConnection().commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
    }

    public void rollbackTrans() {
        try {
            this.getConnection().rollback();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
    }

    public void close() {
        if (m_con == null) {
            return;
        }
        try {
            for (int i = 0; i < m_objects.size(); i++) {
                Object obj = m_objects.elementAt(i);
                //if (obj instanceof Statement){
                ((Statement) obj).close();
                //}
            }
            m_con.close();
            m_con = null;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
    }
    //<helper>

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
    //</helper>
}//class
  //</bmp-connection-helper>

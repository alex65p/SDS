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
import java.sql.*;

public class SearchHelper {

    public StringBuffer m_strSql = new StringBuffer();
    PreparedStatement m_ps;
    int m_i;
    boolean b_Where;

    public SearchHelper(String strSql) {
        m_strSql.append(strSql);
    }

    public void add(Long value, String strKey) {
        if (value != null) {
            m_strSql.append(" AND " + strKey + "=? ");
        }
    }

    public void add(java.sql.Date value, String strKey) {
        if (value != null) {
            m_strSql.append(" AND " + strKey + "=? ");
        }
    }

    public void add(String value, String strKey) {
        if (value != null) {
            m_strSql.append(" AND UPPER(" + strKey + ") LIKE ?");
        }
    }

    public void addW(Long value, String strKey) {
        if (value == null) {
            return;
        }
        if (!b_Where) {
            m_strSql.append(" WHERE " + strKey + "=? ");
            b_Where = true;
        } else {
            add(value, strKey);
        }
    }

    public void addW(java.sql.Date value, String strKey) {
        if (value == null) {
            return;
        }
        if (!b_Where) {
            m_strSql.append(" WHERE " + strKey + "=? ");
            b_Where = true;
        } else {
            add(value, strKey);
        }
    }

    public void addW(String value, String strKey) {
        if (value == null) {
            return;
        }
        if (!b_Where) {
            m_strSql.append(" WHERE UPPER(" + strKey + ") LIKE ?");
            b_Where = true;
        } else {
            add(value, strKey);
        }
    }

    public void orderBy(int iOrderBy) {
        m_strSql.append(" ORDER BY " + Math.abs(iOrderBy)
                + (iOrderBy > 0 ? " ASC" : "DESC"));
    }

    public void orderBy(String orderBy) {
        m_strSql.append(
                (orderBy != null && orderBy.trim().equals("") == false)
                ? " ORDER BY " + orderBy
                : "");
    }

    /*
    public String order(int iOrderBy){
    return (Math.abs(iOrderBy) + (iOrderBy>0?" ASC": "DESC") );
    }
     */
    public String toString() {
        return m_strSql.toString();
    }

    public void startBind(PreparedStatement ps, int i) {
        m_i = i;
        m_ps = ps;
    }

    public void bind(String value) throws SQLException {
        if (value != null) {
            m_ps.setString(m_i++, value);
        }
    }

    public void bind(Long value) throws SQLException {
        if (value != null) {
            m_ps.setLong(m_i++, value.longValue());
        }
    }

    public void bind(java.sql.Date value) throws SQLException {
        if (value != null) {
            m_ps.setDate(m_i++, value);
        }
    }
}

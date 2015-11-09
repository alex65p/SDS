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

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package s2s.luna.util;

import java.rmi.RemoteException;
import java.sql.ResultSet;
import javax.ejb.EJBException;
import javax.ejb.RemoveException;
import s2s.ejb.pseudoejb.BMPEntityBean;
import java.sql.SQLException;
import s2s.ejb.pseudoejb.BMPConnection;

/**
 *
 * @author Dario
 */
public class DBInfo extends BMPEntityBean{

    public void ejbRemove() throws RemoveException, EJBException, RemoteException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public void ejbActivate() throws EJBException, RemoteException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public void ejbPassivate() throws EJBException, RemoteException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public void ejbLoad() throws EJBException, RemoteException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public void ejbStore() throws EJBException, RemoteException {
        throw new UnsupportedOperationException("Not supported yet.");
    }
    
    public String getDatabaseProductName() {
        BMPConnection bmp = null;
        String Return = "N/A";
        try {
            bmp = getConnection();
            Return = bmp.getConnection().getMetaData().getDatabaseProductName();
        } catch (SQLException E){
            //
        } finally {
            if (bmp != null){
                bmp.close();
            }
            return Return;
        }
    }
    
    public String getDatabaseProductVersion() {
        BMPConnection bmp = null;
        String Return = "N/A";
        try {
            bmp = getConnection();
            Return = bmp.getConnection().getMetaData().getDatabaseProductVersion();
        } catch (SQLException E){
            //
        } finally {
            if (bmp != null){
                bmp.close();
            }
            return Return;
        }
    }
    
    public String getUserName() {
        BMPConnection bmp = null;
        String Return = "N/A";
        try {
            bmp = getConnection();
            Return = bmp.getConnection().getMetaData().getUserName();
        } catch (SQLException E){
            //
        } finally {
            if (bmp != null){
                bmp.close();
            }
            return Return;
        }
    }
    
    public String getSchemaName() {
        BMPConnection bmp = null;
        String Return = "N/A";
        try {
            bmp = getConnection();
            ResultSet rs = bmp.getConnection().getMetaData()
                    .getTables(null,null,"ana_dpd_tab",null);
            while (rs.next()){
                Return = rs.getString("TABLE_SCHEM");
                break;
            }
        } catch (SQLException E){
            //
        } finally {
            if (bmp != null){
                bmp.close();
            }
            return Return;
        }
    }
    
    public String getURL() {
        BMPConnection bmp = null;
        String Return = "N/A";
        try {
            bmp = getConnection();
            Return = bmp.getConnection().getMetaData().getURL();
        } catch (SQLException E){
            //
        } finally {
            if (bmp != null){
                bmp.close();
            }
            return Return;
        }
    }

}

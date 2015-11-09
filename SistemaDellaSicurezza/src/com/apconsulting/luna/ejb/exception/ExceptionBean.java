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
package com.apconsulting.luna.ejb.exception;

import java.rmi.RemoteException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.FinderException;
import javax.ejb.NoSuchEntityException;
import javax.ejb.RemoveException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;

/**
 *
 * @author Pierpaolo
 */
public class ExceptionBean extends BMPEntityBean implements IException, IExceptionHome {

    private String FK_NAME;
    private String FK_DESC;
    
    
    private static ExceptionBean ys = null;

////////////////////// CONSTRUCTOR///////////////////
        private ExceptionBean() {
            //System.err.println("FornitoreBean constructor<br>");
        }


 public static ExceptionBean getInstance() {
        if (ys == null) {
            ys = new ExceptionBean();
        }
        return ys;
    }

    public void ejbRemove() throws RemoveException, EJBException, RemoteException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public void ejbActivate() throws EJBException, RemoteException {
        this.FK_NAME = ((String) this.getEntityKey()).toString();
    }

    public void ejbPassivate() throws EJBException, RemoteException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public void ejbLoad() throws EJBException, RemoteException {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ANA_FK_TAB WHERE lower(CONSTRAINT_NAME)=?");
            ps.setString(1, FK_NAME.toLowerCase());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.FK_NAME = rs.getString("CONSTRAINT_NAME");
                this.FK_DESC = rs.getString("CONSTRAINT_DES");

            } else {
                throw new NoSuchEntityException("Record non trovato");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbStore() throws EJBException, RemoteException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public IException create() throws RemoteException, CreateException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public IException findByPrimaryKey(String primaryKey) throws RemoteException, FinderException {
        ExceptionBean bean = new ExceptionBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public Collection findAll() throws RemoteException, FinderException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public Collection findEx() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public String getFK_NAME() {
        if (FK_NAME == null) {
                return "";
            }
            return FK_NAME;
    }

    public String getFK_DESC() {
        if (FK_DESC == null) {
                return "";
            }
            return FK_DESC;
    }
}

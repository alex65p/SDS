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

package com.apconsulting.luna.ejb.AssociazioneMansioniSAP_S2S;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import javax.ejb.EJBException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;

/**
 *
 * @author Alessandro
 */
public class AssociazioneMansioniSAP_S2SBean extends BMPEntityBean implements AssociazioneMansioniSAP_S2SHome, IAssociazioneMansioniSAP_S2S {
//  Campi del bean
    String NOM_STA;
    long COD_STA;
    long COD_LNG;

// Costruttore
private static AssociazioneMansioniSAP_S2SBean ys = null;

    private AssociazioneMansioniSAP_S2SBean() {
    }

    public static AssociazioneMansioniSAP_S2SBean getInstance() {
        if (ys == null) {
            ys = new AssociazioneMansioniSAP_S2SBean();
        }
        return ys;
    }
// Metodi bean (Create, FindAll, Remove, ecc.)

// Metodi di business

    public Collection getUO_Mansioni_S2S_View(long COD_AZL) {
        return (new  AssociazioneMansioniSAP_S2SBean()).ejbGetUO_Mansioni_S2S_View(COD_AZL);
    }

    public Collection getDipendenti_Mansioni_SAP_View(long COD_AZL) {
        return (new  AssociazioneMansioniSAP_S2SBean()).ejbGetDipendenti_Mansioni_SAP_View(COD_AZL);
    }

    public long getDipendenti_Mansioni_SAP_Count(long COD_AZL) {
        return (new  AssociazioneMansioniSAP_S2SBean()).ejbGetDipendenti_Mansioni_SAP_Count(COD_AZL);
    }

    public int AggiornaAssociazioneSAP_S2S(long ID, long COD_UNI_ORG, long COD_MAN) {
        return (new  AssociazioneMansioniSAP_S2SBean()).ejbAggiornaAssociazioneSAP_S2S(ID, COD_UNI_ORG, COD_MAN);
    }

// Implementazione di: get, set, metodi bean, metodi di business

    public void ejbStore() {
        BMPConnection bmp=getConnection();
        try{
        } catch(Exception ex){
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally{bmp.close();}
    }

    public void ejbLoad(){
        BMPConnection bmp=getConnection();
        try{
        } catch(Exception ex){
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally{bmp.close();}
    }

    public void ejbPassivate(){
    }

    public void ejbActivate(){
    }

    public void ejbRemove(){
        BMPConnection bmp=getConnection();
        try {
        } catch(Exception ex){
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally{bmp.close();
        }
    }

    public Collection ejbGetUO_Mansioni_S2S_View(long COD_AZL){
        BMPConnection bmp=getConnection();
        try{
            PreparedStatement ps=bmp.prepareStatement(
                "SELECT " +
                    "UO_MAN.COD_UNI_ORG, " +
                    "UO.NOM_UNI_ORG, " +
                    "UO_MAN.COD_MAN, " +
                    "MAN.NOM_MAN " +
                "FROM " +
                    "MAN_UNI_ORG_TAB UO_MAN, " +
                    "ANA_UNI_ORG_TAB UO, " +
                    "ANA_MAN_TAB MAN " +
                "WHERE " +
                    "UO_MAN.COD_UNI_ORG=UO.COD_UNI_ORG " +
                    "AND UO_MAN.COD_MAN = MAN.COD_MAN " +
                    "AND UO.COD_AZL=? " +
                    "AND MAN.COD_AZL=? " +
                "ORDER BY " +
                    "UO.NOM_UNI_ORG, " +
                    "MAN.NOM_MAN ");
            ps.setLong  (1, COD_AZL);
            ps.setLong  (2, COD_AZL);
            ResultSet rs=ps.executeQuery();
            java.util.ArrayList al=new java.util.ArrayList();
            while(rs.next()){
                UO_Mansioni_S2S_View obj=new UO_Mansioni_S2S_View();
                obj.COD_UNI_ORG=rs.getLong("COD_UNI_ORG");
                obj.NOM_UNI_ORG=rs.getString("NOM_UNI_ORG");
                obj.COD_MAN=rs.getLong("COD_MAN");
                obj.NOM_MAN=rs.getString("NOM_MAN");
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch(Exception ex){
            throw new EJBException(ex);
        } finally{bmp.close();}
    }

    public Collection ejbGetDipendenti_Mansioni_SAP_View(long COD_AZL){
        BMPConnection bmp=getConnection();
        try{
            PreparedStatement ps=bmp.prepareStatement(
                "SELECT " +
                    "MAN_SAP.ID, " +
                    "MAN_SAP.COD_AZL_S2S, " +
                    "MAN_SAP.COD_DPD_S2S, " +
                    "DPD.COG_DPD, " +
                    "DPD.NOM_DPD, " +
                    "MAN_SAP.COD_UNI_ORG_SAP, " +
                    "MAN_SAP.COD_MAN_SAP, " +
                    "MAN_SAP.COD_POS_SAP, " +
                    "MAN_SAP.DES_UNI_ORG_SAP, " +
                    "MAN_SAP.DES_MAN_SAP, " +
                    "MAN_SAP.DES_POS_SAP, " +
                    "MAN_SAP.COD_UNI_ORG_SAP_DAT_INI, " +
                    "MAN_SAP.COD_UNI_ORG_SAP_DAT_FIN, " +
                    "MAN_SAP.COD_MAN_SAP_DAT_INI, " +
                    "MAN_SAP.COD_MAN_SAP_DAT_FIN, " +
                    "MAN_SAP.COD_POS_SAP_DAT_INI, " +
                    "MAN_SAP.COD_POS_SAP_DAT_FIN, " +
                    "MAN_SAP.DES_LUO_FSC_S2S " +
                "FROM " +
                    "ASS_MAN_UO_SAP_S2S_TAB MAN_SAP, " +
                    "ANA_DPD_TAB DPD " +
                "WHERE " +
                    "MAN_SAP.COD_DPD_S2S = DPD.COD_DPD " +
                    "AND MAN_SAP.COD_AZL_S2S = DPD.COD_AZL " +
                    "AND MAN_SAP.COD_AZL_S2S = ? " +
                    "AND MAN_SAP.COD_UNI_ORG_S2S = 0 " +
                    "AND MAN_SAP.COD_MAN_S2S = 0 " +
                "ORDER BY " +
                    "DPD.COG_DPD, " +
                    "DPD.NOM_DPD, " +
                    "MAN_SAP.COD_UNI_ORG_SAP_DAT_INI, " +
                    "MAN_SAP.COD_MAN_SAP_DAT_INI, " +
                    "MAN_SAP.COD_POS_SAP_DAT_INI");
            ps.setLong  (1, COD_AZL);
            ResultSet rs=ps.executeQuery();
            java.util.ArrayList al=new java.util.ArrayList();
            while(rs.next()){
                Dipendenti_Mansioni_SAP_View obj=new Dipendenti_Mansioni_SAP_View();
                obj.ID = rs.getLong("ID");
                obj.COD_AZL_S2S = rs.getLong("COD_AZL_S2S");
                obj.COD_DPD_S2S = rs.getLong("COD_DPD_S2S");
                obj.COG_DPD = rs.getString("COG_DPD");
                obj.NOM_DPD = rs.getString("NOM_DPD");
                obj.COD_UNI_ORG_SAP = rs.getString("COD_UNI_ORG_SAP");
                obj.COD_MAN_SAP = rs.getString("COD_MAN_SAP");
                obj.COD_POS_SAP = rs.getString("COD_POS_SAP");
                obj.DES_UNI_ORG_SAP = rs.getString("DES_UNI_ORG_SAP");
                obj.DES_MAN_SAP = rs.getString("DES_MAN_SAP");
                obj.DES_POS_SAP = rs.getString("DES_POS_SAP");
                obj.COD_UNI_ORG_SAP_DAT_INI = rs.getDate("COD_UNI_ORG_SAP_DAT_INI");
                obj.COD_UNI_ORG_SAP_DAT_FIN = rs.getDate("COD_UNI_ORG_SAP_DAT_FIN");
                obj.COD_MAN_SAP_DAT_INI = rs.getDate("COD_MAN_SAP_DAT_INI");
                obj.COD_MAN_SAP_DAT_FIN = rs.getDate("COD_MAN_SAP_DAT_FIN");
                obj.COD_POS_SAP_DAT_INI = rs.getDate("COD_POS_SAP_DAT_INI");
                obj.COD_POS_SAP_DAT_FIN = rs.getDate("COD_POS_SAP_DAT_FIN");
                obj.DES_LUO_FSC_S2S = rs.getString("DES_LUO_FSC_S2S");
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch(Exception ex){
            throw new EJBException(ex);
        } finally{bmp.close();}
    }

    public long ejbGetDipendenti_Mansioni_SAP_Count(long COD_AZL){
        BMPConnection bmp=getConnection();
        try{
            PreparedStatement ps=bmp.prepareStatement(
                "SELECT " +
                    "COUNT(ID) AS ASS_MAN_SAP_S2S_COUNT " +
                "FROM " +
                    "ASS_MAN_UO_SAP_S2S_TAB " +
                "WHERE " +
                    "COD_AZL_S2S = ? " +
                    "AND COD_UNI_ORG_S2S = 0 " +
                    "AND COD_MAN_S2S = 0 ");
            ps.setLong(1, COD_AZL);
            ResultSet rs=ps.executeQuery();
            rs.next();
            return rs.getLong("ASS_MAN_SAP_S2S_COUNT");
        } catch(Exception ex){
            throw new EJBException(ex);
        } finally{bmp.close();}
    }

    public int ejbAggiornaAssociazioneSAP_S2S(long ID, long COD_UNI_ORG, long COD_MAN){
        BMPConnection bmp=getConnection();
        try{
            PreparedStatement ps=bmp.prepareStatement(
                "UPDATE " +
                    "ASS_MAN_UO_SAP_S2S_TAB " +
                "SET " +
                    "COD_UNI_ORG_S2S = ?, " +
                    "COD_MAN_S2S = ? " +
                "WHERE " +
                    "ID = ?");
            ps.setLong  (1, COD_UNI_ORG);
            ps.setLong  (2, COD_MAN);
            ps.setLong  (3, ID);
            int rowAffected = ps.executeUpdate();
            bmp.close();
            return rowAffected;
        } catch(Exception ex){
            throw new EJBException(ex);
        } finally{bmp.close();}
    }

// fine implementazione
}


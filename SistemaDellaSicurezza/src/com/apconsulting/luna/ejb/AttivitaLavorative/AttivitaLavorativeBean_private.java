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
package com.apconsulting.luna.ejb.AttivitaLavorative;

import java.rmi.RemoteException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Iterator;
import javax.ejb.EJBException;
import javax.ejb.RemoveException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.conf.ModuleManager.MODULES;

/**
 *
 * @author Dario
 */
class AttivitaLavorativeBean_private extends BMPEntityBean {

    //--------------
    String addExtendedRischioAssociations(long lCOD_RSO, long lCOD_AZL, BMPConnection bmp, long lCOD_MAN) {
        String res = " COCO ";
        ResultSet REC_CUR, REC_MIS_PET, REC_PRO_SAN, REC_DPI, REC_COR;
        //-----------
        java.util.Date dt = new java.util.Date();
        java.sql.Date CUR_DAT = new java.sql.Date(dt.getTime());
        long lCUR_DATE = CUR_DAT.getTime();
        java.sql.Date SUM_DAT = new java.sql.Date(0L);
        //++++++++++++++++++++++++++++++++++++++++++++++
        try {
            //---------------REC_CUR------------------
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    " cod_rso,		" +
                    " nom_ril_rso, 	" +
                    " clf_rso, 		" +
                    " prb_eve_les, 	" +
                    " ent_dan, 		" +
                    " stm_num_rso, 	" +
                    " rfc_vlu_rso_mes, " +
                    " frq_rip_att_dan, " +
                    " num_inc_inf " +
                    "FROM ana_rso_tab where cod_rso= ? AND cod_azl=? " +
                    "and cod_rso not in (select cod_rso from rso_man_tab where cod_rso=? and cod_man=? and cod_azl=?)");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ps.setLong(3, lCOD_RSO);
            ps.setLong(4, lCOD_MAN);
            ps.setLong(5, lCOD_AZL);
            //--------------------------
            REC_CUR = ps.executeQuery();
            //--------------------------------------------------
            // Main Loop
            long INC = 1;
            long CODICE_MAN_RSO;
            long INC_MIS_PET = 1;
            long NEW_MIS_PET_MAN_ID;
            //

            res += "<br>NOM:" + new Long(REC_CUR.getRow()).toString();

            while (REC_CUR.next()) {
                res += "CICLE: " + new Long(INC).toString() + " " + new Long(REC_CUR.getLong(1)).toString();
                //-------------------
                CODICE_MAN_RSO = NEW_ID();
                //res+="<br>CICLE: " + new Long(CODICE_MAN_RSO).toString();
                PreparedStatement ps_rso_man_ins = bmp.prepareStatement(
                        "INSERT INTO rso_man_tab (" +
                        "cod_rso_man, " +
                        "cod_rso, " +
                        "cod_azl, " +
                        "dat_inz, " +
                        "prs_rso, " +
                        "nom_ril_rso, " +
                        "clf_rso, " +
                        "prb_eve_les, " +
                        "ent_dan, " +
                        "stm_num_rso, " +
                        "sta_rso, " +
                        "cod_man, " +
                        "dat_rfc_vlu_rso, " +
                        "frq_rip_att_dan, " +
                        "num_inc_inf) VALUES " +
                        "( ?, ?, ?, ?, 'S', ?, 'PER OPERATORE', ?, ?, ?, 'V', ?, ?, ?, ? )");
                ps_rso_man_ins.setLong(1, CODICE_MAN_RSO);
                ps_rso_man_ins.setLong(2, REC_CUR.getLong(1));
                ps_rso_man_ins.setLong(3, lCOD_AZL);
                ps_rso_man_ins.setDate(4, CUR_DAT);
                ps_rso_man_ins.setString(5, REC_CUR.getString(2));
                ps_rso_man_ins.setLong(6, REC_CUR.getLong(4));
                ps_rso_man_ins.setLong(7, REC_CUR.getLong(5));
                ps_rso_man_ins.setLong(8, REC_CUR.getLong(6));
                ps_rso_man_ins.setLong(9, lCOD_MAN);

                //---
                java.sql.Date S_DAT = new java.sql.Date(lCUR_DATE);
                S_DAT.setMonth(CUR_DAT.getMonth() + REC_CUR.getInt(7));
                ps_rso_man_ins.setDate(10, S_DAT);

                ps_rso_man_ins.setLong(11, REC_CUR.getLong(8));
                ps_rso_man_ins.setLong(12, REC_CUR.getLong(9));

                // execute insert of RSO_MAN
                ps_rso_man_ins.executeUpdate();
                SUM_DAT.setTime(0L);
                //========================MIS_PET_MAN===============================
                PreparedStatement ps_mis_pet = bmp.prepareStatement(
                        "SELECT " +
                        "a.cod_mis_pet, " +
                        "a.ver_mis_pet, " +
                        "a.per_mis_pet, " +
                        "a.pnz_mis_pet_mes, " +
                        "a.dat_pnz_mis_pet, " +
                        "a.tpl_dsi_mis_pet, " +
                        "a.dsi_azl_mis_pet, " +
                        "a.cod_tpl_mis_pet  " +
                        "FROM ana_mis_pet_tab a, rso_mis_pet_tab b where b.cod_rso= ? " +
                        "AND a.cod_mis_pet = b.cod_mis_pet " +
                        "AND b.cod_azl = ? ");
                ps_mis_pet.setLong(1, REC_CUR.getLong(1));
                ps_mis_pet.setLong(2, lCOD_AZL);
                res += "<br>get misure preventive";
                REC_MIS_PET = ps_mis_pet.executeQuery();
                // loop of mis_pet

                while (REC_MIS_PET.next()) {
                    PreparedStatement ps_mis_pet_ins = bmp.prepareStatement(
                            "INSERT INTO mis_pet_man_tab ( " +
                            "cod_mis_pet_man, " +
                            "cod_mis_pet, " +
                            "dat_inz, " +
                            "prs_mis_pet, " +
                            "ver_mis_pet, " +
                            "adt_mis_pet, " +
                            "per_mis_pet, " +
                            "pnz_mis_pet_mes, " +
                            "dat_pnz_mis_pet, " +
                            "tpl_dsi_mis_pet, " +
                            "dsi_azl_mis_pet, " +
                            "sta_mis_pet, " +
                            "cod_rso_man, " +
                            "cod_man, " +
                            "cod_tpl_mis_pet) " +
                            "VALUES ( ?, ?, ?, 'S', ?, 'N', ?, ?, ?, ?, ?, 'A', ?, ?, ?) ");
                    // execute insert of MIS_PET_MAN
                    NEW_MIS_PET_MAN_ID = NEW_ID();

                    ps_mis_pet_ins.setLong(1, NEW_MIS_PET_MAN_ID);
                    ps_mis_pet_ins.setLong(2, REC_MIS_PET.getLong(1));
                    ps_mis_pet_ins.setDate(3, CUR_DAT);
                    ps_mis_pet_ins.setLong(4, REC_MIS_PET.getLong(2));
                    //?--
                    if (REC_MIS_PET.getString(3) != null) {
                        ps_mis_pet_ins.setString(5, REC_MIS_PET.getString(3));
                    } else {
                        ps_mis_pet_ins.setString(5, "S");
                    }
                    //
                    ps_mis_pet_ins.setLong(6, REC_MIS_PET.getLong(4));
                    //
                    if (REC_MIS_PET.getDate(5) != null) {
                        ps_mis_pet_ins.setDate(7, REC_MIS_PET.getDate(5));
                    } else {
                        ps_mis_pet_ins.setDate(7, CUR_DAT);
                    }
                    //
                    if (REC_MIS_PET.getString(6) != null) {
                        ps_mis_pet_ins.setString(8, REC_MIS_PET.getString(6));
                    } else {
                        ps_mis_pet_ins.setString(8, "T");
                    }
                    //?--
                    ps_mis_pet_ins.setString(9, REC_MIS_PET.getString(7));
                    ps_mis_pet_ins.setLong(10, CODICE_MAN_RSO);
                    ps_mis_pet_ins.setLong(11, lCOD_MAN);
                    ps_mis_pet_ins.setLong(12, REC_MIS_PET.getLong(8));
                    res += "<br>NEW_MIS_PET_MAN_ID - " + NEW_MIS_PET_MAN_ID + ", INC_MIS_PET - " + INC_MIS_PET;
                    ps_mis_pet_ins.executeUpdate();
                    INC_MIS_PET++;
                }// end of mis_pet loop
                REC_MIS_PET.close();
                //======================PRO_SAN_MAN=====================================
                if ((ApplicationConfigurator.isModuleEnabled(MODULES.PRO_SAN_4_ATT_LAV) == false)){
                PreparedStatement ps_pro_san = bmp.prepareStatement(
                        "SELECT a.cod_pro_san " +
                        "FROM pro_san_rso_tab a WHERE a.cod_rso = ? AND a.cod_azl = ?");
                ps_pro_san.setLong(1, REC_CUR.getLong(1));
                ps_pro_san.setLong(2, lCOD_AZL);
                REC_PRO_SAN = ps_pro_san.executeQuery();
                while (REC_PRO_SAN.next()) {
                    PreparedStatement ps_pro_san_ins;
                    ps_pro_san_ins = bmp.prepareStatement("select * from pro_san_man_tab where cod_pro_san=? and cod_man=?");
                    ps_pro_san_ins.setLong(1, REC_PRO_SAN.getLong(1));
                    ps_pro_san_ins.setLong(2, lCOD_MAN);
                    ResultSet rs_test = ps_pro_san_ins.executeQuery();
                    if (rs_test.next()) {
                        continue;
                    }
                    //-------------------
                    ps_pro_san_ins = bmp.prepareStatement(
                            "INSERT INTO pro_san_man_tab " +
                            "(cod_pro_san, cod_man, prs_pro_san, dat_inz)" +
                            "VALUES ( ?, ?, 'S', ?)");
                    ps_pro_san_ins.setLong(1, REC_PRO_SAN.getLong(1));
                    ps_pro_san_ins.setLong(2, lCOD_MAN);
                    ps_pro_san_ins.setDate(3, CUR_DAT);
                    ps_pro_san_ins.executeUpdate();
                }
                REC_PRO_SAN.close();}
                //======================DPI_MAN=====================================
                if ((ApplicationConfigurator.isModuleEnabled(MODULES.DPI_4_ATT_LAV) == false)){
                PreparedStatement ps_dpi = bmp.prepareStatement(
                        "SELECT a.cod_tpl_dpi " +
                        "FROM dpi_rso_tab a WHERE a.cod_rso = ? AND a.cod_azl = ? ");
                ps_dpi.setLong(1, REC_CUR.getLong(1));
                ps_dpi.setLong(2, lCOD_AZL);
                REC_DPI = ps_dpi.executeQuery();
                while (REC_DPI.next()) {
                    PreparedStatement ps_dpi_ins;
                    ps_dpi_ins = bmp.prepareStatement("select * from dpi_man_tab where cod_tpl_dpi=? and cod_man=?");
                    ps_dpi_ins.setLong(1, REC_DPI.getLong(1));
                    ps_dpi_ins.setLong(2, lCOD_MAN);
                    ResultSet rs_test = ps_dpi_ins.executeQuery();
                    if (rs_test.next()) {
                        continue;
                    }
                    //-----------------
                    ps_dpi_ins = bmp.prepareStatement(
                            "INSERT INTO dpi_man_tab " +
                            "(cod_tpl_dpi, cod_man, prs_dpi, dat_inz) VALUES (?, ?, 'S', ?)");
                    ps_dpi_ins.setLong(1, REC_DPI.getLong(1));
                    ps_dpi_ins.setLong(2, lCOD_MAN);
                    ps_dpi_ins.setDate(3, CUR_DAT);
                    ps_dpi_ins.executeUpdate();
                }
                REC_DPI.close();}
                //======================COR_MAN=====================================
                if ((ApplicationConfigurator.isModuleEnabled(MODULES.CORSI_4_ATT_LAV) == false)){
                PreparedStatement ps_cor = bmp.prepareStatement(
                        "SELECT a.cod_cor " +
                        "FROM cor_rso_tab a WHERE a.cod_rso = ? AND a.cod_azl = ?");
                ps_cor.setLong(1, REC_CUR.getLong(1));
                ps_cor.setLong(2, lCOD_AZL);
                REC_COR = ps_cor.executeQuery();
                while (REC_COR.next()) {
                    PreparedStatement ps_cor_ins;
                    ps_cor_ins = bmp.prepareStatement(
                            "select * from cor_man_tab where cod_cor=? and cod_man=?");
                    ps_cor_ins.setLong(1, REC_COR.getLong(1));
                    ps_cor_ins.setLong(2, lCOD_MAN);
                    ResultSet rs_test = ps_cor_ins.executeQuery();
                    if (rs_test.next()) {
                        continue;
                    }
                    //------------------------------------
                    ps_cor_ins = bmp.prepareStatement(
                            "INSERT INTO cor_man_tab " +
                            "(cod_cor, cod_man, prs_cor, dat_inz) VALUES (?, ?, 'S', ?)");
                    ps_cor_ins.setLong(1, REC_COR.getLong(1));
                    ps_cor_ins.setLong(2, lCOD_MAN);
                    ps_cor_ins.setDate(3, CUR_DAT);
                    ps_cor_ins.executeUpdate();
                }
                REC_COR.close();}
                //=================================================================
			/*===============================
                === main loop finalization === */
                INC++;
            }// /main loop
            //+++ main block finalization +++
            REC_CUR.close();
        //++++++++++++++++++++++++++++++++++++++++++++++
        } catch (Exception ex) {
            StackTraceElement[] trace = ex.getStackTrace();
            res += "<hr>";
            for (int i = 0; i < trace.length; i++) {
                res += "<br>" + trace[i].toString();
            }
            res += "<br>" + ex.toString() + "end of attivita lavorative associations...FAILED";
        }
        return res += "end of attivita lavorative associations...OK";
    //-----------------------------------
    }
    //</alex_romas>

    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    int addOperazioneSvolteAssociations(long COD_OPE_SVO, long COD_RSO, long COD_AZL, long COD_MAN) {
        int result = 1;
        BMPConnection bmp = getConnection();
        Connection conn = bmp.getConnection();
        ResultSet REC_CUR, REC_MIS_PET, REC_PRO_SAN, REC_DPI, REC_COR;
        //---
        java.util.Date dt = new java.util.Date();
        java.sql.Date CUR_DAT = new java.sql.Date(dt.getTime());
        long lCUR_DATE = CUR_DAT.getTime();
        java.sql.Date SUM_DAT = new java.sql.Date(0L);
        //++++++++++++++++++++++++++++++++++++++++++++++
        try {
            conn.setAutoCommit(false);
            //---------------REC_CUR------------------
            PreparedStatement ps = null;
            if (COD_OPE_SVO != 0) {
                ps = bmp.prepareStatement(
                        "SELECT " +
                        "a.cod_rso, " +
                        "b.nom_ril_rso, " +
                        "b.clf_rso, " +
                        "b.prb_eve_les, " +
                        "b.ent_dan, " +
                        "b.stm_num_rso, " +
                        "b.rfc_vlu_rso_mes " +
                        "FROM rso_ope_svo_tab a, ana_rso_tab b " +
                        "WHERE a.cod_rso= b.cod_rso " +
                        "AND a.cod_azl= b.cod_azl " +
                        "AND a.cod_ope_svo = ?  ");
                ps.setLong(1, COD_OPE_SVO);
            }
            if (COD_RSO != 0) {
                ps = bmp.prepareStatement(
                        "SELECT " +
                        " cod_rso, " +
                        " nom_ril_rso, " +
                        " clf_rso, " +
                        " prb_eve_les, " +
                        " ent_dan, " +
                        " stm_num_rso, " +
                        " rfc_vlu_rso_mes " +
                        "FROM ana_rso_tab where cod_rso= ? AND cod_azl=? ");
                ps.setLong(1, COD_RSO);
                ps.setLong(2, COD_RSO);
                ps.setLong(3, COD_MAN);
                ps.setLong(4, COD_AZL);
            }
            //--------------------------
            REC_CUR = ps.executeQuery();
            //--------------------------
            // Main Loop
            int INC = 1;
            long CODICE_MAN_RSO;
            while (REC_CUR.next()) {
                //---------------------------------------------------------------
                PreparedStatement ps_rso_man_ins = bmp.prepareStatement(
                        "SELECT COD_RSO FROM RSO_MAN_TAB WHERE COD_RSO=? AND COD_MAN=?");
                ps_rso_man_ins.setLong(1, REC_CUR.getLong(1));
                ps_rso_man_ins.setLong(2, COD_MAN);
                ResultSet rs_test = ps_rso_man_ins.executeQuery();
                if (rs_test.next()) {
                    continue;
                }
                //----------------------------------------------------------------
                CODICE_MAN_RSO = NEW_ID() + INC;
                //
                ps_rso_man_ins = bmp.prepareStatement(
                        "INSERT INTO rso_man_tab (" +
                        "cod_rso_man, " +
                        "cod_rso, " +
                        "cod_azl, " +
                        "dat_inz, " +
                        "prs_rso, " +
                        "nom_ril_rso, " +
                        "clf_rso, " +
                        "prb_eve_les, " +
                        "ent_dan, " +
                        "stm_num_rso, " +
                        "sta_rso, " +
                        "cod_man, " +
                        "dat_rfc_vlu_rso ) VALUES " +
                        "( ?, ?, ?, ?, 'S', ?, 'PER OPERATORE', ?, ?, ?, 'V', ?, ? )");
                ps_rso_man_ins.setLong(1, CODICE_MAN_RSO);
                ps_rso_man_ins.setLong(2, REC_CUR.getLong(1));
                ps_rso_man_ins.setLong(3, COD_AZL);
                ps_rso_man_ins.setDate(4, CUR_DAT);
                ps_rso_man_ins.setString(5, REC_CUR.getString(2));
                ps_rso_man_ins.setLong(6, REC_CUR.getLong(4));
                ps_rso_man_ins.setLong(7, REC_CUR.getLong(5));
                ps_rso_man_ins.setLong(8, REC_CUR.getLong(6));
                ps_rso_man_ins.setLong(9, COD_MAN);
                //---
                java.sql.Date S_DAT = new java.sql.Date(lCUR_DATE);
                S_DAT.setMonth(CUR_DAT.getMonth() + REC_CUR.getInt(7));
                ps_rso_man_ins.setDate(10, S_DAT);
                // execute insert of RSO_MAN
                ps_rso_man_ins.executeUpdate();
                //========================MIS_PET_MAN===============================
                PreparedStatement ps_mis_pet = bmp.prepareStatement(
                        "SELECT " +
                        "a.cod_mis_pet, " +
                        "a.ver_mis_pet, " +
                        "a.per_mis_pet, " +
                        "a.pnz_mis_pet_mes, " +
                        "a.dat_pnz_mis_pet, " +
                        "a.tpl_dsi_mis_pet, " +
                        "a.dsi_azl_mis_pet, " +
                        "a.cod_tpl_mis_pet  " +
                        "FROM ana_mis_pet_tab a, rso_mis_pet_tab b where b.cod_rso= ? " +
                        "AND a.cod_mis_pet = b.cod_mis_pet " +
                        "AND a.cod_azl = ? ");
                ps_mis_pet.setLong(1, REC_CUR.getLong(1));
                ps_mis_pet.setLong(2, COD_AZL);
                REC_MIS_PET = ps_mis_pet.executeQuery();
                // loop of mis_pet
                int INC_MIS_PET = 1;

                while (REC_MIS_PET.next()) {
                    PreparedStatement ps_mis_pet_ins = bmp.prepareStatement(
                            "INSERT INTO mis_pet_man_tab ( " +
                            "cod_mis_pet_man, " +
                            "cod_mis_pet, " +
                            "dat_inz, " +
                            "prs_mis_pet, " +
                            "ver_mis_pet, " +
                            "adt_mis_pet, " +
                            "per_mis_pet, " +
                            "pnz_mis_pet_mes, " +
                            "dat_pnz_mis_pet, " +
                            "tpl_dsi_mis_pet, " +
                            "dsi_azl_mis_pet, " +
                            "sta_mis_pet, " +
                            "cod_rso_man, " +
                            "cod_man, " +
                            "cod_tpl_mis_pet) " +
                            "VALUES ( ?, ?, ?, 'S', ?, 'N', ?, ?, ?, ?, ?, 'A', ?, ?, ?) ");
                    // execute insert of MIS_PET_MAN
                    ps_mis_pet_ins.setLong(1, NEW_ID() + INC_MIS_PET);
                    ps_mis_pet_ins.setLong(2, REC_MIS_PET.getLong(1));
                    ps_mis_pet_ins.setDate(3, CUR_DAT);
                    ps_mis_pet_ins.setLong(4, REC_MIS_PET.getLong(2));
                    //?--
                    if (REC_MIS_PET.getString(3) != null) {
                        ps_mis_pet_ins.setString(5, REC_MIS_PET.getString(3));
                    } else {
                        ps_mis_pet_ins.setString(5, "S");
                    }
                    //
                    ps_mis_pet_ins.setLong(6, REC_MIS_PET.getLong(4));
                    //
                    if (REC_MIS_PET.getDate(5) != null) {
                        ps_mis_pet_ins.setDate(7, REC_MIS_PET.getDate(5));
                    } else {
                        ps_mis_pet_ins.setDate(7, CUR_DAT);
                    }
                    //
                    if (REC_MIS_PET.getString(6) != null) {
                        ps_mis_pet_ins.setString(8, REC_MIS_PET.getString(6));
                    } else {
                        ps_mis_pet_ins.setString(8, "T");
                    }
                    //?--
                    ps_mis_pet_ins.setString(9, REC_MIS_PET.getString(7));
                    ps_mis_pet_ins.setLong(10, CODICE_MAN_RSO);
                    ps_mis_pet_ins.setLong(11, COD_MAN);
                    ps_mis_pet_ins.setLong(12, REC_MIS_PET.getLong(8));
                    ps_mis_pet_ins.executeUpdate();
                    INC_MIS_PET++;
                }// end of mis_pet loop
                REC_MIS_PET.close();
                //======================PRO_SAN_MAN=====================================
                if (COD_OPE_SVO != 0) //###################################################
                {
                    PreparedStatement ps_pro_san = bmp.prepareStatement(
                            "SELECT a.cod_pro_san " +
                            "FROM pro_san_rso_tab a WHERE a.cod_rso = ? AND a.cod_azl = ?");
                    ps_pro_san.setLong(1, REC_CUR.getLong(1));
                    ps_pro_san.setLong(2, COD_AZL);
                    REC_PRO_SAN = ps_pro_san.executeQuery();
                    while (REC_PRO_SAN.next()) {
                        //---------------------------------------------------------------
                        PreparedStatement ps_pro_san_ins = bmp.prepareStatement(
                                "SELECT COD_PRO_SAN FROM PRO_SAN_MAN_TAB WHERE COD_PRO_SAN=? AND COD_MAN=?");
                        ps_pro_san_ins.setLong(1, REC_PRO_SAN.getLong(1));
                        ps_pro_san_ins.setLong(2, COD_MAN);
                        rs_test = ps_pro_san_ins.executeQuery();
                        if (rs_test.next()) {
                            continue;
                        }
                        //----------------------------------------------------------------
                        ps_pro_san_ins = bmp.prepareStatement(
                                "INSERT INTO pro_san_man_tab " +
                                "(cod_pro_san, cod_man, prs_pro_san, dat_inz)" +
                                "VALUES ( ?, ?, 'S', ?)");
                        ps_pro_san_ins.setLong(1, REC_PRO_SAN.getLong(1));
                        ps_pro_san_ins.setLong(2, COD_MAN);
                        ps_pro_san_ins.setDate(3, CUR_DAT);
                        ps_pro_san_ins.executeUpdate();
                    }
                    REC_PRO_SAN.close();
                    //======================DPI_MAN=====================================
                    PreparedStatement ps_dpi = bmp.prepareStatement(
                            "SELECT a.cod_tpl_dpi " +
                            "FROM dpi_rso_tab a WHERE a.cod_rso = ? AND a.cod_azl = ? ");
                    ps_dpi.setLong(1, REC_CUR.getLong(1));
                    ps_dpi.setLong(2, COD_AZL);
                    REC_DPI = ps_dpi.executeQuery();
                    while (REC_DPI.next()) {
                        //---------------------------------------------------------------
                        PreparedStatement ps_dpi_ins = bmp.prepareStatement(
                                "SELECT COD_TPL_DPI FROM DPI_MAN_TAB WHERE COD_TPL_DPI=? AND COD_MAN=?");
                        ps_dpi_ins.setLong(1, REC_DPI.getLong(1));
                        ps_dpi_ins.setLong(2, COD_MAN);
                        rs_test = ps_dpi_ins.executeQuery();
                        if (rs_test.next()) {
                            continue;
                        }
                        //----------------------------------------------------------------
                        ps_dpi_ins = bmp.prepareStatement(
                                "INSERT INTO dpi_man_tab " +
                                "(cod_tpl_dpi, cod_man, prs_dpi, dat_inz) VALUES (?, ?, 'S', ?)");
                        ps_dpi_ins.setLong(1, REC_DPI.getLong(1));
                        ps_dpi_ins.setLong(2, COD_MAN);
                        ps_dpi_ins.setDate(3, CUR_DAT);
                        ps_dpi_ins.executeUpdate();
                    }
                    REC_DPI.close();
                    //======================COR_MAN=====================================
                    PreparedStatement ps_cor = bmp.prepareStatement(
                            "SELECT a.cod_cor " +
                            "FROM cor_rso_tab a WHERE a.cod_rso = ? AND a.cod_azl = ?");
                    ps_cor.setLong(1, REC_CUR.getLong(1));
                    ps_cor.setLong(2, COD_AZL);
                    REC_COR = ps_cor.executeQuery();
                    while (REC_COR.next()) {
                        //---------------------------------------------------------------
                        PreparedStatement ps_cor_ins = bmp.prepareStatement(
                                "SELECT COD_COR FROM COR_MAN_TAB WHERE COD_COR=? AND COD_MAN=?");
                        ps_cor_ins.setLong(1, REC_COR.getLong(1));
                        ps_cor_ins.setLong(2, COD_MAN);
                        rs_test = ps_cor_ins.executeQuery();
                        if (rs_test.next()) {
                            continue;
                        }
                        //----------------------------------------------------------------
                        ps_cor_ins = bmp.prepareStatement(
                                "INSERT INTO cor_man_tab " +
                                "(cod_cor, cod_man, prs_cor, dat_inz) VALUES (?, ?, 'S', ?)");
                        ps_cor_ins.setLong(1, REC_COR.getLong(1));
                        ps_cor_ins.setLong(2, COD_MAN);
                        ps_cor_ins.setDate(3, CUR_DAT);
                        ps_cor_ins.executeUpdate();
                    }
                    REC_COR.close();
                //=================================================================
                } // if(COD_OPE_SVO!=0) ###########################################
			/*===============================
                === main loop finalization === */
                INC++;
            }// /main loop
            //+++ main block finalization +++
            REC_CUR.close();
            conn.commit();
        //++++++++++++++++++++++++++++++++++++++++++++++
        } catch (Exception ex) {
            ex.printStackTrace();
            result = 0;
            try {
                conn.rollback();
            } catch (Exception ex1) {
                ex1.printStackTrace();
            }
            throw new EJBException(ex);
        } finally {
            try {
                conn.close();
                bmp.close();
            } catch (Exception ex2) {
                ex2.printStackTrace();
            }
        }
        return result;
    }

    //----
    int delOperazioneSvolteAssociations(long COD_OPE_SVO, long COD_AZL, long COD_MAN) {
        int result = 1;
        BMPConnection bmp = getConnection();
        Connection conn = bmp.getConnection();
        ResultSet REC_CUR, REC_PRO_SAN, REC_DPI, REC_COR;
        //++++++++++++++++++++++++++++++++++++++++++++++
        try {
            conn.setAutoCommit(false);
            //---------------REC_CUR-------------------
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT a.cod_rso " +
                    "FROM rso_man_tab a WHERE a.cod_azl = ? " +
                    "AND a.cod_man = ? " +
                    "AND NOT EXISTS (SELECT b.cod_rso " +
                    "FROM rso_ope_svo_tab b, ana_ope_svo_tab g, ope_svo_man_tab h " +
                    "WHERE b.cod_ope_svo = g.cod_ope_svo " +
                    "AND b.cod_ope_svo = h.cod_ope_svo " +
                    "AND b.cod_ope_svo != ? " +
                    "AND b.cod_azl      = ? " +
                    "AND h.cod_man      = ? " +
                    "AND b.cod_rso      = a.cod_rso) ");
            ps.setLong(1, COD_AZL);
            ps.setLong(2, COD_MAN);
            ps.setLong(3, COD_OPE_SVO);
            ps.setLong(4, COD_AZL);
            ps.setLong(5, COD_MAN);
            REC_CUR = ps.executeQuery();

            int DEBUG = 1;
            while (REC_CUR.next()) {
                //======================PRO_SAN_MAN=================================
                PreparedStatement ps_pro_san = bmp.prepareStatement(
                        "SELECT a.cod_pro_san FROM pro_san_man_tab a " +
                        "WHERE a.cod_man = ?  " +
                        "AND a.cod_pro_san IN " +
                        "(SELECT b.cod_pro_san FROM pro_san_rso_tab b " +
                        "WHERE b.cod_rso = ? AND b.cod_azl =?) " +
                        "AND a.cod_pro_san NOT IN " +
                        "(SELECT c.cod_pro_san from  pro_san_rso_tab c, rso_man_tab d " +
                        "WHERE d.cod_rso=c.cod_rso and d.cod_rso <>? AND c.cod_azl=? AND d.cod_man = ?)");
                ps_pro_san.setLong(1, COD_MAN);
                ps_pro_san.setLong(2, REC_CUR.getLong(1));
                ps_pro_san.setLong(3, COD_AZL);
                ps_pro_san.setLong(4, REC_CUR.getLong(1));
                ps_pro_san.setLong(5, COD_AZL);
                ps_pro_san.setLong(6, COD_MAN);
                REC_PRO_SAN = ps_pro_san.executeQuery();
                while (REC_PRO_SAN.next()) {
                    PreparedStatement ps_pro_san_del = bmp.prepareStatement(
                            "DELETE FROM pro_san_man_tab WHERE cod_pro_san = ? AND cod_man = ? ");
                    ps_pro_san_del.setLong(1, REC_PRO_SAN.getLong(1));
                    ps_pro_san_del.setLong(2, COD_MAN);
                    ps_pro_san_del.executeUpdate();
                }
                REC_PRO_SAN.close();
                //======================DPI_MAN=====================================
                PreparedStatement ps_dpi = bmp.prepareStatement(
                        "SELECT a.cod_tpl_dpi FROM dpi_man_tab a  " +
                        "WHERE a.cod_man =?	AND a.cod_tpl_dpi IN  " +
                        "(SELECT b.cod_tpl_dpi FROM dpi_rso_tab b " +
                        "WHERE b.cod_azl = ?  AND b.cod_rso=? )   " +
                        "AND a.cod_tpl_dpi NOT IN " +
                        "(SELECT c.cod_tpl_dpi FROM dpi_rso_tab c, rso_man_tab d " +
                        "WHERE d.cod_rso=c.cod_rso AND d.cod_rso <>? AND c.cod_azl=? AND d.cod_man = ? )");
                ps_dpi.setLong(1, COD_MAN);
                ps_dpi.setLong(2, COD_AZL);
                ps_dpi.setLong(3, REC_CUR.getLong(1));
                ps_dpi.setLong(4, REC_CUR.getLong(1));
                ps_dpi.setLong(5, COD_AZL);
                ps_dpi.setLong(6, COD_MAN);
                REC_DPI = ps_dpi.executeQuery();
                while (REC_DPI.next()) {
                    PreparedStatement ps_dpi_del = bmp.prepareStatement(
                            "DELETE FROM dpi_man_tab WHERE cod_tpl_dpi = ? AND cod_man = ? ");
                    ps_dpi_del.setLong(1, REC_DPI.getLong(1));
                    ps_dpi_del.setLong(2, COD_MAN);
                    ps_dpi_del.executeUpdate();
                }
                REC_DPI.close();
                //======================COR_MAN=====================================

                PreparedStatement ps_cor = bmp.prepareStatement(
                        "SELECT a.cod_cor  FROM cor_man_tab a  " +
                        "WHERE a.cod_man = ? AND a.cod_cor IN  " +
                        "(SELECT b.cod_cor FROM cor_rso_tab b  " +
                        "WHERE b.cod_azl= ? AND b.cod_rso = ?) AND a.cod_cor NOT IN  " +
                        "(SELECT c.cod_cor FROM cor_rso_tab c, rso_man_tab d " +
                        "WHERE d.cod_rso=c.cod_rso and d.cod_rso <>? AND c.cod_azl=? AND d.cod_man = ? )");
                ps_cor.setLong(1, COD_MAN);
                ps_cor.setLong(2, COD_AZL);
                ps_cor.setLong(3, REC_CUR.getLong(1));
                ps_cor.setLong(4, REC_CUR.getLong(1));
                ps_cor.setLong(5, COD_AZL);
                ps_cor.setLong(6, COD_MAN);

                REC_COR = ps_cor.executeQuery();
                while (REC_COR.next()) {
                    PreparedStatement ps_cor_del = bmp.prepareStatement(
                            "DELETE FROM cor_man_tab WHERE cod_cor = ? AND cod_man = ? ");
                    ps_cor_del.setLong(1, REC_COR.getLong(1));
                    ps_cor_del.setLong(2, COD_MAN);
                    ps_cor_del.executeUpdate();
                }
                REC_COR.close();
                //======== MIS_PET_MAN =================
                PreparedStatement ps_mis_pet_del = bmp.prepareStatement(
                        "DELETE FROM mis_pet_man_tab " +
                        " WHERE cod_rso_man IN " +
                        "(SELECT h.cod_rso_man FROM rso_man_tab h WHERE h.cod_azl = ? " +
                        "AND h.cod_man = ? AND h.cod_rso = ?)");
                ps_mis_pet_del.setLong(1, COD_AZL);
                ps_mis_pet_del.setLong(2, COD_MAN);
                ps_mis_pet_del.setLong(3, REC_CUR.getLong(1));
                ps_mis_pet_del.executeUpdate();
                //======== RSO_MAN =====================
                PreparedStatement ps_rso_man_del = bmp.prepareStatement(
                        "DELETE FROM rso_man_tab WHERE cod_azl = ? AND cod_man = ? AND cod_rso = ? ");
                ps_rso_man_del.setLong(1, COD_AZL);
                ps_rso_man_del.setLong(2, COD_MAN);
                ps_rso_man_del.setLong(3, REC_CUR.getLong(1));
                ps_rso_man_del.executeUpdate();
            //======================================


            }// /main loop
            REC_CUR.close();
            conn.commit();
        //-------------------------------
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            result = 0;
            try {
                conn.rollback();
            } catch (Exception ex1) {
                System.err.println("AttivitaLavorativeBean: Error rollback");
            }
            throw new EJBException(ex);
        } finally {
            try {
                conn.close();
                bmp.close();
            } catch (Exception ex1) {
                System.err.println("AttivitaLavorativeBean: Error closing connection");
            }
        }
        return result;
    }

    long isIncludedMacchinaToAzienda(
            long lCOD_MAC,
            long lCOD_AZL,
            long lNEW_COD_AZL,
            java.util.ArrayList AZIENDE_ID,
            BMPConnection bmp) {
        long NEW_COD_MAC = 0;
        try {
            ResultSet rs = getExtendedObjectsEx(bmp, "ana_mac_tab", lCOD_MAC, lCOD_AZL, AZIENDE_ID);
            while (rs.next()) {
                if (rs.getLong(1) == lNEW_COD_AZL) {
                    NEW_COD_MAC = rs.getLong(2);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return NEW_COD_MAC;
    }
    
    String addMacchinaAssocToOperazione(long lCOD_MAC, long lCOD_OPE_SVO, BMPConnection bmp) {
        String res = "";
        try {
            BMPConnection bmpConn = bmp;
            PreparedStatement ps;
            ps = bmpConn.prepareStatement(
                    "select * from mac_ope_svo_tab where cod_mac=? and cod_ope_svo=?");
            ps.setLong(1, lCOD_MAC);
            ps.setLong(2, lCOD_OPE_SVO);
            ResultSet rs_test = ps.executeQuery();
            if (rs_test.next()) {
                return res + "record exists";
            }

            ps = bmpConn.prepareStatement(
                    "insert into mac_ope_svo_tab (cod_mac, cod_ope_svo) values (?, ?)");
            res += "&nbsp;&nbsp;statement prepared";
            ps.setLong(1, lCOD_MAC);
            res += "<br>&nbsp;&nbsp;set cod_mac - " + lCOD_MAC;
            ps.setLong(2, lCOD_OPE_SVO);
            res += "<br>&nbsp;&nbsp;set cod_ope_svo - " + lCOD_OPE_SVO;
            ps.executeUpdate();
            res += "<br>&nbsp;&nbsp;&nbsp;...added macchina to ope svo";
        } catch (Exception ex) {
            StackTraceElement[] trace = ex.getStackTrace();
            for (int i = 0; i < trace.length; i++) {
                res += "<br>" + trace[i].toString();
            }

            res += "<br>" + ex.toString() + "..FAILED";
        }
        return res += "...OK<br>";
    }
    
    java.util.ArrayList getMacchinaRischi(long lCOD_MAC, long lCOD_AZL, BMPConnection bmp) {
        String res = "";
        java.util.ArrayList rischi = new java.util.ArrayList();
        try {
            BMPConnection bmpConn = bmp;
            PreparedStatement ps;
            ps = bmpConn.prepareStatement(
                    "select cod_rso from rso_mac_tab where cod_mac=? and cod_azl=?");
            ps.setLong(1, lCOD_MAC);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs_test = ps.executeQuery();
            while (rs_test.next()) {
                rischi.add(new Long(rs_test.getLong(1)));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
        return rischi;

    }    
    
    //-------adding sostanza chimicha to operazione svolta ----
    String addSostanzaAssocToOperazione(long lCOD_SOS_CHI, long lCOD_OPE_SVO, BMPConnection bmp) {
        String res = "";
        try {
            BMPConnection bmpConn = bmp;
            PreparedStatement ps;
            ps = bmpConn.prepareStatement(
                    "select * from sos_chi_ope_svo_tab where cod_sos_chi=? and cod_ope_svo=?");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_OPE_SVO);
            ResultSet rs_test = ps.executeQuery();
            if (rs_test.next()) {
                return res + "<br>record exists<br>";
            }

            ps = bmpConn.prepareStatement(
                    "insert into sos_chi_ope_svo_tab (cod_sos_chi, cod_ope_svo) values (?, ?)");
            res += "<br>&nbsp;&nbsp;statement prepared";
            ps.setLong(1, lCOD_SOS_CHI);
            res += "<br>&nbsp;&nbsp;set cod_mac - " + lCOD_SOS_CHI;
            ps.setLong(2, lCOD_OPE_SVO);
            res += "<br>&nbsp;&nbsp;set cod_ope_svo - " + lCOD_OPE_SVO;
            ps.executeUpdate();
            res += "<br>&nbsp;&nbsp;&nbsp;...added sostanza to ope svo";
        } catch (Exception ex) {
            StackTraceElement[] trace = ex.getStackTrace();
            for (int i = 0; i < trace.length; i++) {
                res += "<br>" + trace[i].toString();
            }

            res += "<br>" + ex.toString() + "..FAILED";
        }
        return res += "...OK<br>";
    }

    //---------get rischi from sostanza in azienda
    java.util.ArrayList getSostanzaRischi(long lCOD_SOS_CHI, long lCOD_AZL, BMPConnection bmp) {
        String res = "";
        java.util.ArrayList rischi = new java.util.ArrayList();
        try {
            BMPConnection bmpConn = bmp;
            PreparedStatement ps;
            ps = bmpConn.prepareStatement(
                    "select cod_rso from rso_sos_chi_tab where cod_sos_chi=? and cod_azl=?");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs_test = ps.executeQuery();
            while (rs_test.next()) {
                rischi.add(new Long(rs_test.getLong(1)));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
        return rischi;
    }

    String addRischioToMacchina(long lCOD_MAC, long lCOD_RSO, long lNEW_COD_AZL, String strTPL_CLF_RSO, BMPConnection bmp) {
        String res = "";
        try {
            BMPConnection bmpConn = bmp;
            PreparedStatement ps;
            ps = bmpConn.prepareStatement(
                    "select * from rso_mac_tab where cod_mac=? and cod_rso=? and cod_azl=?");
            ps.setLong(1, lCOD_MAC);
            ps.setLong(2, lCOD_RSO);
            ps.setLong(3, lNEW_COD_AZL);
            ResultSet rs_test = ps.executeQuery();
            if (rs_test.next()) {
                return res + "record exists";
            }

            ps = bmpConn.prepareStatement(
                    "insert into rso_mac_tab (cod_mac, cod_rso, cod_azl, tpl_clf_rso) values (?, ?, ?, ?)");
            res += "&nbsp;&nbsp;statement prepared";
            ps.setLong(1, lCOD_MAC);
            res += "<br>&nbsp;&nbsp;set cod_sos_chi - " + lCOD_MAC;
            ps.setLong(2, lCOD_RSO);
            res += "<br>&nbsp;&nbsp;set cod_rso - " + lCOD_RSO;
            ps.setLong(3, lNEW_COD_AZL);
            res += "<br>&nbsp;&nbsp;set newCodAzl - " + lNEW_COD_AZL;
            ps.setString(4, strTPL_CLF_RSO);
            res += "<br>&nbsp;&nbsp;set tpl_clf_rso - " + strTPL_CLF_RSO;
            ps.executeUpdate();
            res += "<br>&nbsp;&nbsp;&nbsp;...added rischio to sostanza";
        } catch (Exception ex) {
            StackTraceElement[] trace = ex.getStackTrace();
            for (int i = 0; i < trace.length; i++) {
                res += "<br>" + trace[i].toString();
            }

            res += "<br>" + ex.toString() + "..FAILED";
        }
        return res += "...OK<br>";
    }

    //-----------
    java.util.ArrayList getOperazioneSvoltaByMacchina(long lCOD_MAC, java.util.ArrayList ID_MAN, BMPConnection bmp) {
        java.util.ArrayList arlist = new java.util.ArrayList();
        try {
            String str = "";
            Iterator it = ID_MAN.iterator();
            while (it.hasNext()) {
                str += ((Long) it.next());
                if (it.hasNext()) {
                    str += ",";
                }
            }
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT a.cod_ope_svo FROM mac_ope_svo_tab a, ana_ope_svo_tab b, ope_svo_man_tab c where 	a.cod_mac=? and 	c.cod_man in (" + str + ") and 	a.cod_ope_svo=b.cod_ope_svo and   	b.cod_ope_svo=c.cod_ope_svo");
            ps.setLong(1, lCOD_MAC);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                arlist.add(new Long(rs.getLong(1)));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
        return arlist;
    }
    //</alex>
    //------------------

    //------------------
    //<alex date="07/04/2004" descr="dobavlenie riska k sos_chi">
    String addRischioToSostanza(long lCOD_SOS_CHI, long lCOD_RSO, long lNEW_COD_AZL, String strTPL_CLF_RSO, BMPConnection bmp) {
        String res = "";
        try {
            BMPConnection bmpConn = bmp;
            PreparedStatement ps;
            ps = bmpConn.prepareStatement(
                    "select * from rso_sos_chi_tab where cod_sos_chi=? and cod_rso=? and cod_azl=?");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_RSO);
            ps.setLong(3, lNEW_COD_AZL);
            ResultSet rs_test = ps.executeQuery();
            if (rs_test.next()) {
                return res + "record exists";
            }
            ps = bmpConn.prepareStatement(
                    "insert into rso_sos_chi_tab (cod_sos_chi, cod_rso, cod_azl, tpl_clf_rso) values (?, ?, ?, ?)");
            res += "&nbsp;&nbsp;statement prepared";
            ps.setLong(1, lCOD_SOS_CHI);
            res += "<br>&nbsp;&nbsp;set cod_sos_chi - " + lCOD_SOS_CHI;
            ps.setLong(2, lCOD_RSO);
            res += "<br>&nbsp;&nbsp;set cod_rso - " + lCOD_RSO;
            ps.setLong(3, lNEW_COD_AZL);
            res += "<br>&nbsp;&nbsp;set newCodAzl - " + lNEW_COD_AZL;
            ps.setString(4, strTPL_CLF_RSO);
            res += "<br>&nbsp;&nbsp;set tpl_clf_rso - " + strTPL_CLF_RSO;
            ps.executeUpdate();
            res += "<br>&nbsp;&nbsp;&nbsp;...added rischio to sostanza";
        } catch (Exception ex) {
            StackTraceElement[] trace = ex.getStackTrace();
            for (int i = 0; i < trace.length; i++) {
                res += "<br>" + trace[i].toString();
            }

            res += "<br>" + ex.toString() + "..FAILED";
        }
        return res += "...OK<br>";
    }
    //</alex>
    java.util.ArrayList getOperazioneSvoltaBySostanza(long lCOD_SOS_CHI, java.util.ArrayList ID_MAN, BMPConnection bmp) {
        java.util.ArrayList arlist = new java.util.ArrayList();
        try {
            String str = "";
            Iterator it = ID_MAN.iterator();
            while (it.hasNext()) {
                str += ((Long) it.next());
                if (it.hasNext()) {
                    str += ",";
                }
            }
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT a.cod_ope_svo FROM sos_chi_ope_svo_tab a, ana_ope_svo_tab b, ope_svo_man_tab c where 	a.cod_sos_chi=? and 	c.cod_man in (" + str + ") and 	a.cod_ope_svo=b.cod_ope_svo and   	b.cod_ope_svo=c.cod_ope_svo");
            ps.setLong(1, lCOD_SOS_CHI);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                arlist.add(new Long(rs.getLong(1)));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
        return arlist;
    }
    //------------------
    java.util.ArrayList getAttivitaByOperazioneSvolta(long lCOD_OPE_SVO, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select a.cod_man from ana_man_tab a, ope_svo_man_tab b  where a.cod_azl=? and b.cod_ope_svo=? and a.cod_man=b.cod_man");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_OPE_SVO);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Long obj = new Long(rs.getLong(1));
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex1) {
            ex1.printStackTrace();
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
    //</alex>
    //<alex date="02/04/2004" last_modified="06/04/2004">
    boolean isIncludedRiskToAzienda(long lCOD_AZL, long lCOD_RSO, BMPConnection bmp) {
        boolean isRischioExists = false;
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select cod_rso from ana_rso_tab where cod_rso=? and cod_azl=?");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                isRischioExists = true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
        return isRischioExists;
    }

    //-------------------------------------------------------------------
    //-------- * add associations for luoghi fisici list ----------------
    //-------- * date="13/04/2004" --------------------------------------
    String addRiscToLuoghiList(long lCOD_RSO, long lCOD_AZL, java.util.ArrayList col_lCOD_LUO_FSC, BMPConnection bmp) {
        String result = "";
        try {
            Iterator it = col_lCOD_LUO_FSC.iterator();
            while (it.hasNext()) {
                long cod_luo = ((Long) it.next()).longValue();
                result = addLuogoFisiciAssociations(cod_luo, lCOD_AZL, lCOD_RSO, bmp);
                result += "&nbsp;&nbsp;&nbsp;...add rischio to azl- " + lCOD_AZL + ";  cod_luo_fsc - " + cod_luo;
            }
        } catch (Exception ex) {
            result += "<br>&nbsp;&nbsp;&nbsp;..." + ex.toString() + "FAILED";
        }
        return result + "<br>&nbsp;&nbsp;&nbsp;...OK";
    }

    //------- * add associations for luoghi fisici ----------------------
    //-------- * date="13/04/2004" --------------------------------------
    String addLuogoFisiciAssociations(long lID_PARENT, long lCOD_AZL, long lCOD_RSO, BMPConnection bmp) {
        ResultSet REC_DPI, REC_COR, REC_PRO_SAN;
        long CODICE = NEW_ID();
        //---
        String NOM_RIL_RSO = "";
        long PRB_EVE_LES = 0;
        long ENT_DAN = 0;
        long STM_NUM_RSO = 0;
        java.sql.Date DAT_RIL = null;
        int RFC_VLU_RSO_MES = 0;
        String res = "";
        long CODICE_DELTA = 1;
        //---
        java.util.Date dt = new java.util.Date();
        java.sql.Date DATE = new java.sql.Date(dt.getTime());
        long lCUR_DATE = DATE.getTime();
        java.sql.Date SUM_DAT = new java.sql.Date(0L);
        //---
        try {
            //---------------REC_DPI-----------------
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT a.cod_tpl_dpi FROM dpi_rso_tab a " +
                    "WHERE a.cod_azl = ? AND a.cod_rso = ? ");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_RSO);

            REC_DPI = ps.executeQuery();
            ps.clearParameters();

            //---------------REC_COR------------------
            ps = bmp.prepareStatement(
                    "SELECT a.cod_cor FROM cor_rso_tab a " +
                    "WHERE a.cod_rso =  ? and  a.cod_azl=? ");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            REC_COR = ps.executeQuery();
            ps.clearParameters();

            //---------------REC_PRO_SAN------------------
            ps = bmp.prepareStatement(
                    "SELECT a.cod_pro_san FROM pro_san_rso_tab a " +
                    "WHERE a.cod_rso = ? and a.cod_azl = ? ");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            REC_PRO_SAN = ps.executeQuery();
            ps.clearParameters();

            //----------------RS (rischi)--------------
            ps = bmp.prepareStatement(
                    "SELECT a.nom_ril_rso, a.prb_eve_les, a.ent_dan, " +
                    "a.stm_num_rso, a.dat_ril, a.rfc_vlu_rso_mes, a.cod_rso " +
                    "FROM ana_rso_tab a " +
                    "WHERE (a.cod_rso =  ? and a.cod_azl=?) ");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);

            ResultSet rs = ps.executeQuery();
            ps.clearParameters();
            //----------------------------------
            long DT;
            while (rs.next()) {
                //----------------------------
                ps = bmp.prepareStatement("select * from rso_luo_fsc_tab where cod_rso=? and cod_luo_fsc=? and cod_azl=?");
                ps.setLong(1, lCOD_RSO);
                ps.setLong(2, lID_PARENT);
                ps.setLong(3, lCOD_AZL);

                ResultSet rs_test = ps.executeQuery();
                ps.clearParameters();
                if (rs_test.next()) {
                    continue;
                }
                //------------------------------
                NOM_RIL_RSO = rs.getString(1);
                PRB_EVE_LES = rs.getLong(2);
                ENT_DAN = rs.getLong(3);
                STM_NUM_RSO = rs.getLong(4);
                DAT_RIL = rs.getDate(5);
                RFC_VLU_RSO_MES = rs.getInt(6);
                lCOD_RSO = rs.getLong(7);
                //---------------------------------------------
                ps = bmp.prepareStatement(
                        "INSERT INTO rso_luo_fsc_tab " +
                        "(cod_rso_luo_fsc, " +
                        "cod_luo_fsc, " +
                        "cod_rso, " +
                        "cod_azl, " +
                        "prs_rso, " +
                        "dat_inz, " +
                        "dat_fie, " +
                        "nom_ril_rso, " +
                        "clf_rso, " +
                        "prb_eve_les, " +
                        "ent_dan, " +
                        "stm_num_rso, " +
                        "dat_rfc_vlu_rso, " +
                        "sta_rso) " +
                        "VALUES( ?, ?, ?, ?, 'S', ?, NULL, ?, 'PER TUTTI', ?, ?, ?, ?, 'V')");
                ps.setLong(1, CODICE + CODICE_DELTA);
                ps.setLong(2, lID_PARENT);
                ps.setLong(3, lCOD_RSO);
                ps.setLong(4, lCOD_AZL);
                ps.setDate(5, DATE);
                ps.setString(6, NOM_RIL_RSO);
                ps.setLong(7, PRB_EVE_LES);
                ps.setLong(8, ENT_DAN);
                ps.setLong(9, STM_NUM_RSO);
                //
                java.sql.Date S_DAT = new java.sql.Date(lCUR_DATE);
                S_DAT.setMonth(DATE.getMonth() + RFC_VLU_RSO_MES);
                ps.setDate(10, S_DAT);
                //
                ps.executeUpdate();
                ps.clearParameters();
                //---
                while (REC_DPI.next()) {
                    //-----------------------------------------------
                    ps = bmp.prepareStatement("select * from dpi_luo_fsc_tab where cod_tpl_dpi=? and cod_luo_fsc=?");
                    ps.setLong(1, REC_DPI.getLong(1));
                    ps.setLong(2, lID_PARENT);
                    ResultSet rs_test2 = ps.executeQuery();
                    ps.clearParameters();
                    if (rs_test2.next()) {
                        continue;
                    }
                    //------------------------------------------------
                    ps = bmp.prepareStatement(
                            "INSERT INTO dpi_luo_fsc_tab (cod_luo_fsc, cod_tpl_dpi, prs_dpi, dat_inz, " +
                            "dat_fie) VALUES( ?, ?, 'S', ?, NULL) ");
                    ps.setLong(1, lID_PARENT);
                    ps.setLong(2, REC_DPI.getLong(1));
                    ps.setDate(3, DATE);
                    ps.executeUpdate();
                    ps.clearParameters();
                }
                //---
                while (REC_COR.next()) {
                    //-----------------------------------------------
                    ps = bmp.prepareStatement("select * from cor_luo_fsc_tab where cod_cor=? and cod_luo_fsc=?");
                    ps.setLong(1, REC_COR.getLong(1));
                    ps.setLong(2, lID_PARENT);
                    ResultSet rs_test2 = ps.executeQuery();
                    ps.clearParameters();
                    if (rs_test2.next()) {
                        continue;
                    }
                    //------------------------------------------------
                    ps = bmp.prepareStatement(
                            "INSERT INTO cor_luo_fsc_tab " +
                            "(cod_luo_fsc, cod_cor, prs_cor, dat_inz, dat_fie) " +
                            "VALUES( ?, ?, 'S', ?, NULL) ");
                    ps.setLong(1, lID_PARENT);
                    ps.setLong(2, REC_COR.getLong(1));
                    ps.setDate(3, DATE);
                    ps.executeUpdate();
                    ps.clearParameters();
                }
                //---
                while (REC_PRO_SAN.next()) {
                    //-----------------------------------------------
                    ps = bmp.prepareStatement("select * from pro_san_luo_fsc_tab where cod_pro_san=? and cod_luo_fsc=?");
                    ps.setLong(1, REC_PRO_SAN.getLong(1));
                    ps.setLong(2, lID_PARENT);
                    ResultSet rs_test2 = ps.executeQuery();
                    ps.clearParameters();
                    if (rs_test2.next()) {
                        continue;
                    }
                    //------------------------------------------------
                    ps = bmp.prepareStatement(
                            "INSERT INTO pro_san_luo_fsc_tab " +
                            "(cod_luo_fsc, cod_pro_san, prs_pro_san, dat_inz, dat_fie) " +
                            "VALUES( ?, ?, 'S', ?, NULL) ");
                    ps.setLong(1, lID_PARENT);
                    ps.setLong(2, REC_PRO_SAN.getLong(1));
                    ps.setDate(3, DATE);
                    ps.executeUpdate();
                    ps.clearParameters();
                }
                CODICE_DELTA++;
            }
            //---------------------------------
            rs.close();
        } catch (Exception ex) {
            res = ex.toString() + "...FAILED";
        }
        return res + "OK";

    }
    //------------ 
    java.util.ArrayList getLuoghiFisichiByMacchina(long lCOD_MAC, long lCOD_AZL, BMPConnection bmp) {
        java.util.ArrayList arrLuo = new java.util.ArrayList();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select "
                        + "a.cod_luo_fsc "
                    + "from "
                        + "ana_luo_fsc_tab a, "
                        + "mac_luo_fsc_tab b "
                    + "where "
                        + "b.cod_mac=? "
                        + "and a.cod_azl=?");
            ps.setLong(1, lCOD_MAC);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                arrLuo.add(new Long(rs.getLong(1)));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }

        return arrLuo;
    }

    //------------ 
    java.util.ArrayList getLuoghiFisichiBySostanza(long lCOD_SOS_CHI, long lCOD_AZL, BMPConnection bmp) {
        java.util.ArrayList arrSos = new java.util.ArrayList();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select "
                        + "a.cod_luo_fsc "
                    + "from "
                        + "ana_luo_fsc_tab a, "
                        + "sos_chi_luo_fsc_tab b "
                    + "where "
                        + "b.cod_sos_chi=? "
                        + "and a.cod_azl=?");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                arrSos.add(new Long(rs.getLong(1)));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
        return arrSos;
    }
    //=====================================================
    //</alex>

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    //		MULTIAZIENDA BY Romas	
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  /* *date:08/04/2004 *author:Roman Chumachenko
    Deleting of Risc Associations from Attivita Lavorativa
     */
    String deleteExtendedRischioAssociations(long lCOD_RSO, long lCOD_AZL, long lCOD_MAN, BMPConnection bmp) {
        ResultSet REC_CUR, REC_PRO_SAN, REC_DPI, REC_COR;
        String result = "";
        //++++++++++++++++++++++++++++++++++++++++++++++
        try {
            //======================PRO_SAN_MAN============
            if ((ApplicationConfigurator.isModuleEnabled(MODULES.PRO_SAN_4_ATT_LAV) == false)){
            PreparedStatement ps_pro_san;
            ps_pro_san = bmp.prepareStatement(
                    "SELECT a.cod_pro_san FROM pro_san_man_tab a " +
                    "WHERE a.cod_man = ?  " +
                    "AND a.cod_pro_san IN " +
                    "(SELECT b.cod_pro_san FROM pro_san_rso_tab b " +
                    "WHERE b.cod_rso = ? AND b.cod_azl =?) " +
                    "AND a.cod_pro_san NOT IN " +
                    "(SELECT c.cod_pro_san from  pro_san_rso_tab c, rso_man_tab d " +
                    "WHERE d.cod_rso=c.cod_rso and d.cod_rso <>? AND c.cod_azl=? AND d.cod_man = ?)");
            ps_pro_san.setLong(1, lCOD_MAN);
            ps_pro_san.setLong(2, lCOD_RSO);
            ps_pro_san.setLong(3, lCOD_AZL);
            ps_pro_san.setLong(4, lCOD_RSO);
            ps_pro_san.setLong(5, lCOD_AZL);
            ps_pro_san.setLong(6, lCOD_MAN);
            REC_PRO_SAN = ps_pro_san.executeQuery();
            while (REC_PRO_SAN.next()) {
                PreparedStatement ps_pro_san_del = bmp.prepareStatement(
                        "DELETE FROM pro_san_man_tab WHERE cod_pro_san = ? AND cod_man = ? ");
                ps_pro_san_del.setLong(1, REC_PRO_SAN.getLong(1));
                ps_pro_san_del.setLong(2, lCOD_MAN);
                ps_pro_san_del.executeUpdate();
            }
            REC_PRO_SAN.close();
            result += "REC_PRO_SAN.close() ";}
            //======================DPI_MAN=====================================
            if ((ApplicationConfigurator.isModuleEnabled(MODULES.DPI_4_ATT_LAV) == false)){
            PreparedStatement ps_dpi = bmp.prepareStatement(
                    "SELECT a.cod_tpl_dpi FROM dpi_man_tab a  " +
                    "WHERE a.cod_man =?	AND a.cod_tpl_dpi IN  " +
                    "(SELECT b.cod_tpl_dpi FROM dpi_rso_tab b " +
                    "WHERE b.cod_azl = ?  AND b.cod_rso=? )   " +
                    "AND a.cod_tpl_dpi NOT IN " +
                    "(SELECT c.cod_tpl_dpi FROM dpi_rso_tab c, rso_man_tab d " +
                    "WHERE d.cod_rso=c.cod_rso AND d.cod_rso <>? AND c.cod_azl=? AND d.cod_man = ? )");
            ps_dpi.setLong(1, lCOD_MAN);
            ps_dpi.setLong(2, lCOD_AZL);
            ps_dpi.setLong(3, lCOD_RSO);
            ps_dpi.setLong(4, lCOD_RSO);
            ps_dpi.setLong(5, lCOD_AZL);
            ps_dpi.setLong(6, lCOD_MAN);
            REC_DPI = ps_dpi.executeQuery();
            while (REC_DPI.next()) {
                PreparedStatement ps_dpi_del = bmp.prepareStatement(
                        "DELETE FROM dpi_man_tab WHERE cod_tpl_dpi = ? AND cod_man = ? ");
                ps_dpi_del.setLong(1, REC_DPI.getLong(1));
                ps_dpi_del.setLong(2, lCOD_MAN);
                ps_dpi_del.executeUpdate();
            }
            REC_DPI.close();
            result += "REC_DPI.close() ";}
            //======================COR_MAN=====================================
            if ((ApplicationConfigurator.isModuleEnabled(MODULES.CORSI_4_ATT_LAV) == false)){
            PreparedStatement ps_cor = bmp.prepareStatement(
                    "SELECT a.cod_cor  FROM cor_man_tab a  " +
                    "WHERE a.cod_man = ? AND a.cod_cor IN  " +
                    "(SELECT b.cod_cor FROM cor_rso_tab b  " +
                    "WHERE b.cod_azl= ? AND b.cod_rso = ?) AND a.cod_cor NOT IN  " +
                    "(SELECT c.cod_cor FROM cor_rso_tab c, rso_man_tab d  " +
                    "WHERE d.cod_rso=c.cod_rso and d.cod_rso <>? AND c.cod_azl=? AND d.cod_man = ? )");
            ps_cor.setLong(1, lCOD_MAN);
            ps_cor.setLong(2, lCOD_AZL);
            ps_cor.setLong(3, lCOD_RSO);
            ps_cor.setLong(4, lCOD_RSO);
            ps_cor.setLong(5, lCOD_AZL);
            ps_cor.setLong(6, lCOD_MAN);
            REC_COR = ps_cor.executeQuery();
            while (REC_COR.next()) {
                PreparedStatement ps_cor_del = bmp.prepareStatement(
                        "DELETE FROM cor_man_tab WHERE cod_cor = ? AND cod_man = ? ");
                ps_cor_del.setLong(1, REC_COR.getLong(1));
                ps_cor_del.setLong(2, lCOD_MAN);
                ps_cor_del.executeUpdate();
            }
            REC_COR.close();
            result += "REC_COR.close() ";}
            //======== MIS_PET_MAN =================
            PreparedStatement ps_mis_pet_del = bmp.prepareStatement(
                    "DELETE FROM mis_pet_man_tab " +
                    " WHERE cod_rso_man IN " +
                    "(SELECT h.cod_rso_man FROM rso_man_tab h WHERE h.cod_azl = ? " +
                    "AND h.cod_man = ? AND h.cod_rso = ?)");
            ps_mis_pet_del.setLong(1, lCOD_AZL);
            ps_mis_pet_del.setLong(2, lCOD_MAN);
            ps_mis_pet_del.setLong(3, lCOD_RSO);
            ps_mis_pet_del.executeUpdate();
            result += "ps_mis_pet_del ";
            //======== RSO_MAN =====================
            PreparedStatement ps_rso_man_del = bmp.prepareStatement(
                    "DELETE FROM rso_man_tab WHERE cod_azl = ? AND cod_man = ? AND cod_rso = ? ");
            ps_rso_man_del.setLong(1, lCOD_AZL);
            ps_rso_man_del.setLong(2, lCOD_MAN);
            ps_rso_man_del.setLong(3, lCOD_RSO);
            ps_rso_man_del.executeUpdate();
            result += "ps_rso_man_del ";
        //======================================
        }// /main loop
        catch (Exception ex) {
            ex.printStackTrace(System.err);
            result = ex.toString() + "...FAILED";
        }
        return result;
    }
    //-----------------------------------------------------------

    /* *date:06/04/2004 *author:Roman Chumachenko
    Adding of Risc Association to Operazione Svolta
     */
    String addRiscToOperazioneSvolta(
            long lCOD_OPE_SVO,
            long lCOD_RSO,
            long lCOD_AZL,
            BMPConnection bmp) {
        String result = "";
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT COD_OPE_SVO FROM RSO_OPE_SVO_TAB " +
                    " WHERE (COD_OPE_SVO=? AND COD_RSO=? AND COD_AZL=?)");
            ps.setLong(1, lCOD_OPE_SVO);
            ps.setLong(2, lCOD_RSO);
            ps.setLong(3, lCOD_AZL);
            ResultSet rs_test = ps.executeQuery();
            if (rs_test.next()) {
               // return result;
                return result="...ATTIVITA ESISTENTE";
            }
            //----------------------------------------------------
            ps = bmp.prepareStatement(
                    "INSERT INTO RSO_OPE_SVO_TAB (COD_OPE_SVO, COD_RSO, COD_AZL) VALUES (?, ?, ?)");
            ps.setLong(1, lCOD_OPE_SVO);
            ps.setLong(2, lCOD_RSO);
            ps.setLong(3, lCOD_AZL);
            ps.executeUpdate();
        } catch (Exception ex) {
            result = ex.toString() + "...FAILED";
        }
        return result;
    }
    //---------------------------------------

    /* *date:06/04/2004 *author:Roman Chumachenko
    Adding of Risc Association to Attivita Lavorative List
     */
    String addRiscToAttivitaLavorativeList(
            long lCOD_RSO,
            long lCOD_AZL,
            java.util.ArrayList CODS_MAN,
            BMPConnection bmp) {
        String result = "";
        try {
            Iterator it = CODS_MAN.iterator();
            while (it.hasNext()) {
                long cod_man = ((Long) it.next()).longValue();
                result = this.addExtendedRischioAssociations(lCOD_RSO, lCOD_AZL, bmp, cod_man);
            }
        } catch (Exception ex) {
            result += "\n" + ex.toString() + "FAILED";
        }
        return result + "OK";
    }
    //---------------------------------------
    /* *date:07/04/2004 *author:Roman Chumachenko
    IsIncluded Attivita Lavorativa to other Azienda
    if ok :returns long COD_MAN
    if not:returns long 0
     */
    long isIncludedAttLavorativaToAzienda(
            long lCOD_AZL_CURRENT,
            long lCOD_AZL_NEW,
            long lCOD_MAN,
            java.util.ArrayList AZIENDE_ID,
            BMPConnection bmp) {
        long NEW_COD_MAN = 0;
        try {
            ResultSet rs = getExtendedObjectsEx(bmp, "ana_man_tab", lCOD_MAN, lCOD_AZL_CURRENT, AZIENDE_ID);
            while (rs.next()) {
                if (rs.getLong(1) == lCOD_AZL_NEW) {
                    NEW_COD_MAN = rs.getLong(2);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
        return NEW_COD_MAN;
    }
    //-------------------------------------------
    /* *date:07/04/2004 *author:Roman Chumachenko
    IsIncluded current Operaziona Svolta to Attivita Lavorativa
    if ok :returns boolean true
    if not:returns boolean false
     */
    boolean isIncludedOpSvoltaToAttLavorativa(
            long lCOD_MAN,
            long lCOD_OPE_SVO,
            BMPConnection bmp) {
        boolean result = false;
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT COD_OPE_SVO FROM OPE_SVO_MAN_TAB WHERE COD_MAN=? AND COD_OPE_SVO=?");
            ps.setLong(1, lCOD_MAN);
            ps.setLong(2, lCOD_OPE_SVO);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                result = true;
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
        return result;
    }
    //-------------------------------------------
    /* *date:07/04/2004 *author:Roman Chumachenko
    Addind of Operaziona Svolta Assotiation to Attivita Lavorativa
     */
    String addOpSvolteToAttLavorativa(
            long lCOD_OPE_SVO,
            long lCOD_MAN,
            BMPConnection bmp) {
        String result = "";
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT COD_MAN FROM OPE_SVO_MAN_TAB " +
                    " WHERE (COD_MAN=? AND COD_OPE_SVO=?)");
            ps.setLong(1, lCOD_MAN);
            ps.setLong(2, lCOD_OPE_SVO);
            ResultSet rs_test = ps.executeQuery();
            if (rs_test.next()) {
               return result="...ATTIVITA ESISTENTE";
                
            }
            //----------------------------------------------------
            ps = bmp.prepareStatement(
                    "INSERT INTO OPE_SVO_MAN_TAB (COD_OPE_SVO, COD_MAN) VALUES(?,?)");
            ps.setLong(1, lCOD_OPE_SVO);
            ps.setLong(2, lCOD_MAN);
            ps.executeUpdate();
        } catch (Exception ex) {
            result = ex.toString() + "...FAILED";
        }
        return result;
    }
    //---------------------------------------------
    /* *date:07/04/2004 *author:Roman Chumachenko
    Addind of Operaziona Svolta Risc Associations to Attivita Lavorativa
     */
    String addRiscsAssocByOpSvolta(
            long lCOD_OPE_SVO,
            long lCOD_AZL,
            long lCOD_MAN,
            BMPConnection bmp) {
        String result = "";
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT a.cod_rso " +
                    "FROM rso_ope_svo_tab a, ana_rso_tab b " +
                    "WHERE a.cod_rso= b.cod_rso " +
                    "AND a.cod_azl= ? " +
                    "AND a.cod_ope_svo = ?");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_OPE_SVO);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result += "<br>RES:" + rs.getLong(1);
                result += this.addExtendedRischioAssociations(rs.getLong(1), lCOD_AZL, bmp, lCOD_MAN);

            }
        } catch (Exception ex) {
            result = ex.toString() + "...FAILED";
        }
        return result;
    }
    //---------------------------------------------
    /* *date:07/04/2004 *author:Roman Chumachenko			
    Getting of AttLavorativa List for Operaziona Svolta	
     */
    java.util.ArrayList getAttLavListByOpSvolta(
            long lCOD_OPE_SVO,
            long lCOD_AZL,
            BMPConnection bmp) {
        java.util.ArrayList list = new java.util.ArrayList();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT a.cod_man " +
                    "FROM ana_man_tab a, ope_svo_man_tab b " +
                    "WHERE a.cod_man= b.cod_man " +
                    "AND b.cod_ope_svo= ? " +
                    "AND a.cod_azl = ? ");
            ps.setLong(1, lCOD_OPE_SVO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Long(rs.getLong(1)));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
        return list;
    }
    //----------------------------------------------------
    /* *date:09/04/2004 *author:Roman Chumachenko
    Getting of Riscs List for Operaziona Svolta 
     */
    java.util.ArrayList getRiscsListByOpSvolta(
            long lCOD_OPE_SVO,
            long lCOD_AZL,
            BMPConnection bmp) {
        java.util.ArrayList list = new java.util.ArrayList();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT cod_rso FROM rso_ope_svo_tab " +
                    "WHERE cod_ope_svo= ? AND cod_azl = ? ");
            ps.setLong(1, lCOD_OPE_SVO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Long(rs.getLong(1)));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
        return list;
    }
    //----------------------------------------------------
    /* *date:09/04/2004 *author:Roman Chumachenko
    Getting of Riscs List for Macchina Attr
     */
    java.util.ArrayList getRiscsListByMacchina(
            long lCOD_MAC,
            long lCOD_AZL,
            BMPConnection bmp) {
        java.util.ArrayList list = new java.util.ArrayList();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT cod_rso FROM rso_mac_tab " +
                    "WHERE cod_mac= ? AND cod_azl = ? ");
            ps.setLong(1, lCOD_MAC);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Long(rs.getLong(1)));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
        return list;
    }
    //----------------------------------------------------
    /* *date:13/04/2004 *author:Roman Chumachenko
    Getting of Riscs List for Agente Chimico
     */
    java.util.ArrayList getRiscsListByAgente(
            long lCOD_SOS_CHI,
            long lCOD_AZL,
            BMPConnection bmp) {
        java.util.ArrayList list = new java.util.ArrayList();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT cod_rso FROM rso_sos_chi_tab " +
                    "WHERE cod_sos_chi= ? AND cod_azl = ? ");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Long(rs.getLong(1)));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
        return list;
    }
    //----------------------------------------------------
    /* *date:08/04/2004 *author:Roman Chumachenko
    isDeletable Association of Risc from Attivita Lavorativa
    if ok :returns boolean true
    if not:returns boolean false
     */
    boolean isDeletableRiscFromAttLavorativa(
            long lCOD_RSO,
            long lCOD_AZL,
            long lCOD_MAN,
            long lCOD_OPE_SVO,
            BMPConnection bmp) {
        boolean result = false;
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    SQLContainer.getIsDeletableRiscFromAttLavorativaQUERY());
            ps.setLong(1, lCOD_MAN);
            ps.setLong(2, lCOD_RSO);
            ps.setLong(3, lCOD_AZL);
            ps.setLong(4, lCOD_MAN);
            ps.setLong(5, lCOD_OPE_SVO);
            ps.setLong(6, lCOD_RSO);
            ps.setLong(7, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                result = true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
        return result;
    }
    //----------------------------------------------------
    /* *date:08/04/2004 *author:Roman Chumachenko
    Deleting Association of Operaziona Svolta from Attivita Lavorativa
     */
    String deleteOpSvoFromAttLavorativa(long lCOD_MAN, long lCOD_OPE_SVO, BMPConnection bmp) {
        String result = "";
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM OPE_SVO_MAN_TAB WHERE " +
                    "COD_MAN=? AND COD_OPE_SVO=?");
            ps.setLong(1, lCOD_MAN);
            ps.setLong(2, lCOD_OPE_SVO);
            ps.executeUpdate();
            ps.close();
            //
            // Eliminazione riga per Rischio chimico
            ps = bmp.prepareStatement(
                    "DELETE FROM rso_chi_tab WHERE COD_MAN=? AND COD_OPE_SVO=?");
            ps.setLong(1, lCOD_MAN);
            ps.setLong(2, lCOD_OPE_SVO);
            ps.executeUpdate();
            ps.close();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            result = ex.toString() + "...FAILED";
        }
        return result;
    }
    //----------------------------------------------------	
    /* *date:08/04/2004 *author:Roman Chumachenko
    Deleting Association of Risc from Operaziona Svolta
     */
    String deleteRiscFromOpSvolta(
            long lCOD_OPE_SVO,
            long lCOD_RSO,
            long lCOD_AZL,
            BMPConnection bmp) {
        String result = "";
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM RSO_OPE_SVO_TAB WHERE " +
                    " COD_OPE_SVO=? AND COD_RSO=? AND COD_AZL=? ");
            ps.setLong(1, lCOD_OPE_SVO);
            ps.setLong(2, lCOD_RSO);
            ps.setLong(3, lCOD_AZL);
            ps.executeUpdate();
        } catch (Exception ex) {
            result = ex.toString() + "...FAILED";
        }
        return result;
    }
    //----------------------------------------------------	
    /* *date:09/04/2004 *author:Roman Chumachenko
    Deleting Association of Macchina from Operaziona Svolta
     */
    String deleteMacchinaFromOpSvolta(
            long lCOD_MAC,
            long lCOD_OPE_SVO,
            BMPConnection bmp) {
        String result = "";
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM MAC_OPE_SVO_TAB WHERE " +
                    " COD_OPE_SVO=? AND COD_MAC=? ");
            ps.setLong(1, lCOD_OPE_SVO);
            ps.setLong(2, lCOD_MAC);
            ps.executeUpdate();
        } catch (Exception ex) {
            result = ex.toString() + "...FAILED";
        }
        return result;
    }
    //----------------------------------------------------	
    /* *date:13/04/2004 *author:Roman Chumachenko
    Deleting Association of Agente Chimico from Operaziona Svolta
     */
    String deleteAgenteFromOpSvolta(
            long lCOD_SOS_CHI,
            long lCOD_OPE_SVO,
            BMPConnection bmp) {
        String result = "";
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM SOS_CHI_OPE_SVO_TAB WHERE " +
                    " COD_OPE_SVO=? AND COD_SOS_CHI=? ");
            ps.setLong(1, lCOD_OPE_SVO);
            ps.setLong(2, lCOD_SOS_CHI);
            ps.executeUpdate();
        } catch (Exception ex) {
            result = ex.toString() + "...FAILED";
        }
        return result;
    }
    //----------------------------------------------------	

    /* *date:09/04/2004 *author:Roman Chumachenko
    IsIncluded current Macchina Attr to Operaziona Svolta
    if ok :returns boolean true
    if not:returns boolean false
     */
    boolean isIncludedMacchinaToOpSvolta(
            long lCOD_MAC,
            long lCOD_OPE_SVO,
            BMPConnection bmp) {
        boolean result = false;
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT COD_MAC FROM MAC_OPE_SVO_TAB WHERE COD_MAC=? AND COD_OPE_SVO=?");
            ps.setLong(1, lCOD_MAC);
            ps.setLong(2, lCOD_OPE_SVO);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                result = true;
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
        return result;
    }
    //-------------------------------------------
    /* *date:13/04/2004 *author:Roman Chumachenko
    Deleting of Risc from Luogo Fisico (with its associations)
     */
    String deleteEXRischioAssFromLuoFsc(
            long lCOD_RSO,
            long lCOD_AZL,
            long lCOD_LUO_FSC,
            BMPConnection bmp) {
        ResultSet REC_PRO_SAN, REC_DPI, REC_COR;
        String result = "";
        //++++++++++++++++++++++++++++++++++++++++++++++
        try {
            //======================PRO_SAN_LUO_FSC============
            PreparedStatement ps_pro_san;
            ps_pro_san = bmp.prepareStatement(
                    "SELECT a.cod_pro_san FROM pro_san_luo_fsc_tab a " +
                    "WHERE a.cod_luo_fsc = ?  " +
                    "AND a.cod_pro_san IN " +
                    "(SELECT b.cod_pro_san FROM pro_san_rso_tab b " +
                    "WHERE b.cod_rso = ? AND b.cod_azl =?) " +
                    "AND a.cod_pro_san NOT IN " +
                    "(SELECT c.cod_pro_san from  pro_san_rso_tab c, rso_luo_fsc_tab d " +
                    "WHERE d.cod_rso=c.cod_rso and d.cod_rso <>? AND d.cod_azl=? AND d.cod_luo_fsc = ?)");
            ps_pro_san.setLong(1, lCOD_LUO_FSC);
            ps_pro_san.setLong(2, lCOD_RSO);
            ps_pro_san.setLong(3, lCOD_AZL);
            ps_pro_san.setLong(4, lCOD_RSO);
            ps_pro_san.setLong(5, lCOD_AZL);
            ps_pro_san.setLong(6, lCOD_LUO_FSC);
            REC_PRO_SAN = ps_pro_san.executeQuery();
            while (REC_PRO_SAN.next()) {
                PreparedStatement ps_pro_san_del = bmp.prepareStatement(
                        "DELETE FROM pro_san_luo_fsc_tab WHERE cod_pro_san = ? AND cod_luo_fsc = ? ");
                ps_pro_san_del.setLong(1, REC_PRO_SAN.getLong(1));
                ps_pro_san_del.setLong(2, lCOD_LUO_FSC);
                ps_pro_san_del.executeUpdate();
            }
            REC_PRO_SAN.close();
            result += "REC_PRO_SAN.close() ";
            //======================DPI_LUO_FSC=====================================
            PreparedStatement ps_dpi = bmp.prepareStatement(
                    "SELECT a.cod_tpl_dpi FROM dpi_luo_fsc_tab a  " +
                    "WHERE a.cod_luo_fsc =?	AND a.cod_tpl_dpi IN  " +
                    "(SELECT b.cod_tpl_dpi FROM dpi_rso_tab b " +
                    "WHERE b.cod_azl = ?  AND b.cod_rso=? )   " +
                    "AND a.cod_tpl_dpi NOT IN " +
                    "(SELECT c.cod_tpl_dpi FROM dpi_rso_tab c, rso_luo_fsc_tab d " +
                    "WHERE d.cod_rso=c.cod_rso AND d.cod_rso <>? AND d.cod_azl=? AND d.cod_luo_fsc = ? )");
            ps_dpi.setLong(1, lCOD_LUO_FSC);
            ps_dpi.setLong(2, lCOD_AZL);
            ps_dpi.setLong(3, lCOD_RSO);
            ps_dpi.setLong(4, lCOD_RSO);
            ps_dpi.setLong(5, lCOD_AZL);
            ps_dpi.setLong(6, lCOD_LUO_FSC);
            REC_DPI = ps_dpi.executeQuery();
            while (REC_DPI.next()) {
                PreparedStatement ps_dpi_del = bmp.prepareStatement(
                        "DELETE FROM dpi_luo_fsc_tab WHERE cod_tpl_dpi = ? AND cod_luo_fsc = ? ");
                ps_dpi_del.setLong(1, REC_DPI.getLong(1));
                ps_dpi_del.setLong(2, lCOD_LUO_FSC);
                ps_dpi_del.executeUpdate();
            }
            REC_DPI.close();
            result += "REC_DPI.close() ";
            //======================COR_LUO_FSC=====================================
            PreparedStatement ps_cor = bmp.prepareStatement(
                    "SELECT a.cod_cor  FROM cor_luo_fsc_tab a  " +
                    "WHERE a.cod_luo_fsc = ? AND a.cod_cor IN  " +
                    "(SELECT b.cod_cor FROM cor_rso_tab b  " +
                    "WHERE b.cod_azl= ? AND b.cod_rso = ?) AND a.cod_cor NOT IN  " +
                    "(SELECT c.cod_cor FROM cor_rso_tab c, rso_luo_fsc_tab d  " +
                    "WHERE d.cod_rso=c.cod_rso and d.cod_rso <>? AND d.cod_azl=? AND d.cod_luo_fsc = ? )");
            ps_cor.setLong(1, lCOD_LUO_FSC);
            ps_cor.setLong(2, lCOD_AZL);
            ps_cor.setLong(3, lCOD_RSO);
            ps_cor.setLong(4, lCOD_RSO);
            ps_cor.setLong(5, lCOD_AZL);
            ps_cor.setLong(6, lCOD_LUO_FSC);
            REC_COR = ps_cor.executeQuery();
            while (REC_COR.next()) {
                PreparedStatement ps_cor_del = bmp.prepareStatement(
                        "DELETE FROM cor_luo_fsc_tab WHERE cod_cor = ? AND cod_luo_fsc = ? ");
                ps_cor_del.setLong(1, REC_COR.getLong(1));
                ps_cor_del.setLong(2, lCOD_LUO_FSC);
                ps_cor_del.executeUpdate();
            }
            REC_COR.close();
            result += "REC_COR.close() ";
            //======== MIS_PET_MAN =================
            PreparedStatement ps_mis_pet_del = bmp.prepareStatement(
                    "DELETE FROM mis_pet_luo_fsc_tab " +
                    " WHERE cod_rso_luo_fsc IN " +
                    "(SELECT h.cod_rso_luo_fsc FROM rso_luo_fsc_tab h WHERE h.cod_azl = ? " +
                    "AND h.cod_luo_fsc = ? AND h.cod_rso = ?)");
            ps_mis_pet_del.setLong(1, lCOD_AZL);
            ps_mis_pet_del.setLong(2, lCOD_LUO_FSC);
            ps_mis_pet_del.setLong(3, lCOD_RSO);
            ps_mis_pet_del.executeUpdate();
            result += "ps_mis_pet_del ";
            //======== RSO_MAN =====================
            PreparedStatement ps_rso_luo_fsc_del = bmp.prepareStatement(
                    "DELETE FROM rso_luo_fsc_tab WHERE cod_azl = ? AND cod_luo_fsc = ? AND cod_rso = ? ");
            ps_rso_luo_fsc_del.setLong(1, lCOD_AZL);
            ps_rso_luo_fsc_del.setLong(2, lCOD_LUO_FSC);
            ps_rso_luo_fsc_del.setLong(3, lCOD_RSO);
            ps_rso_luo_fsc_del.executeUpdate();
            result += "ps_rso_luo_fsc_del ";
        //======================================
        }// /main loop
        catch (Exception ex) {
            result = ex.toString() + "...FAILED";
        }
        //----------------------------------------------------------------------------
        return result;
    }
    //----------------------------------------------------

    /* *date:13/04/2004 *author:Roman Chumachenko
    Getting of Op Svolte List for Macchina Attr
     */
    java.util.ArrayList getOpSvoltaListByMacchina(
            long lCOD_MAC,
            BMPConnection bmp) {
        java.util.ArrayList list = new java.util.ArrayList();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT cod_ope_svo FROM mac_ope_svo_tab " +
                    "WHERE cod_mac= ? ");
            ps.setLong(1, lCOD_MAC);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Long(rs.getLong(1)));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
        return list;
    }
    //----------------------------------------------------

    /* *date:14/04/2004 *author:Roman Chumachenko
    Getting of Op Svolte List for Agente Chimico
     */
    java.util.ArrayList getOpSvoltaListByAgente(
            long lCOD_SOS_CHI,
            BMPConnection bmp) {
        java.util.ArrayList list = new java.util.ArrayList();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT cod_ope_svo FROM sos_chi_ope_svo_tab " +
                    "WHERE cod_sos_chi= ? ");
            ps.setLong(1, lCOD_SOS_CHI);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Long(rs.getLong(1)));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
        return list;
    }
    //----------------------------------------------------
    /* *date:13/04/2004 *author:Roman Chumachenko
    Deleting Association of Risc from Macchina Attr
     */
    String deleteRiscFromMacchina(
            long lCOD_RSO,
            long lCOD_MAC,
            long lCOD_AZL,
            BMPConnection bmp) {
        String result = "";
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM RSO_MAC_TAB WHERE " +
                    " COD_MAC=? AND COD_RSO=? AND COD_AZL=? ");
            ps.setLong(1, lCOD_MAC);
            ps.setLong(2, lCOD_RSO);
            ps.setLong(3, lCOD_AZL);
            ps.executeUpdate();
        } catch (Exception ex) {
            result = ex.toString() + "...FAILED";
        }
        return result;
    }
    //----------------------------------------------------	

    /* *date:14/04/2004 *author:Roman Chumachenko
    Deleting Association of Risc from Agente Chimico
     */
    String deleteRiscFromAgente(
            long lCOD_RSO,
            long lCOD_SOS_CHI,
            long lCOD_AZL,
            BMPConnection bmp) {
        String result = "";
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM RSO_SOS_CHI_TAB WHERE " +
                    " COD_SOS_CHI=? AND COD_RSO=? AND COD_AZL=? ");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_RSO);
            ps.setLong(3, lCOD_AZL);
            ps.executeUpdate();
        } catch (Exception ex) {
            result = ex.toString() + "...FAILED";
        }
        return result;
    }
    //----------------------------------------------------	

    /* *date:13/04/2004 *author:Roman Chumachenko
    Getting of Luoghi Fisici List for Macchina Attr
     */
    java.util.ArrayList getLuoFisiciListByMacchina(
            long lCOD_MAC,
            long lCOD_AZL,
            BMPConnection bmp) {
        java.util.ArrayList list = new java.util.ArrayList();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "a.cod_luo_fsc "
                    + "FROM "
                        + "mac_luo_fsc_tab a, "
                        + "ana_luo_fsc_tab b "
                    + "WHERE "
                        + "a.cod_luo_fsc = b.cod_luo_fsc "
                        + "AND a.cod_mac = ? "
                        + "AND b.cod_azl= ? ");
            ps.setLong(1, lCOD_MAC);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Long(rs.getLong(1)));
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
        return list;
    }
    //----------------------------------------------------
    /* *date:13/04/2004 *author:Roman Chumachenko
    Getting of Luoghi Fisici List for Macchina Attr
     */
    java.util.ArrayList getLuoFisiciListByAgente(
            long lCOD_SOS_CHI,
            long lCOD_AZL,
            BMPConnection bmp) {
        java.util.ArrayList list = new java.util.ArrayList();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "a.cod_luo_fsc "
                    + "FROM "
                        + "sos_chi_luo_fsc_tab a, "
                        + "ana_luo_fsc_tab b "
                    + "WHERE "
                        + "a.cod_luo_fsc = b.cod_luo_fsc "
                        + "AND a.cod_sos_chi = ? "
                        + "AND b.cod_azl= ? ");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Long(rs.getLong(1)));
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
        return list;
    }    
    
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
}

<%--   ======================================================================== --%>
<%--                                                                            --%>
<%-- @copyright Copyright (c) 2010-2015, S2S s.r.l. --%>
<%-- @license   http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2 --%>
<%-- @version   6.0  --%>
<%-- This file is part of SdS - Sistema della Sicurezza  . --%>
<%-- SdS - Sistema della Sicurezza   is free software: you can redistribute it and/or modify --%>
<%-- it under the terms of the GNU General Public License as published by  --%>
<%-- the Free Software Foundation, either version 3 of the License, or  --%>
<%-- (at your option) any later version.  --%>

<%-- SdS - Sistema della Sicurezza  is distributed in the hope that it will be useful, --%>
<%-- but WITHOUT ANY WARRANTY; without even the implied warranty of --%>
<%-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the --%>
<%-- GNU General Public License for more details. --%>

<%-- You should have received a copy of the GNU General Public License --%>
<%-- along with SdS - Sistema della Sicurezza .  If not, see <http://www.gnu.org/licenses/gpl-2.0.html>  GNU Public License v.2 --%>
<%--                                                                            --%>
<%--   ======================================================================== --%>

<%
        /*
        <file>
        <versions>
        <version number="1.0" date="?" author="Kushkarov Yura">
        <comments>
        <comment date="?" author="Kushkarov Yura">
        <description>ErogazioneCorsiBean.jsp</description>
        </comment>
        <comment date="08/03/2004" author="Roman Chumachenko">
        <description>Views for Reports</description>
        </comment>
        <comment date="13/05/2004" author="Treskina Maria">
        <description>izmenenie FindEx dobavlen COD_AZL</description>
        </comment>
        </comments>
        </version>
        </versions>
        </file>
         */
%>

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>
<%!
///////////////ATTENTION!!//////////////////////////////////////////////
//<comment description="Zdes opredeliaetsia realizatzija EJB obiekta"/>
    public class ErogazioneCorsiBean extends BMPEntityBean implements IErogazioneCorsi, IErogazioneCorsiHome {

        long COD_SCH_EGZ_COR;   //1
        long COD_COR;           //2
        String STA_EGZ_COR;       //3
        long COD_AZL;           //4
        java.sql.Date DAT_PIF_EGZ_COR;   //5
//-----------------------------------------
        java.sql.Date DAT_EFT_EGZ_COR;      	//6
        String RAG_SCL_AZL;			//7
        String RAG_SCL_DTE;			//8
        long COD_DPD; 				//9
//-----------------------------------------

        private ErogazioneCorsiBean() {
        }
//-----------------------------------------
        // (Home Interface) create()

        public IErogazioneCorsi create(long lCOD_COR, long lCOD_AZL, String strSTA_EGZ_COR, java.sql.Date dtDAT_PIF_EGZ_COR) throws CreateException {
            ErogazioneCorsiBean bean = new ErogazioneCorsiBean();
            try {
                Object primaryKey = bean.ejbCreate(lCOD_COR, lCOD_AZL, strSTA_EGZ_COR, dtDAT_PIF_EGZ_COR);
                bean.setEntityContext(new EntityContextWrapper(primaryKey));
                bean.ejbPostCreate(lCOD_COR, lCOD_AZL, strSTA_EGZ_COR, dtDAT_PIF_EGZ_COR);
                return bean;
            } catch (Exception ex) {
                throw new javax.ejb.CreateException(ex.getMessage());
            }
        }
        // (Home Intrface) remove()

        public void remove(Object primaryKey) {
            ErogazioneCorsiBean iErogazioneCorsiBean = new ErogazioneCorsiBean();
            try {
                Object obj = iErogazioneCorsiBean.ejbFindByPrimaryKey((Long) primaryKey);
                iErogazioneCorsiBean.setEntityContext(new EntityContextWrapper(obj));
                iErogazioneCorsiBean.ejbActivate();
                iErogazioneCorsiBean.ejbLoad();
                iErogazioneCorsiBean.ejbRemove();
            } catch (Exception ex) {
                throw new EJBException(ex);
            }
        }
        // (Home Interface) findByPrimaryKey()

        public IErogazioneCorsi findByPrimaryKey(Long primaryKey) throws FinderException {
            ErogazioneCorsiBean bean = new ErogazioneCorsiBean();
            try {
                bean.setEntityContext(new EntityContextWrapper(primaryKey));
                bean.ejbActivate();
                bean.ejbLoad();
                return bean;
            } catch (Exception ex) {
                throw new javax.ejb.FinderException(ex.getMessage());
            }
        }
        // (Home Intrface) findAll()

        public Collection findAll() throws FinderException {
            try {
                return this.ejbFindAll();
            } catch (Exception ex) {
                throw new javax.ejb.FinderException(ex.getMessage());
            }
        }
//---------- view

        public Collection getErogazioneCorsiNames_View(long lCOD_AZL) {
            return (new ErogazioneCorsiBean()).ejbGetErogazioneCorsiNames_View(lCOD_AZL);
        }

        public Collection getErogazioneCorsi_SelectData_View() {
            return (new ErogazioneCorsiBean()).ejbGetErogazioneCorsi_SelectData_View();
        }

        public Collection getErogazioneCorsi_ForTabDPD_View(long SCH_EGZ_COR_ID) {
            return (new ErogazioneCorsiBean()).ejbGetErogazioneCorsi_ForTabDPD_View(SCH_EGZ_COR_ID);
        }

        public Collection getErogazioneCorsi_ForAssocia_View(long COR_ID, long AZL_ID) {
            return (new ErogazioneCorsiBean()).ejbGetErogazioneCorsi_ForAssocia_View(COR_ID, AZL_ID);
        }

        public String getErogazioneCorsi_ForTabByAZL_View(long AZL_ID) {
            return ejbGetErogazioneCorsi_ForTabByAZL_View(AZL_ID);
        }

        public String getErogazioneCorsi_ForTabByDTE_View(long DTE_ID) {
            return ejbGetErogazioneCorsi_ForTabByDTE_View(DTE_ID);
        }

        public Collection getErogazioneCorsi_DTEGet_View() {
            return (new ErogazioneCorsiBean()).ejbGetErogazioneCorsi_DTEGet_View();
        }
//--- Podmasteriev------------- 

        public Collection getScadenzario_Corsi_View(long lCOD_AZL, long lNOM_COR, String lNOM_DCT, java.sql.Date dDAT_PIF_EGZ_COR_DAL, java.sql.Date dDAT_PIF_EGZ_COR_AL, String strSTA_INT, java.sql.Date dEFF_DAT_DAL, java.sql.Date dEFF_DAT_AL, String strRAGGRUPPATI, String strTYPE) {
            return (new ErogazioneCorsiBean()).ejbGetScadenzario_Corsi_View(lCOD_AZL, lNOM_COR, lNOM_DCT, dDAT_PIF_EGZ_COR_DAL, dDAT_PIF_EGZ_COR_AL, strSTA_INT, dEFF_DAT_DAL, dEFF_DAT_AL, strRAGGRUPPATI, strTYPE);
        }
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

        //</IErogazioneCorsiHome-implementation>
        public Long ejbCreate(long lCOD_COR, long lCOD_AZL, String strSTA_EGZ_COR, java.sql.Date dtDAT_PIF_EGZ_COR) {
            this.COD_COR = lCOD_COR;
            this.COD_AZL = lCOD_AZL;
            this.STA_EGZ_COR = strSTA_EGZ_COR;
            this.DAT_PIF_EGZ_COR = dtDAT_PIF_EGZ_COR;
            this.COD_SCH_EGZ_COR = NEW_ID(); // unic ID
            this.unsetModified();
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement("INSERT INTO sch_egz_cor_tab (cod_sch_egz_cor,cod_cor,cod_azl,sta_egz_cor,dat_pif_egz_cor) VALUES(?,?,?,?,?)");
                ps.setLong(1, COD_SCH_EGZ_COR);
                ps.setLong(2, COD_COR);
                ps.setLong(3, COD_AZL);
                ps.setString(4, STA_EGZ_COR);
                ps.setDate(5, DAT_PIF_EGZ_COR);
                ps.executeUpdate();
                return new Long(COD_SCH_EGZ_COR);
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }

//-------------------------------------------------------   
        public void ejbPostCreate(long lCOD_COR, long lCOD_AZL, String strSTA_EGZ_COR, java.sql.Date dtDAT_PIF_EGZ_COR) {
        }
//--------------------------------------------------

        public Collection ejbFindAll() {
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement("SELECT cod_sch_egz_cor FROM sch_egz_cor_tab ");
                ResultSet rs = ps.executeQuery();
                java.util.ArrayList al = new java.util.ArrayList();
                while (rs.next()) {
                    al.add(new Long(rs.getLong(1)));
                }
                return al;
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }

//-----------------------------------------------------------
        public Long ejbFindByPrimaryKey(Long primaryKey) {
            return primaryKey;
        }
//----------------------------------------------------------

        public void ejbActivate() {
            this.COD_SCH_EGZ_COR = ((Long) this.getEntityKey()).longValue();
        }
//----------------------------------------------------------

        public void ejbPassivate() {
            this.COD_SCH_EGZ_COR = -1;
        }
//----------------------------------------------------------

        public void ejbLoad() {
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement("SELECT * FROM sch_egz_cor_tab  WHERE cod_sch_egz_cor=?");
                ps.setLong(1, COD_SCH_EGZ_COR);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    this.COD_SCH_EGZ_COR = rs.getLong("COD_SCH_EGZ_COR");
                    this.DAT_PIF_EGZ_COR = rs.getDate("DAT_PIF_EGZ_COR");
                    this.DAT_EFT_EGZ_COR = rs.getDate("DAT_EFT_EGZ_COR");
                    this.COD_COR = rs.getLong("COD_COR");
                    this.COD_AZL = rs.getLong("COD_AZL");
                    this.STA_EGZ_COR = rs.getString("STA_EGZ_COR");
                } else {
                    throw new NoSuchEntityException("COD_SCH_EGZ_COR con ID= non è trovata");
                }
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }
//----------------------------------------------------------
//----------------------------------------------------------

        public void ejbRemove() {
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement("DELETE FROM sch_egz_cor_tab  WHERE cod_sch_egz_cor=?");
                ps.setLong(1, COD_SCH_EGZ_COR);
                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Tipologie Macchine con ID= non è trovata");
                }
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }
//----------------------------------------------------------

        public void ejbStore() {
            if (!isModified()) {
                return;
            }
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement("UPDATE sch_egz_cor_tab  SET cod_sch_egz_cor=?, dat_pif_egz_cor=?, dat_eft_egz_cor=?, cod_azl=?, sta_egz_cor=?, cod_cor=? WHERE cod_sch_egz_cor=?");
                ps.setLong(1, COD_SCH_EGZ_COR);        //1
                ps.setDate(2, DAT_PIF_EGZ_COR);            //2
                ps.setDate(3, DAT_EFT_EGZ_COR);                //3
                ps.setLong(4, COD_AZL);                //4
                ps.setString(5, STA_EGZ_COR);            //5
                ps.setLong(6, COD_COR);            //6
                ps.setLong(7, COD_SCH_EGZ_COR);        //7
                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Tipologie Macchine con ID= non è trovata");
                }
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>

//<comment description="Update Method">  
        public void Update() {
            setModified();
        }
//<comment

//<comment description="setter/getters">
        //1
        public long getCOD_SCH_EGZ_COR() {
            return COD_SCH_EGZ_COR;
        }

        //2
        //3
        public void setCOD_COR(long newCOD_COR) {
            if (COD_COR == newCOD_COR) {
                return;
            }
            COD_COR = newCOD_COR;
            setModified();
        }

        public long getCOD_COR() {
            return COD_COR;
        }
        //4

        public void setSTA_EGZ_COR(String newSTA_EGZ_COR) {
            if (STA_EGZ_COR.equals(newSTA_EGZ_COR)) {
                return;
            }
            STA_EGZ_COR = newSTA_EGZ_COR;
            setModified();
        }

        public String getSTA_EGZ_COR() {
            return STA_EGZ_COR;
        }

        //6
        public void setDAT_PIF_EGZ_COR(java.sql.Date newDAT_PIF_EGZ_COR) {
            if (DAT_PIF_EGZ_COR.equals(newDAT_PIF_EGZ_COR)) {
                return;
            }
            DAT_PIF_EGZ_COR = newDAT_PIF_EGZ_COR;
            setModified();
        }

        public java.sql.Date getDAT_PIF_EGZ_COR() {
            return DAT_PIF_EGZ_COR;
        }
        //5

        public void setCOD_AZL(long newCOD_AZL) {
            if (COD_AZL == newCOD_AZL) {
                return;
            }
            COD_AZL = newCOD_AZL;
            setModified();
        }

        public long getCOD_AZL() {
            return COD_AZL;
        }
        //============================================
        // not required field

        //7
        public void setDAT_EFT_EGZ_COR(java.sql.Date newDAT_EFT_EGZ_COR) {
            if ((DAT_EFT_EGZ_COR != null) && (DAT_EFT_EGZ_COR.equals(newDAT_EFT_EGZ_COR))) {
                return;
            }
            DAT_EFT_EGZ_COR = newDAT_EFT_EGZ_COR;
            setModified();
        }

        public java.sql.Date getDAT_EFT_EGZ_COR() {
            return DAT_EFT_EGZ_COR;
        }
        //</comment>

        public Collection ejbGetErogazioneCorsiNames_View(long lCOD_AZL) {
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement("SELECT a.dat_pif_egz_cor,a.dat_eft_egz_cor,a.cod_sch_egz_cor,a.cod_cor,a.sta_egz_cor,b.dur_cor_gor,b.des_cor,b.nom_cor,c.nom_tpl_cor FROM sch_egz_cor_tab a,ana_cor_tab b,tpl_cor_tab c WHERE a.cod_cor=b.cod_cor AND  b.cod_tpl_cor = c.cod_tpl_cor AND a.cod_azl=? ORDER BY b.nom_cor ");
                ps.setLong(1, lCOD_AZL);

                ResultSet rs = ps.executeQuery();
                java.util.ArrayList al = new java.util.ArrayList();
                while (rs.next()) {
                    ErogazioneCorsiNames_View obj = new ErogazioneCorsiNames_View();
                    obj.DAT_PIF_EGZ_COR = rs.getDate(1);
                    obj.DAT_EFT_EGZ_COR = rs.getDate(2);
                    obj.COD_SCH_EGZ_COR = rs.getLong(3);
                    obj.COD_COR = rs.getLong(4);
                    obj.STA_EGZ_COR = rs.getString(5);
                    obj.DUR_COR_GOR = rs.getLong(6);
                    obj.DES_COR = rs.getString(7);
                    obj.NOM_COR = rs.getString(8);
                    obj.NOM_TPL_COR = rs.getString(9);
                    al.add(obj);
                }
                bmp.close();
                return al;
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }

        public Collection ejbGetErogazioneCorsi_SelectData_View() {
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement("SELECT a.cod_tpl_cor,a.cod_cor, a.nom_cor, a.dur_cor_gor, b.nom_tpl_cor FROM ana_cor_tab a, tpl_cor_tab b WHERE  a.cod_tpl_cor=b.cod_tpl_cor ORDER BY a.nom_cor ");
                //ps.setLong(1, LOT_DPI_ID);

                ResultSet rs = ps.executeQuery();
                java.util.ArrayList al = new java.util.ArrayList();
                while (rs.next()) {
                    ErogazioneCorsi_SelectData_View obj = new ErogazioneCorsi_SelectData_View();
                    obj.COD_TPL_COR = rs.getLong(1);
                    obj.COD_COR = rs.getLong(2);
                    obj.NOM_COR = rs.getString(3);
                    obj.DUR_COR_GOR = rs.getLong(4);
                    obj.NOM_TPL_COR = rs.getString(5);
                    al.add(obj);
                }
                bmp.close();
                return al;
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }

        public Collection ejbGetErogazioneCorsi_ForTabDPD_View(long COD_SCH_EGZ_COR) {
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement("SELECT a.cod_dpd, a.cog_dpd, a.nom_dpd, a.mtr_dpd, a.cod_dte, b.cod_dpd FROM view_ana_dpd_tab a, isc_cor_tab b WHERE a.cod_dpd = b.cod_dpd AND a.cod_azl = b.cod_azl AND b.cod_sch_egz_cor = ? ORDER BY a.cog_dpd ");
                ps.setLong(1, COD_SCH_EGZ_COR);

                ResultSet rs = ps.executeQuery();
                java.util.ArrayList al = new java.util.ArrayList();
                while (rs.next()) {
                    ErogazioneCorsi_ForTabDPD_View obj = new ErogazioneCorsi_ForTabDPD_View();
                    obj.COD_DPD = rs.getLong(1);
                    obj.COG_DPD = rs.getString(2);
                    obj.NOM_DPD = rs.getString(3);
                    obj.MTR_DPD = rs.getString(4);
                    obj.COD_DTE = rs.getLong(5);
                    obj.COD_AZL = rs.getLong(6);
                    al.add(obj);
                }
                bmp.close();
                return al;
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }

        public Collection ejbGetErogazioneCorsi_ForAssocia_View(long COD_AZL, long COD_COR) {
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement("SELECT DISTINCT   a.nom_dpd, a.cog_dpd, a.cod_dpd, b.nom_cor, b.cod_cor, f.cod_sch_egz_cor, f.dat_pif_egz_cor FROM view_ana_dpd_tab a, ana_cor_tab b, cor_dpd_tab c, sch_egz_cor_tab f WHERE b.cod_cor = ? AND a.cod_dpd = c.cod_dpd AND b.cod_cor = c.cod_cor AND a.cod_azl = ? AND c.cod_azl = ? AND (f.dat_eft_egz_cor IS NULL OR f.dat_eft_egz_cor > NOW()) AND (c.cod_cor, f.cod_sch_egz_cor) IN (SELECT h.cod_cor, h.cod_sch_egz_cor FROM sch_egz_cor_tab h WHERE h.cod_azl = ? AND h.cod_sch_egz_cor NOT IN (SELECT n.cod_sch_egz_cor FROM isc_cor_tab n WHERE n.cod_dpd = a.cod_dpd AND n.cod_azl = ?))");
                ps.setLong(1, COD_COR);
                ps.setLong(2, COD_AZL);
                ps.setLong(3, COD_AZL);
                ps.setLong(4, COD_AZL);
                ps.setLong(5, COD_AZL);

                ResultSet rs = ps.executeQuery();
                java.util.ArrayList al = new java.util.ArrayList();
                while (rs.next()) {
                    ErogazioneCorsi_ForAssocia_View obj = new ErogazioneCorsi_ForAssocia_View();
                    obj.NOM_DPD = rs.getString(1);
                    obj.COG_DPD = rs.getString(2);
                    obj.COD_DPD = rs.getLong(3);
                    obj.NOM_COR = rs.getString(4);
                    obj.COD_COR = rs.getLong(5);
                    obj.COD_SCH_EGZ_COR = rs.getLong(6);
                    obj.DAT_PIF_EGZ_COR = rs.getDate(7);
                    al.add(obj);
                }
                bmp.close();
                return al;
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }

        public String ejbGetErogazioneCorsi_ForTabByAZL_View(long COD_AZL) {
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement("SELECT rag_scl_azl FROM ana_azl_tab WHERE cod_azl = ? ");
                ps.setLong(1, COD_AZL);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    RAG_SCL_AZL = rs.getString("RAG_SCL_AZL");
                }
                bmp.close();
                return RAG_SCL_AZL;
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }

        public String ejbGetErogazioneCorsi_ForTabByDTE_View(long COD_DTE) {
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement("SELECT rag_scl_dte FROM ana_dte_tab WHERE cod_dte = ? ");
                ps.setLong(1, COD_DTE);

                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    RAG_SCL_DTE = rs.getString("RAG_SCL_DTE");
                }
                bmp.close();
                return RAG_SCL_DTE;
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }

        public void addISC_COR_DPD(long newCOD_SCH_EGZ_COR, long newCOD_DPD, long newCOD_AZL) {
            this.COD_SCH_EGZ_COR = newCOD_SCH_EGZ_COR;
            this.COD_DPD = newCOD_DPD;
            this.COD_AZL = newCOD_AZL;
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement("INSERT INTO isc_cor_tab (cod_sch_egz_cor,cod_dpd,cod_azl) VALUES(?,?,?)");
                ps.setLong(1, COD_SCH_EGZ_COR);
                ps.setLong(2, COD_DPD);
                ps.setLong(3, COD_AZL);
                ps.executeUpdate();
            //return new Long(COD_DMD);
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }

        public void addCOR_DPD(long newCOD_COR, long newCOD_DPD, long newCOD_AZL, java.sql.Date newDAT_EFT_COR) {
            BMPConnection bmp = getConnection();
            try {

                PreparedStatement ps = bmp.prepareStatement("INSERT INTO " +
                        "cor_dpd_tab (mat_csg,esi_tes_vrf,ate_fre_dpd,cod_dpd,cod_cor,cod_azl,dat_eft_cor)" +
                        " VALUES('N','D','N',?,?,?,?)");
                ps.setLong(1, newCOD_DPD);
                ps.setLong(2, newCOD_COR);
                ps.setLong(3, newCOD_AZL);
                ps.setDate(4, newDAT_EFT_COR);
                ps.executeUpdate();

            } catch (Exception ex) {
                ex.printStackTrace();
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }
        //

        public Collection ejbGetErogazioneCorsi_DTEGet_View() {
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement("SELECT cod_dte, rag_scl_dte FROM ana_dte_tab");
                ResultSet rs = ps.executeQuery();
                java.util.ArrayList al = new java.util.ArrayList();
                while (rs.next()) {
                    ErogazioneCorsi_DTEGet_View obj = new ErogazioneCorsi_DTEGet_View();
                    obj.COD_DTE = rs.getLong(1);
                    obj.RAG_SCL_DTE = rs.getString(2);
                    al.add(obj);
                }
                bmp.close();
                return al;
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }
        //

        public void removeCOR_DPD(long newCOD_COR, long newCOD_DPD, long newCOD_AZL, java.sql.Date newDAT_EFT_COR) {
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement("DELETE FROM cor_dpd_tab  " +
                        "WHERE cod_cor=? AND cod_dpd=? " +
                        "AND cod_azl=? AND dat_eft_cor=?");
                ps.setLong(1, newCOD_COR);
                ps.setLong(2, newCOD_DPD);
                ps.setLong(3, newCOD_AZL);
                ps.setDate(4, newDAT_EFT_COR);
                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Risposte con ID non &egrave trovata");
                }
            } catch (Exception ex) {
                ex.printStackTrace();
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }
        //

        public void removeISC_COR_DPD(long newCOD_SCH_EGZ_COR, long newCOD_DPD, long newCOD_AZL) {
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement("DELETE FROM isc_cor_tab  WHERE cod_sch_egz_cor=? AND cod_dpd=? AND cod_azl=?");
                ps.setLong(1, newCOD_SCH_EGZ_COR);
                ps.setLong(2, newCOD_DPD);
                ps.setLong(3, newCOD_AZL);
                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Risposte con ID non &egrave trovata");
                }
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }
/////////////////////VIEW By Podmasteriv in SCH_COR form////////////////////////////////////
        public Collection ejbGetScadenzario_Corsi_View(long lCOD_AZL, long lNOM_COR, String lNOM_DCT, java.sql.Date dDAT_PIF_EGZ_COR_DAL, java.sql.Date dDAT_PIF_EGZ_COR_AL, String strSTA_INT, java.sql.Date dEFF_DAT_DAL, java.sql.Date dEFF_DAT_AL, String strRAGGRUPPATI, String strTYPE) {

            int icounterWhere = 2;
            int iCOUNT_NOM_COR = 0, iCOUNT_NOM_DCT = 0, iCOUNT_DAT_PIF_EGZ_COR_DAL = 0, iCOUNT_DAT_PIF_EGZ_COR_AL = 0, iCOUNT_EFF_DAT_DAL = 0, iCOUNT_EFF_DAT_AL = 0;
            String strFROM = "", strWHERE = "", strGROUP = "";

            //--- Nome Corso organizativa

            if (lNOM_COR != 0) {
                iCOUNT_NOM_COR = icounterWhere;
                icounterWhere++;
                strFROM = strFROM + " ,ana_cor_tab b ";
                strWHERE = strWHERE + " WHERE cod_cor = ? ";
            }

            //--- Docente Corso organizativa

            if (lNOM_DCT != "") {
                iCOUNT_NOM_DCT = icounterWhere;
                icounterWhere++;
                strFROM = strFROM + " ,dct_cor_tab c ";
                if (lNOM_COR == 0) {
                    strWHERE = strWHERE + " WHERE nom_dct LIKE ? ";
                } else {
                    strWHERE = strWHERE + " AND nom_dct LIKE ? ";
                }
            }

            //--- DATA PIANIFICAZIONE VISITA


            if ((dDAT_PIF_EGZ_COR_DAL != null) && (dDAT_PIF_EGZ_COR_AL != null)) {
                iCOUNT_DAT_PIF_EGZ_COR_DAL = icounterWhere;
                icounterWhere++;
                iCOUNT_DAT_PIF_EGZ_COR_AL = icounterWhere;
                icounterWhere++;
                if (lNOM_COR == 0 && lNOM_DCT == "") {
                    strWHERE = strWHERE + " WHERE dat_pif_egz_cor BETWEEN ? AND ? ";
                } else {
                    strWHERE = strWHERE + " AND dat_pif_egz_cor BETWEEN ? AND ? ";
                }
            }

            if ((dDAT_PIF_EGZ_COR_DAL != null) && (dDAT_PIF_EGZ_COR_AL == null)) {
                iCOUNT_DAT_PIF_EGZ_COR_DAL = icounterWhere;
                icounterWhere++;
                if (lNOM_COR == 0 && lNOM_DCT == "") {
                    strWHERE = strWHERE + " WHERE dat_pif_egz_cor >= ? ";
                } else {
                    strWHERE = strWHERE + " AND dat_pif_egz_cor >= ? ";
                }
            }

            if ((dDAT_PIF_EGZ_COR_DAL == null) && (dDAT_PIF_EGZ_COR_AL != null)) {
                iCOUNT_DAT_PIF_EGZ_COR_AL = icounterWhere;
                icounterWhere++;
                if (lNOM_COR == 0 && lNOM_DCT == "") {
                    strWHERE = strWHERE + " WHERE dat_pif_egz_cor <= ? ";
                } else {
                    strWHERE = strWHERE + " AND dat_pif_egz_cor <= ? ";
                }
            }
            //--- DATA EFFETTUAZIONE

            if ((dEFF_DAT_DAL != null) && (dEFF_DAT_AL != null)) {
                iCOUNT_EFF_DAT_DAL = icounterWhere;
                icounterWhere++;
                iCOUNT_EFF_DAT_AL = icounterWhere;
                icounterWhere++;
                if (lNOM_COR == 0 && lNOM_DCT == "" && dDAT_PIF_EGZ_COR_DAL == null && dDAT_PIF_EGZ_COR_AL == null) {
                    strWHERE = strWHERE + " WHERE dat_eft_egz_cor BETWEEN ? AND ? ";
                } else {
                    strWHERE = strWHERE + " AND dat_eft_egz_cor BETWEEN ? AND ? ";
                }
            }
            if ((dEFF_DAT_DAL != null) && (dEFF_DAT_AL == null)) {
                iCOUNT_EFF_DAT_DAL = icounterWhere;
                icounterWhere++;
                if (lNOM_COR == 0 && lNOM_DCT == "" && dDAT_PIF_EGZ_COR_DAL == null && dDAT_PIF_EGZ_COR_AL == null) {
                    strWHERE = strWHERE + " WHERE dat_eft_egz_cor >= ? ";
                } else {
                    strWHERE = strWHERE + " AND dat_eft_egz_cor >= ? ";
                }
            }
            if ((dEFF_DAT_DAL == null) && (dEFF_DAT_AL != null)) {
                iCOUNT_EFF_DAT_AL = icounterWhere;
                icounterWhere++;
                if (lNOM_COR == 0 && lNOM_DCT == "" && dDAT_PIF_EGZ_COR_DAL == null && dDAT_PIF_EGZ_COR_AL == null) {
                    strWHERE = strWHERE + " WHERE dat_eft_egz_cor <= ? ";
                } else {
                    strWHERE = strWHERE + " AND dat_eft_egz_cor <= ? ";
                }
            }
            //--- Stato misura
            if (lNOM_COR == 0 && lNOM_DCT == "" && dDAT_PIF_EGZ_COR_DAL == null && dDAT_PIF_EGZ_COR_AL == null && dEFF_DAT_DAL == null && dEFF_DAT_AL == null) {
                if (strSTA_INT.equals("G")) {
                    strWHERE = strWHERE + " WHERE dat_eft_egz_cor IS NOT NULL ";
                }
                if (strSTA_INT.equals("D")) {
                    strWHERE = strWHERE + " WHERE dat_eft_egz_cor IS NULL  ";
                    dEFF_DAT_DAL = null;
                    dEFF_DAT_AL = null;
                }
            } else {
                if (strSTA_INT.equals("G")) {
                    strWHERE = strWHERE + " AND dat_eft_egz_cor IS NOT NULL ";
                }
                if (strSTA_INT.equals("D")) {
                    strWHERE = strWHERE + " AND dat_eft_egz_cor IS NULL  ";
                    dEFF_DAT_DAL = null;
                    dEFF_DAT_AL = null;
                }
            }
            //*** ORDER ***//
            //--- Raggruppati = N
            String VAR_ORDER = "";
            String strSOR = "";
            if (!"".equals(strTYPE)) {
                if ("INRup".equals(strTYPE)) {
                    strSOR = ", dat_pif_egz_cor,dat_eft_egz_cor ";
                    VAR_ORDER = " ORDER BY dat_pif_egz_cor,dat_eft_egz_cor ";
                }
                if ("EFTup".equals(strTYPE)) {
                    strSOR = ",dat_eft_egz_cor ";
                    VAR_ORDER = " ORDER BY dat_eft_egz_cor,dat_eft_egz_cor ";
                }
                if ("INRdw".equals(strTYPE)) {
                    strSOR = ", dat_pif_egz_cor DESC ";
                    VAR_ORDER = " ORDER BY dat_pif_egz_cor,dat_eft_egz_cor DESC ";
                }
                if ("EFTdw".equals(strTYPE)) {
                    strSOR = ", dat_eft_egz_cor DESC ";
                    VAR_ORDER = " ORDER BY dat_eft_egz_cor DESC ";
                }
            }
            //strSORT_DAT_PIF=strSORT_DAT_PIF.replaceAll("\'","\\");
            //strSORT_DAT_EFT=strSORT_DAT_EFT.replaceAll("\'","\\");
            if (strRAGGRUPPATI.equals("N")) {
                strGROUP = VAR_ORDER;
            }
            //--- Raggruppati = C
            if (strRAGGRUPPATI.equals("C")) {
                strGROUP = " ORDER BY nom_cor " + strSOR;

            }

            //--- Raggruppati = D
            if (strRAGGRUPPATI.equals("D")) {
                strGROUP = " ORDER BY  nom_dct" + strSOR;

            }

            //--- Raggruppati = A
            if (strRAGGRUPPATI.equals("A")) {
                strGROUP = " ORDER BY rag_scl_azl " + strSOR;

            }

           BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps=bmp.prepareStatement
                    (SQLContainer.getEjbGetScadenzario_Corsi_View()+ strWHERE + strGROUP );
                    
                 ps.setLong(1, lCOD_AZL);

                if (iCOUNT_NOM_COR != 0) {
                    ps.setLong(iCOUNT_NOM_COR, lNOM_COR);
                }
                if (iCOUNT_NOM_DCT != 0) {
                    ps.setString(iCOUNT_NOM_DCT, lNOM_DCT + "%");
                }
                if (iCOUNT_DAT_PIF_EGZ_COR_DAL != 0) {
                    ps.setDate(iCOUNT_DAT_PIF_EGZ_COR_DAL, dDAT_PIF_EGZ_COR_DAL);
                }
                if (iCOUNT_DAT_PIF_EGZ_COR_AL != 0) {
                    ps.setDate(iCOUNT_DAT_PIF_EGZ_COR_AL, dDAT_PIF_EGZ_COR_AL);
                }
                if (iCOUNT_EFF_DAT_DAL != 0) {
                    ps.setDate(iCOUNT_EFF_DAT_DAL, dEFF_DAT_DAL);
                }
                if (iCOUNT_EFF_DAT_AL != 0) {
                    ps.setDate(iCOUNT_EFF_DAT_AL, dEFF_DAT_AL);
                }

                ResultSet rs = ps.executeQuery();

                java.util.ArrayList al = new java.util.ArrayList();
                String cor = "";
                java.sql.Date dat_pif = null;
                while (rs.next()) {
                    Scadenzario_Corsi_View obj = new Scadenzario_Corsi_View();

                        obj.COD_SCH_EGZ_COR = rs.getLong(1);
                        obj.COD_COR = rs.getLong(2);
                        obj.DAT_PIF_EGZ_COR = rs.getDate(3);
                        obj.DAT_EFT_EGZ_COR = rs.getDate(4);
                        obj.NOM_COR = rs.getString(5);
                        obj.NOM_DCT = rs.getString(6);
                        obj.RAG_SCL_AZL = rs.getString(7);
                        obj.COD_AZL = rs.getLong(8);
                        al.add(obj);
                        dat_pif = rs.getDate(3);
                        cor = rs.getString(5);
                     }

                bmp.close();
                return al;
            } catch (Exception ex)
                    {
                ex.printStackTrace();
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }



//---------------------------------------------------------------------
        public Collection getErogazioneForCorso_View() {
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(
                        "SELECT " +
                        " b.nom_cor, " +
                        " b.des_cor, " +
                        " b.dur_cor_gor , " +
                        " CASE b.uso_ptg_cor WHEN 'S' THEN 'SI' " +
                        "WHEN 'N' THEN 'NO' END , " +
                        " CASE b.uso_ate_fre_cor WHEN 'S' THEN 'SI' " +
                        "WHEN 'N' THEN 'NO' END , " +
                        " a.dat_pif_egz_cor , " +
                        " a.dat_eft_egz_cor, " +
                        " a.sta_egz_cor " +
                        " FROM sch_egz_cor_tab a, ana_cor_tab b " +
                        " WHERE (a.COD_SCH_EGZ_COR = ? AND a.COD_COR = b.COD_COR )");
                ps.setLong(1, this.COD_SCH_EGZ_COR);
                ResultSet rs = ps.executeQuery();
                java.util.ArrayList al = new java.util.ArrayList();
                while (rs.next()) {
                    ErogazioneForCorso_View obj = new ErogazioneForCorso_View();
                    obj.NOM_COR = rs.getString(1);
                    obj.DES_COR = rs.getString(2);
                    obj.DUR_COR = rs.getLong(3);
                    obj.USO_PTG_COR = rs.getString(4);
                    obj.USO_ATE_FRE_COR = rs.getString(5);
                    obj.DAT_PIF_EGZ_COR = rs.getDate(6);
                    obj.DAT_EFT_EGZ_COR = rs.getDate(7);
                    obj.STA_EGZ_COR = rs.getString(8);
                    al.add(obj);
                }
                return al;
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }
        //---------------------------------------------------------------------


//=============by Juli======
        public Collection findEx(
                Long lCOD_AZL,
                Long lCOD_COR,
                java.sql.Date dtDAT_PIF_EGZ_COR,
                java.sql.Date dtDAT_EFT_EGZ_COR,
                String strNB_DUR_COR_GOR,
                String strSTA_EGZ_COR,
                String strNB_NOM_TPL_COR,
                int iOrderBy) {
            return ejbFindEx(
                    lCOD_AZL,
                    lCOD_COR,
                    dtDAT_PIF_EGZ_COR,
                    dtDAT_EFT_EGZ_COR,
                    strNB_DUR_COR_GOR,
                    strSTA_EGZ_COR,
                    strNB_NOM_TPL_COR,
                    iOrderBy);
        }
        //

        public Collection ejbFindEx(
                Long lCOD_AZL,
                Long lCOD_COR,
                java.sql.Date dtDAT_PIF_EGZ_COR,
                java.sql.Date dtDAT_EFT_EGZ_COR,
                String strNB_DUR_COR_GOR,
                String strSTA_EGZ_COR,
                String strNB_NOM_TPL_COR,
                int iOrderBy) {
            String strSql = " SELECT nom_cor,dat_pif_egz_cor,dat_eft_egz_cor,  " +
                    " a.cod_sch_egz_cor,a.cod_cor,a.sta_egz_cor, b.dur_cor_gor,  " +
                    " b.des_cor,b.nom_cor,c.nom_tpl_cor  " +
                    " FROM sch_egz_cor_tab a,ana_cor_tab b, tpl_cor_tab c  " +
                    " WHERE a.cod_cor=b.cod_cor AND  b.cod_tpl_cor = c.cod_tpl_cor  ";
            if (lCOD_AZL != null) {
                strSql += " AND a.cod_azl=?   ";
            }
            if (lCOD_COR != null) {
                strSql += " AND a.cod_cor=?   ";
            }
            if (dtDAT_PIF_EGZ_COR != null) {
                strSql += " AND  dat_pif_egz_cor = ?  ";
            }
            if (dtDAT_EFT_EGZ_COR != null) {
                strSql += " AND  dat_eft_egz_cor = ?  ";
            }
            if (strNB_DUR_COR_GOR != null) {
                strSql += " AND  UPPER(dur_cor_gor) LIKE ?  ";
            }
            if (strSTA_EGZ_COR != null) {
                strSql += " AND  UPPER(sta_egz_cor) LIKE ?  ";
            }
            if (strNB_NOM_TPL_COR != null) {
                strSql += " AND   UPPER(nom_tpl_cor) LIKE ?  ";
            }
            int i = 1;
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(strSql);
                if (lCOD_AZL != null) {
                    ps.setLong(i++, lCOD_AZL.longValue());
                }
                if (lCOD_COR != null) {
                    ps.setLong(i++, lCOD_COR.longValue());
                }
                if (dtDAT_PIF_EGZ_COR != null) {
                    ps.setDate(i++, dtDAT_PIF_EGZ_COR);
                }
                if (dtDAT_EFT_EGZ_COR != null) {
                    ps.setDate(i++, dtDAT_EFT_EGZ_COR);
                }
                if (strNB_DUR_COR_GOR != null) {
                    ps.setString(i++, strNB_DUR_COR_GOR.toUpperCase());
                }
                if (strSTA_EGZ_COR != null) {
                    ps.setString(i++, strSTA_EGZ_COR.toUpperCase());
                }
                if (strNB_NOM_TPL_COR != null) {
                    ps.setString(i++, strNB_NOM_TPL_COR.toUpperCase());
                }
                //----------------------------------------------------------------------
                ResultSet rs = ps.executeQuery();
                java.util.ArrayList ar = new java.util.ArrayList();
                while (rs.next()) {
                    ErogazioneCorsiNames_View v = new ErogazioneCorsiNames_View();
                    v.NOM_COR = rs.getString(1);
                    v.DAT_PIF_EGZ_COR = rs.getDate(2);
                    v.DAT_EFT_EGZ_COR = rs.getDate(3);
                    v.COD_SCH_EGZ_COR = rs.getLong(4);
                    v.DUR_COR_GOR = rs.getLong(7);
                    v.DES_COR = rs.getString(8);
                    ar.add(v);
                }
                return ar;
            //----------------------------------------------------------------------
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }
    }//<comment description="end of implementation  ErogazioneCorsiBean"/>
%>
<%
////////////////////////////////////////// <BINDING> ////////////////////
        PseudoContext.bind("ErogazioneCorsiBean", new ErogazioneCorsiBean());////
/////////////////////////////////////////////////////////////////////////
%>

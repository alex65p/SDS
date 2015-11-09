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

package com.apconsulting.luna.ejb.Presidi;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import javax.ejb.EJBException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;

/**
 *
 * @author Alessandro
 */

public class PresidiBean extends BMPEntityBean implements IPresidi, IPresidiHome
{
  //<member-varibles description="Member Variables">
	long lCOD_PSD_ACD;
	long lCOD_CAG_PSD_ACD;
	String strIDE_PSD_ACD;
	java.sql.Date dtDAT_ULT_CTL;
	String strESI_ULT_CTL;
	long lCOD_LUO_FSC;
	String strSTA_PSD_ACD;
  //</member-varibles>

 //<IPresidiHome-implementation>
      public static final String BEAN_NAME="PresidiBean";

///////////////////// CONSTRUCTOR///////////////////
    private static PresidiBean ys = null;

    private PresidiBean() {
        //
    }

    public static PresidiBean getInstance() {
        if (ys == null) {
            ys = new PresidiBean();
        }
        return ys;
    }
    
    @Override
      public void remove(Object primaryKey){
            PresidiBean bean=new PresidiBean();
            try{
              Object obj=bean.ejbFindByPrimaryKey((Long)primaryKey);
              bean.setEntityContext(new EntityContextWrapper(obj));
              bean.ejbActivate();
              bean.ejbLoad();
              bean.ejbRemove();
            }
            catch(Exception ex){
              throw new EJBException(ex);
            }
      }

      public IPresidi create(long lCOD_CAG_PSD_ACD, String strIDE_PSD_ACD, long lCOD_LUO_FSC, String strSTA_PSD_ACD) throws javax.ejb.CreateException {
         PresidiBean bean=new PresidiBean();
             try{
              Object primaryKey=bean.ejbCreate(  lCOD_CAG_PSD_ACD, strIDE_PSD_ACD, lCOD_LUO_FSC, strSTA_PSD_ACD);
              bean.setEntityContext(new EntityContextWrapper(primaryKey));
              bean.ejbPostCreate(  lCOD_CAG_PSD_ACD, strIDE_PSD_ACD, lCOD_LUO_FSC, strSTA_PSD_ACD);
              return bean;
            }
            catch(Exception ex){
              throw new javax.ejb.CreateException(ex.getMessage());
            }
      }

      public IPresidi findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException{
      PresidiBean bean=new PresidiBean();
			try{
					bean.setEntityContext(new EntityContextWrapper(primaryKey));
					bean.ejbActivate();
					bean.ejbLoad();
					return bean;
			}
           catch(Exception ex){
              throw new javax.ejb.FinderException(ex.getMessage());
            }
      }

      public Collection findAll() throws javax.ejb.FinderException {
			try{
				return this.ejbFindAll();
			}
			catch(Exception ex){
				throw new javax.ejb.FinderException(ex.getMessage());
			}
      }
 //

 // (Home Intrface) VIEWS  getPresidiDocumentiByID_View()
  	  public Collection getPresidiDocumentiByID_View(long lCOD_PSD_ACD)
	  {
	  	return (new  PresidiBean()).ejbGetPresidiDocumentiByID_View(lCOD_PSD_ACD);
	  }
	 public PresidioView getPresidio(long lCOD_PSD_ACD){
	 	return (new  PresidiBean()).ejbGetPresidio(lCOD_PSD_ACD);
	 }
 	 public Collection getPresidiAll(){
	 	return (new  PresidiBean()).ejbGetPresidiAll();
	 }
	 public Collection getPresidiByLuogo(long lCOD_LUO_FSC){
	  	return (new  PresidiBean()).ejbGetPresidiByLuogo(lCOD_LUO_FSC);
	 }
  public Collection getPresidi_to_SCH_PSD_ACD_View(String SCH_PSD_ACD, long lCOD_AZL, String strSTA_INT, String strCAG_DOC, String strNOM_RSP_INR, long lCOD_CAG_PSD_ACD, String strNOM_CAG_PSD_ACD,  String strIDE_PSD_ACD, java.sql.Date dDAT_PIF_INR_DAL, java.sql.Date dDAT_PIF_INR_AL, java.sql.Date dDAT_INR_DAL, java.sql.Date dDAT_INR_AL,String strRAGGRUPPATI, String strSORT_PIF, String strSORT_INT, String strSORT_RSP)
	{
     return (new  PresidiBean()).ejbGetPresidi_to_SCH_PSD_ACD_View(SCH_PSD_ACD, lCOD_AZL, strSTA_INT, strCAG_DOC, strNOM_RSP_INR, lCOD_CAG_PSD_ACD, strNOM_CAG_PSD_ACD,  strIDE_PSD_ACD, dDAT_PIF_INR_DAL, dDAT_PIF_INR_AL, dDAT_INR_DAL, dDAT_INR_AL,strRAGGRUPPATI, strSORT_PIF, strSORT_INT, strSORT_RSP);
 	}
 public Collection getPSD_Lov(long COD_AZL,long COD_CAG_PSD_ACD, long COD_PSD_ACD,String strNOM_CAG_PSD_ACD,String strIDE_PSD_ACD){
        return (new  PresidiBean()).ejbGetPSD_Lov(COD_AZL,COD_CAG_PSD_ACD,COD_PSD_ACD,strNOM_CAG_PSD_ACD,strIDE_PSD_ACD);
 }
//------------------------------------------------------------------------------------------------------------
  public Long ejbCreate(long lCOD_CAG_PSD_ACD, String strIDE_PSD_ACD, long lCOD_LUO_FSC, String strSTA_PSD_ACD)
  {
	this.lCOD_PSD_ACD= NEW_ID();
	this.lCOD_CAG_PSD_ACD=lCOD_CAG_PSD_ACD;
	this.strIDE_PSD_ACD=strIDE_PSD_ACD;
	this.lCOD_LUO_FSC=lCOD_LUO_FSC;
	this.strSTA_PSD_ACD=strSTA_PSD_ACD;
	this.unsetModified();

	BMPConnection bmp=getConnection();
	try{

		PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_psd_acd_tab (cod_psd_acd,cod_cag_psd_acd,ide_psd_acd,cod_luo_fsc,sta_psd_acd) VALUES(?,?,?,?,?)");
			ps.setLong(1, lCOD_PSD_ACD);
			ps.setLong(2, lCOD_CAG_PSD_ACD);
			ps.setString(3, strIDE_PSD_ACD);
			ps.setLong(4, lCOD_LUO_FSC);
			ps.setString(5, strSTA_PSD_ACD);
			ps.executeUpdate();
		return new Long(lCOD_PSD_ACD);
	}
	catch(Exception ex){
		throw new EJBException(ex);
	}
	finally{bmp.close();}
  }

  public void ejbPostCreate(long lCOD_CAG_PSD_ACD, String strIDE_PSD_ACD, long lCOD_LUO_FSC, String strSTA_PSD_ACD) { }

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_psd_acd FROM ana_psd_acd_tab");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            al.add(new Long(rs.getLong(1)));
          }
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

  public Long ejbFindByPrimaryKey(Long primaryKey){
    return primaryKey;
  }

  public void ejbActivate(){
    this.lCOD_PSD_ACD=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.lCOD_PSD_ACD=-1;
  }

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT cod_psd_acd,cod_cag_psd_acd,ide_psd_acd,dat_ult_ctl,esi_ult_ctl,cod_luo_fsc,sta_psd_acd FROM ana_psd_acd_tab WHERE cod_psd_acd=?");
           ps.setLong(1, lCOD_PSD_ACD);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
			lCOD_PSD_ACD=rs.getLong(1);
			lCOD_CAG_PSD_ACD=rs.getLong(2);
			strIDE_PSD_ACD=rs.getString(3);
			dtDAT_ULT_CTL=rs.getDate(4);
			strESI_ULT_CTL=rs.getString(5);
			lCOD_LUO_FSC=rs.getLong(6);
			strSTA_PSD_ACD=rs.getString(7);
           }
           else{
              throw new NoSuchEntityException("Presidi with ID="+lCOD_PSD_ACD+" not found");
           }
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

  public void ejbRemove(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_psd_acd_tab WHERE cod_psd_acd=?");
         ps.setLong(1, lCOD_PSD_ACD);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Presidi with ID="+lCOD_PSD_ACD+" not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

  public void ejbStore()
  {
    if(!isModified()) return;
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_psd_acd_tab SET cod_psd_acd=?, cod_cag_psd_acd=?, ide_psd_acd=?, dat_ult_ctl=?, esi_ult_ctl=?, cod_luo_fsc=?, sta_psd_acd=? WHERE cod_psd_acd=?");
			ps.setLong(1, lCOD_PSD_ACD);
			ps.setLong(2, lCOD_CAG_PSD_ACD);
			ps.setString(3, strIDE_PSD_ACD);
			ps.setDate(4, dtDAT_ULT_CTL);
			ps.setString(5, strESI_ULT_CTL);
			ps.setLong(6, lCOD_LUO_FSC);
			ps.setString(7, strSTA_PSD_ACD);
			ps.setLong(8, lCOD_PSD_ACD);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Presidi with ID="+lCOD_PSD_ACD+" not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }


  //<setter-getters>

	public long getCOD_PSD_ACD(){
		return lCOD_PSD_ACD;
	}
	//
	public long getCOD_CAG_PSD_ACD(){
		return lCOD_CAG_PSD_ACD;
	}
	public void setCOD_CAG_PSD_ACD(long lCOD_CAG_PSD_ACD){
		if(this.lCOD_CAG_PSD_ACD==lCOD_CAG_PSD_ACD) return;
		this.lCOD_CAG_PSD_ACD=lCOD_CAG_PSD_ACD;
		setModified();
	}
	//
	public String getIDE_PSD_ACD(){
		return strIDE_PSD_ACD;
	}
	public void setIDE_PSD_ACD(String strIDE_PSD_ACD){
		if(  (this.strIDE_PSD_ACD!=null) && (this.strIDE_PSD_ACD.equals(strIDE_PSD_ACD))  ) return;
		this.strIDE_PSD_ACD=strIDE_PSD_ACD;
		setModified();
	}
	//
	public java.sql.Date getDAT_ULT_CTL(){
		return dtDAT_ULT_CTL;
	}
	public void setDAT_ULT_CTL(java.sql.Date dtDAT_ULT_CTL){
		if(this.dtDAT_ULT_CTL==dtDAT_ULT_CTL) return;
		this.dtDAT_ULT_CTL=dtDAT_ULT_CTL;
    	setModified();
	}
	//
	public String getESI_ULT_CTL(){
		return strESI_ULT_CTL;
	}
	public void setESI_ULT_CTL(String strESI_ULT_CTL){
		if(  (this.strESI_ULT_CTL!=null) && (this.strESI_ULT_CTL.equals(strESI_ULT_CTL))  ) return;
		this.strESI_ULT_CTL=strESI_ULT_CTL;
		setModified();
	}
	//
	public long getCOD_LUO_FSC(){
		return lCOD_LUO_FSC;
	}
	public void setCOD_LUO_FSC(long lCOD_LUO_FSC){
		if(this.lCOD_LUO_FSC==lCOD_LUO_FSC) return;
		this.lCOD_LUO_FSC=lCOD_LUO_FSC;
		setModified();
	}
	//
	public String getSTA_PSD_ACD(){
		return strSTA_PSD_ACD;
	}
	public void setSTA_PSD_ACD(String strSTA_PSD_ACD){
		if(  (this.strSTA_PSD_ACD!=null) && (this.strSTA_PSD_ACD.equals(strSTA_PSD_ACD))  ) return;
		this.strSTA_PSD_ACD=strSTA_PSD_ACD;
		setModified();
	}
  //</setter-getters>


//-----------------------------#############################################
    // %%%Link%%% Table DOC_PSD_ACD_TAB
    public void addCOD_DOC(long newCOD_DOC){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("INSERT INTO doc_psd_acd_tab (cod_doc,cod_psd_acd) VALUES(?,?)");
           ps.setLong(1, newCOD_DOC);
           ps.setLong(2, lCOD_PSD_ACD);
           ps.executeUpdate();
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
 		}
    // %%%UNLink%%% Table DOC_PSD_ACD_TAB
    public void removeCOD_DOC(long newCOD_DOC){
      BMPConnection bmp=getConnection();
      try
      {
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM doc_psd_acd_tab  WHERE cod_doc=? AND cod_psd_acd=?");
         ps.setLong (1, newCOD_DOC);
         ps.setLong (2, lCOD_PSD_ACD);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Sezioni con ID="+newCOD_DOC+" non &egrave trovata");
      }
      catch(Exception ex)
      {
         throw new EJBException(ex);
      }
      finally{bmp.close();}
		}
    //-----------------------------#############################################

   public Collection ejbGetPresidiDocumentiByID_View(long lCOD_PSD_ACD){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT ana_doc_tab.cod_doc, tit_doc, rsp_doc, dat_rev_doc  FROM  ana_doc_tab, doc_psd_acd_tab WHERE  ana_doc_tab.cod_doc = doc_psd_acd_tab.cod_doc AND doc_psd_acd_tab.cod_psd_acd=? ORDER BY tit_doc");
		  ps.setLong(1, lCOD_PSD_ACD);
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            PresidiDocumentiByID_View obj=new PresidiDocumentiByID_View();
            obj.COD_PSD_ACD=lCOD_PSD_ACD;
            obj.COD_DOC=rs.getLong(1);
            obj.TIT_DOC=rs.getString(2);
			obj.RSP_DOC=rs.getString(3);
			obj.DAT_REV_DOC=rs.getDate(4);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
     finally{bmp.close();
		}
	}
	//--<ALEX>--
	public PresidioView ejbGetPresidio(long lCOD_PSD_ACD){
		BMPConnection bmp=getConnection();
	      try{
	          PreparedStatement ps=bmp.prepareStatement(" select   a.ide_psd_acd, b.nom_cag_psd_acd, a.dat_ult_ctl , a.esi_ult_ctl   from ana_psd_acd_tab a, cag_psd_acd_tab b where a.cod_cag_psd_acd = b.cod_cag_psd_acd and a.cod_psd_acd=?  ");
			  ps.setLong(1, lCOD_PSD_ACD);
	          ResultSet rs=ps.executeQuery();
	          PresidioView w= new PresidioView();
			  if(rs.next()){
                                        w.lCOD_PSD_ACD = lCOD_PSD_ACD;
                                        w.strIDE_PSD_ACD = rs.getString(1);
                                        w.strNOM_CAG_PSD_ACD = rs.getString(2);
					w.dtDAT_ULT_CTL = rs.getDate(3);
					w.strESI_ULT_CTL = rs.getString(4);
	          }
	          return w;
	      }
	      catch(Exception ex){
	          throw new EJBException(ex);
	      }
	      finally{bmp.close();}
	}
	public Collection ejbGetPresidiAll(){
	  BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("select a.cod_psd_acd,a.cod_cag_psd_acd,a.cod_luo_fsc,a.ide_psd_acd,  a.dat_ult_ctl,   a.esi_ult_ctl,  b.nom_cag_psd_acd   from  ana_psd_acd_tab  a,    cag_psd_acd_tab  b   where a.cod_cag_psd_acd= b.cod_cag_psd_acd   and a.sta_psd_acd <> 'S' ");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            PresidioView obj=new PresidioView();
            obj.lCOD_PSD_ACD = rs.getLong(1);
			obj.lCOD_CAG_PSD_ACD = rs.getLong(2);
			obj.lCOD_LUO_FSC=rs.getLong(3);
			obj.strIDE_PSD_ACD=rs.getString(4);
			obj.dtDAT_ULT_CTL=rs.getDate(5);
			obj.strESI_ULT_CTL=rs.getString(6);
			obj.strNOM_CAG_PSD_ACD = rs.getString(7);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
     finally{bmp.close();
		}
	}

	public Collection ejbGetPresidiByLuogo(long lCOD_LUO_FSC){
	 BMPConnection bmp=getConnection();
      try{
	  //ORDER BY NE OTRABATIVAET
          PreparedStatement ps=bmp.prepareStatement("SELECT a.cod_psd_acd, a.cod_cag_psd_acd, a.cod_luo_fsc, a.ide_psd_acd, a.dat_ult_ctl, a.esi_ult_ctl, b.nom_cag_psd_acd FROM  ana_psd_acd_tab a, cag_psd_acd_tab b WHERE a.cod_cag_psd_acd= b.cod_cag_psd_acd AND a.sta_psd_acd != 'S' AND a.cod_luo_fsc =?   ORDER BY  cag_psd_acd_tab.nom_cag_psd_acd ");
          ps.setLong(1, lCOD_LUO_FSC);
		  ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            PresidioView obj=new PresidioView();
            obj.lCOD_PSD_ACD = rs.getLong(1);
			obj.lCOD_CAG_PSD_ACD = rs.getLong(2);
			obj.lCOD_LUO_FSC=rs.getLong(3);
			obj.strIDE_PSD_ACD=rs.getString(4);
			obj.dtDAT_ULT_CTL=rs.getDate(5);
			obj.strESI_ULT_CTL=rs.getString(6);
			obj.strNOM_CAG_PSD_ACD = rs.getString(7);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
     finally{bmp.close();
		}
	}
	//--</ALEX>---

//------- BY JULIA ----
	 public Collection ejbGetPresidi_to_SCH_PSD_ACD_View(String SCH_PSD_ACD, long lCOD_AZL, String strSTA_INT, String strCAG_DOC, String strNOM_RSP_INR, long lCOD_CAG_PSD_ACD, String strNOM_CAG_PSD_ACD,  String strIDE_PSD_ACD, java.sql.Date dDAT_PIF_INR_DAL, java.sql.Date dDAT_PIF_INR_AL, java.sql.Date dDAT_INR_DAL, java.sql.Date dDAT_INR_AL, String strRAGGRUPPATI, String strSORT_PIF, String strSORT_INT, String strSORT_RSP)
{
	int icounterWhere=3;
    int iCOUNT_NOM_RSP_INR=0;
    int iCOUNT_COD_CAG_PSD_ACD=0;
    int iCOUNT_NOM_CAG_PSD_ACD=0;
    int iCOUNT_IDE_PSD_ACD=0;
    int iCOUNT_DAT_PIF_INR_DAL=0;
    int iCOUNT_DAT_PIF_INR_AL=0;
    int iCOUNT_DAT_INR_DAL=0;
    int iCOUNT_DAT_INR_AL=0;
    String strFROM="", strWHERE = "", strGROUP="";
    //--- STA_INT
      if (strSTA_INT.equals("G")) {
              strWHERE=strWHERE+" AND a.dat_inr IS NOT NULL ";
      } else if (strSTA_INT.equals("D")) {
              strWHERE=strWHERE+" AND a.dat_inr IS NULL ";
              dDAT_INR_DAL=null;
              dDAT_INR_AL=null;
      }
      //--- NOM_RSP_INR
      if (!strNOM_RSP_INR.equals("")) {
              iCOUNT_NOM_RSP_INR=icounterWhere;
              icounterWhere++;
              strWHERE=strWHERE+" AND a.nom_rsp_inr  like ? ";
      }
      //--- COD_CAG_PSD_ACD
      if (lCOD_CAG_PSD_ACD!=0) {
              iCOUNT_COD_CAG_PSD_ACD=icounterWhere;
              icounterWhere++;
              strWHERE=strWHERE+" AND  b.cod_cag_psd_acd  = ? ";
      }
      //--- NOM_CAG_PSD_ACD
      if (!strNOM_CAG_PSD_ACD.equals("")) {
              iCOUNT_NOM_CAG_PSD_ACD=icounterWhere;
              icounterWhere++;
              strWHERE=strWHERE+" AND  c.nom_cag_psd_acd  like ? ";
      }
      //--- IDE_PSD_ACD
      if (!strIDE_PSD_ACD.equals("")) {
              iCOUNT_IDE_PSD_ACD=icounterWhere;
              icounterWhere++;
              strWHERE=strWHERE+" AND  b.ide_psd_acd  like ? ";
      }
      //--- DATA
      if ((dDAT_PIF_INR_DAL!=null) && (dDAT_PIF_INR_AL!=null)){
              iCOUNT_DAT_PIF_INR_DAL=icounterWhere;
              icounterWhere++;
              iCOUNT_DAT_PIF_INR_AL=icounterWhere;
              icounterWhere++;
              strWHERE=strWHERE+" AND a.dat_pif_inr BETWEEN ? AND ? ";
      }
      if ((dDAT_PIF_INR_DAL!=null) && (dDAT_PIF_INR_AL==null)){
              iCOUNT_DAT_PIF_INR_DAL=icounterWhere;
              icounterWhere++;
              strWHERE=strWHERE+" AND a.dat_pif_inr >= ? ";
      }
      if ((dDAT_PIF_INR_DAL==null) && (dDAT_PIF_INR_AL!=null)){
              iCOUNT_DAT_PIF_INR_AL=icounterWhere;
              icounterWhere++;
              strWHERE=strWHERE+" AND a.dat_pif_inr <= ? ";
      }
      if ((dDAT_INR_DAL!=null) && (dDAT_INR_AL!=null)){
              iCOUNT_DAT_INR_DAL=icounterWhere;
              icounterWhere++;
              iCOUNT_DAT_INR_AL=icounterWhere;
              icounterWhere++;
              strWHERE=strWHERE+" AND a.dat_inr BETWEEN ? AND ? ";
      }
      if ((dDAT_INR_DAL!=null) && (dDAT_INR_AL==null)){
              iCOUNT_DAT_INR_DAL=icounterWhere;
              icounterWhere++;
              strWHERE=strWHERE+" AND a.dat_inr >= ? ";
      }
      if ((dDAT_INR_DAL==null) && (dDAT_INR_AL!=null)){
              iCOUNT_DAT_INR_AL=icounterWhere;
              icounterWhere++;
              strWHERE=strWHERE+" AND a.dat_inr <= ? ";
      }
      //*** ORDER ***//
      //--- Raggruppati = N
      strSORT_PIF=strSORT_PIF.replaceAll("\'","");
      strSORT_INT=strSORT_INT.replaceAll("\'","");
      strSORT_RSP=strSORT_RSP.replaceAll("\'","");
      if (strRAGGRUPPATI.equals("N")) {
              String strVAL_SORT_PIF="";
              String strVAL_SORT_INT="";
              String strVAL_SORT_RSP="";

              if (strSORT_PIF==null) strVAL_SORT_PIF="X" ;
                      else strVAL_SORT_PIF=strSORT_PIF;
              if (strSORT_INT==null) strVAL_SORT_INT="X";
                      else strVAL_SORT_INT=strSORT_INT;
              if (strSORT_RSP==null) strVAL_SORT_RSP="X";
                      else strVAL_SORT_RSP=strSORT_RSP;

              if ( (strVAL_SORT_PIF.equals("X")) && (strVAL_SORT_INT.equals("X")) && (strVAL_SORT_RSP.equals("X")) ) {
                      strSORT_PIF=strSORT_PIF.replaceAll(","," ");
                      strGROUP="ORDER BY "+strSORT_PIF;
              }
              else if ( (!strVAL_SORT_PIF.equals("X")) && (strVAL_SORT_INT.equals("X")) && (strVAL_SORT_RSP.equals("X"))) {
                      strSORT_PIF=strSORT_PIF.replaceAll(","," ");
                      strGROUP="ORDER BY "+strSORT_PIF;
              }
              else if ( (strVAL_SORT_PIF.equals("X")) && (!strVAL_SORT_INT.equals("X")) && (strVAL_SORT_RSP.equals("X")) ) {
                      strSORT_INT=strSORT_INT.replaceAll(","," ");
                      strGROUP="ORDER BY "+strSORT_INT;
              }
              else if ( (strVAL_SORT_PIF.equals("X")) && (strVAL_SORT_INT.equals("X")) && (!strVAL_SORT_RSP.equals("X")) ) {
                      strSORT_RSP=strSORT_RSP.replaceAll(","," ");
                      strGROUP="ORDER BY "+strSORT_RSP;
              }
      }
      //--- Raggruppati = A
      if (strRAGGRUPPATI.equals("A")) {
              strGROUP = " ORDER BY d.rag_scl_azl ";
              if (strSORT_PIF.equals("X")) strSORT_PIF="";
              if (strSORT_INT.equals("X")) strSORT_INT="";
              if (strSORT_RSP.equals("X")) strSORT_RSP="";
              strGROUP = strGROUP + strSORT_PIF + strSORT_INT + strSORT_RSP;
      }
      //--- Raggruppati = C
      if (strRAGGRUPPATI.equals("C")) {
              strGROUP = " ORDER BY c.nom_cag_psd_acd ";
              if (strSORT_PIF.equals("X")) strSORT_PIF="";
              if (strSORT_INT.equals("X")) strSORT_INT="";
              if (strSORT_RSP.equals("X")) strSORT_RSP="";
              strGROUP = strGROUP + strSORT_PIF + strSORT_INT + strSORT_RSP;
      }
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement(
                 "SELECT "
                    + "a.cod_sch_inr_psd, "
                    + "a.cod_psd_acd, "
                    + "a.dat_pif_inr, "
                    + "a.dat_inr, "
                    + "a.nom_rsp_inr, "
                    + "b.ide_psd_acd, "
                    + "c.nom_cag_psd_acd, "
                    + "e.rag_scl_azl "
                 + "FROM "
                    + "sch_inr_psd_tab a, "
                    + "ana_psd_acd_tab b, "
                    + "cag_psd_acd_tab c, "
                    + "ana_luo_fsc_tab d, "
                    + "ana_azl_tab e " + strFROM 
                + " WHERE "
                    + "a.tpl_inr_psd = ? "
                    + "AND a.cod_psd_acd = b.cod_psd_acd "
                    + "AND b.cod_cag_psd_acd = c.cod_cag_psd_acd "
                    + "AND b.cod_luo_fsc = d.cod_luo_fsc "
                    + "AND d.cod_azl = e.cod_azl "
                    + "AND d.cod_azl=? " + strWHERE + " " + strGROUP);
         ps.setString(1, SCH_PSD_ACD);
         ps.setLong(2, lCOD_AZL);
         if (iCOUNT_NOM_RSP_INR!=0) ps.setString(iCOUNT_NOM_RSP_INR, strNOM_RSP_INR+'%');
         if (iCOUNT_COD_CAG_PSD_ACD!=0) ps.setLong(iCOUNT_COD_CAG_PSD_ACD, lCOD_CAG_PSD_ACD);
         if (iCOUNT_NOM_CAG_PSD_ACD!=0) ps.setString(iCOUNT_NOM_CAG_PSD_ACD, strNOM_CAG_PSD_ACD+'%');
         if (iCOUNT_IDE_PSD_ACD!=0) ps.setString(iCOUNT_IDE_PSD_ACD, strIDE_PSD_ACD+'%');
         if (iCOUNT_DAT_PIF_INR_DAL!=0) ps.setDate(iCOUNT_DAT_PIF_INR_DAL, dDAT_PIF_INR_DAL);
         if (iCOUNT_DAT_PIF_INR_AL!=0) ps.setDate(iCOUNT_DAT_PIF_INR_AL, dDAT_PIF_INR_AL);
         if (iCOUNT_DAT_INR_DAL!=0) ps.setDate(iCOUNT_DAT_INR_DAL, dDAT_INR_DAL);
         if (iCOUNT_DAT_INR_AL!=0) ps.setDate(iCOUNT_DAT_INR_AL, dDAT_INR_AL);
        ResultSet rs=ps.executeQuery();
        java.util.ArrayList al=new java.util.ArrayList();
        while(rs.next()){
            Presidi_to_SCH_PSD_ACD_View obj=new Presidi_to_SCH_PSD_ACD_View();
            obj.COD_SCH_INR_PSD=rs.getLong(1);
            obj.COD_PSD_ACD=rs.getLong(2);
            obj.DAT_PIF_INR=rs.getDate(3);
            obj.DAT_INR=rs.getDate(4);
            obj.NOM_RSP_INR=rs.getString(5);
            obj.IDE_PSD_ACD=rs.getString(6);
            obj.NOM_CAG_PSD_ACD=rs.getString(7);
            obj.RAG_SCL_AZL=rs.getString(8);
            al.add(obj);
        }
        bmp.close();
        return al;
      }
      catch(Exception ex){
        throw new EJBException(ex);
      }finally{bmp.close();}
  }
  //------------------------------
public Collection ejbGetPSD_Lov(long COD_AZL,long COD_CAG_PSD_ACD, long COD_PSD_ACD, String strNOM_CAG_PSD_ACD, String strIDE_PSD_ACD)
{
     BMPConnection bmp=getConnection();
     try{
        String vWhere="";
        String vOrder=" ORDER BY a.ide_psd_acd";
        int ifNOM_CAG_PSD_ACD = 0;
        int ifCOD_CAG_PSD_ACD = 0;
        int ifCOD_PSD_ACD = 0;
        int ifIDE_PSD_ACD = 0;
        int index = 2;
        if ( !"".equals(strNOM_CAG_PSD_ACD) ){
          vWhere += " AND b.nom_cag_psd_acd LIKE ?||'%' ";
                ifNOM_CAG_PSD_ACD = index++;
        }
        if ( COD_CAG_PSD_ACD != 0){
          vWhere += " AND a.cod_cag_psd_acd = ? ";
                ifCOD_CAG_PSD_ACD = index++;
        }
        if ( COD_PSD_ACD != 0){
          vWhere += " AND a.cod_psd_acd = ? ";
                ifCOD_PSD_ACD = index++;
        }
        if ( !"".equals(strIDE_PSD_ACD) ){
          vWhere += " AND a.ide_psd_acd LIKE ?||'%' ";
                ifIDE_PSD_ACD = index++;
        }
        PreparedStatement ps=bmp.prepareStatement(
                "SELECT "
                    + "a.cod_psd_acd, "
                    + "b.cod_cag_psd_acd, "
                    + "a.ide_psd_acd, "
                    + "a.dat_ult_ctl, "
                    + "a.esi_ult_ctl, "
                    + "b.nom_cag_psd_acd "
                + "FROM "
                    + "ana_psd_acd_tab a, "
                    + "cag_psd_acd_tab b, "
                    + "ana_luo_fsc_tab c "
                + "WHERE "
                    + "a.cod_luo_fsc = c.cod_luo_fsc "
                    + "AND c.cod_azl = ? "
                    + "AND a.cod_cag_psd_acd = b.cod_cag_psd_acd "
                    + "AND a.sta_psd_acd != 'S' " + vWhere + vOrder);
        ps.setLong(1, COD_AZL);
        if (ifNOM_CAG_PSD_ACD != 0) ps.setString(ifNOM_CAG_PSD_ACD, strNOM_CAG_PSD_ACD);
        if (ifCOD_CAG_PSD_ACD != 0) ps.setLong(ifCOD_CAG_PSD_ACD, COD_CAG_PSD_ACD);
        if (ifCOD_PSD_ACD != 0) ps.setLong(ifCOD_PSD_ACD, COD_PSD_ACD);
        if (ifIDE_PSD_ACD != 0) ps.setString(ifIDE_PSD_ACD, strIDE_PSD_ACD);
        ResultSet rs=ps.executeQuery();
        java.util.ArrayList ar= new java.util.ArrayList();
        while(rs.next()){
            PSD_Lov v=new PSD_Lov();
            v.COD_PSD_ACD=rs.getLong(1);
            v.COD_CAG_PSD_ACD=rs.getLong(2);
            v.IDE_PSD_ACD=rs.getString(3);
            v.DAT_ULT_PSD=rs.getDate(4);
            v.ESI_ULT_PSD=rs.getString(5);
            v.NOM_CAG_PSD_ACD=rs.getString(6);
            ar.add(v);
        }
     return ar;
     }
     catch(Exception ex){
         throw new EJBException(ex);
     }
     finally{bmp.close();}
}
//=======================================================================================================

//--- mary for search
public Collection findEx(
		java.sql.Date dtDAT_ULT_CTL,
		String strIDE_PSD_ACD,
		String strESI_ULT_CTL,
		Long lCOD_CAG_PSD_ACD,
		Long lCOD_LUO_FSC,
		int iOrderParameter //not used for now
){
	return ejbFindEx(dtDAT_ULT_CTL, strIDE_PSD_ACD, strESI_ULT_CTL, lCOD_CAG_PSD_ACD, lCOD_LUO_FSC, iOrderParameter);
}
public Collection ejbFindEx(
		java.sql.Date dtDAT_ULT_CTL,
		String strIDE_PSD_ACD,
		String strESI_ULT_CTL,
		Long lCOD_CAG_PSD_ACD,
		Long lCOD_LUO_FSC,
		int iOrderParameter //not used for now
){
String strSql="SELECT a.cod_psd_acd, a.cod_cag_psd_acd, a.cod_luo_fsc, a.ide_psd_acd, a.dat_ult_ctl, a.esi_ult_ctl, b.nom_cag_psd_acd  FROM  ana_psd_acd_tab a, cag_psd_acd_tab  b WHERE  a.cod_cag_psd_acd= b.cod_cag_psd_acd AND a.sta_psd_acd != 'S'   ";
		if(dtDAT_ULT_CTL!=null){
				strSql+=" AND a.dat_ult_ctl=? ";
		}
		if(strIDE_PSD_ACD!=null){
				strSql+=" AND UPPER(a.ide_psd_acd) LIKE ? ";
		}
		if(strESI_ULT_CTL!=null){
				strSql+=" AND UPPER(a.esi_ult_ctl) LIKE ? ";
		}
		if(lCOD_CAG_PSD_ACD!=null){
				strSql+=" AND a.cod_cag_psd_acd=? ";
		}
		if(lCOD_LUO_FSC!=null){
				strSql+=" AND a.cod_luo_fsc=? ";
		}
		strSql+=" ORDER BY UPPER(b.nom_cag_psd_acd), UPPER(a.ide_psd_acd)";
		int i=1;
		BMPConnection bmp=getConnection();
			try{
				PreparedStatement ps=bmp.prepareStatement(strSql);
				if(dtDAT_ULT_CTL!=null) ps.setDate(i++, dtDAT_ULT_CTL);
				if(strIDE_PSD_ACD!=null) ps.setString(i++, strIDE_PSD_ACD.toUpperCase());
				if(strESI_ULT_CTL!=null) ps.setString(i++, strESI_ULT_CTL.toUpperCase());
				if(lCOD_CAG_PSD_ACD!=null) ps.setLong(i++, lCOD_CAG_PSD_ACD.longValue());
				if(lCOD_LUO_FSC!=null) ps.setLong(i++, lCOD_LUO_FSC.longValue());
				ResultSet rs=ps.executeQuery();
		      	java.util.ArrayList ar= new java.util.ArrayList();
	      		while(rs.next()){
	      			PresidioView obj=new PresidioView();
          			obj.lCOD_PSD_ACD = rs.getLong(1);
					obj.lCOD_CAG_PSD_ACD = rs.getLong(2);
					obj.lCOD_LUO_FSC=rs.getLong(3);
					obj.strIDE_PSD_ACD=rs.getString(4);
					obj.dtDAT_ULT_CTL=rs.getDate(5);
					obj.strESI_ULT_CTL=rs.getString(6);
					obj.strNOM_CAG_PSD_ACD = rs.getString(7);
	        		ar.add(obj);
	      		}
				return ar;
				//----------------------------------------------------------------------
		  }
        catch(Exception ex){
			throw new EJBException(strSql+"/n"+ex);
      }finally{bmp.close();}
	}
}

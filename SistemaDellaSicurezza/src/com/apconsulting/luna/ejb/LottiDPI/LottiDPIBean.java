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

package com.apconsulting.luna.ejb.LottiDPI;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.FinderException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;

/**
 *
 * @author Alessandro
 */
public class LottiDPIBean extends BMPEntityBean implements ILottiDPI, ILottiDPIHome
{
  //<comment description="Member Variables">
	long COD_LOT_DPI;           //1
	long COD_TPL_DPI;           //2
	String IDE_LOT_DPI;         //3
	java.sql.Date  DAT_CSG_LOT; //4
	long QTA_FRT;           		//5
	long QTA_AST;           		//6
	long QTA_DSP;           		//7
	long COD_FOR_AZL;           //8
	long COD_AZL;           		//9
  //</comment>

////////////////////// CONSTRUCTOR///////////////////

 private static LottiDPIBean ys = null;

    private LottiDPIBean() {
        //
    }

    public static LottiDPIBean getInstance() {
        if (ys == null) {
            ys = new LottiDPIBean();
        }
        return ys;
    }

//////////////////////////ATTENTION!!/////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public ILottiDPI create(long lCOD_TPL_DPI, String strIDE_LOT_DPI, java.sql.Date  dDAT_CSG_LOT, long lQTA_FRT, long lQTA_AST, long lQTA_DSP,long lCOD_FOR_AZL,long lCOD_AZL) throws CreateException
  {
 	 LottiDPIBean bean =  new  LottiDPIBean();
	 try{
	 Object primaryKey=bean.ejbCreate(lCOD_TPL_DPI, strIDE_LOT_DPI, dDAT_CSG_LOT, lQTA_FRT, lQTA_AST, lQTA_DSP, lCOD_FOR_AZL, lCOD_AZL
);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(lCOD_TPL_DPI, strIDE_LOT_DPI, dDAT_CSG_LOT, lQTA_FRT, lQTA_AST, lQTA_DSP, lCOD_FOR_AZL, lCOD_AZL
);
     return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
        }
  }


 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
  	LottiDPIBean iLottiDPIBean=new  LottiDPIBean();
    try
	{
    	Object obj=iLottiDPIBean.ejbFindByPrimaryKey((Long)primaryKey);
        iLottiDPIBean.setEntityContext(new EntityContextWrapper(obj));
        iLottiDPIBean.ejbActivate();
        iLottiDPIBean.ejbLoad();
        iLottiDPIBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex);
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public ILottiDPI findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	LottiDPIBean bean =  new  LottiDPIBean();
	try
	{
   		bean.setEntityContext(new EntityContextWrapper(primaryKey));
   		bean.ejbActivate();
   		bean.ejbLoad();
   		return bean;
	}
    catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }
  // (Home Intrface) findAll()
  public Collection findAll() throws FinderException
  {
  	try
	{
   		return this.ejbFindAll();
	}
    catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }


  // (Home Intrface) VIEWS  getLottiDPIByFORAZLID_View()
//--- view per lotti DPI
  public Collection getLottiDPI_IDE_DATA_View(long AZL_ID)
  {
  	return (new  LottiDPIBean()).ejbGetLottiDPI_IDE_DATA_View(AZL_ID);
 	}

//--- view per fornitore
  public Collection getLottiDPIByFORAZLID_View(long FOR_AZL_ID, long AZL_ID)
  {
  	return (new  LottiDPIBean()).ejbGetLottiDPIByFORAZLID_View(FOR_AZL_ID, AZL_ID);
 	}
//--- view per tipologia DPI
  public Collection getLottiDPIByTPLDPIID_View(long TPL_DPI_ID)
  {
  	return (new  LottiDPIBean()).ejbGetLottiDPIByTPLDPIID_View(TPL_DPI_ID);
 	}


/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</ILottiDPIHome-implementation>
  public Long ejbCreate(long lCOD_TPL_DPI, String strIDE_LOT_DPI, java.sql.Date  dDAT_CSG_LOT, long lQTA_FRT, long lQTA_AST, long lQTA_DSP,long lCOD_FOR_AZL,long lCOD_AZL)
  {
		this.COD_TPL_DPI=lCOD_TPL_DPI;
		this.IDE_LOT_DPI=strIDE_LOT_DPI;
		this.DAT_CSG_LOT=dDAT_CSG_LOT;
		this.QTA_FRT=lQTA_FRT;
		this.QTA_AST=lQTA_AST;
		this.QTA_DSP=lQTA_DSP;
		this.COD_FOR_AZL=lCOD_FOR_AZL;
		this.COD_AZL=lCOD_AZL;
    this.COD_LOT_DPI=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_lot_dpi_tab (cod_lot_dpi, cod_tpl_dpi, ide_lot_dpi, dat_csg_lot, qta_frt, qta_ast, qta_dsp, cod_for_azl, cod_azl) VALUES(?,?,?,?,?,?,?,?,?)");
         ps.setLong   (1, COD_LOT_DPI);
		 ps.setLong   (2, COD_TPL_DPI);
         ps.setString (3, IDE_LOT_DPI);
         ps.setDate   (4, DAT_CSG_LOT);
		 ps.setLong		(5, QTA_FRT);
		 ps.setLong		(6, QTA_AST);
		 ps.setLong		(7, QTA_DSP);
		 ps.setLong		(8, COD_FOR_AZL);
		 ps.setLong		(9, COD_AZL);
         ps.executeUpdate();
         return new Long(COD_LOT_DPI);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------
  public void ejbPostCreate(long lCOD_TPL_DPI, String strIDE_LOT_DPI, java.sql.Date  dDAT_CSG_LOT, long lQTA_FRT, long lQTA_AST, long lQTA_DSP,long lCOD_FOR_AZL,long lCOD_AZL) { }
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_lot_dpi FROM ana_lot_dpi_tab ");
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

//-----------------------------------------------------------

  public Long ejbFindByPrimaryKey(Long primaryKey){
    return primaryKey;
  }
//----------------------------------------------------------

  public void ejbActivate(){
    this.COD_LOT_DPI=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_LOT_DPI=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM ana_lot_dpi_tab  WHERE cod_lot_dpi=?");
           ps.setLong (1, COD_LOT_DPI);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
               	this.COD_TPL_DPI=rs.getLong("COD_TPL_DPI");
				this.IDE_LOT_DPI=rs.getString("IDE_LOT_DPI");
				this.DAT_CSG_LOT=rs.getDate("DAT_CSG_LOT");
	  			this.QTA_FRT=rs.getLong("QTA_FRT");
				this.QTA_AST=rs.getLong("QTA_AST");
				this.QTA_DSP=rs.getLong("QTA_DSP");
				this.COD_FOR_AZL=rs.getLong("COD_FOR_AZL");
				this.COD_AZL=rs.getLong("COD_AZL");
           }
           else{
              throw new NoSuchEntityException("LottiDPI con ID= non è trovato");
           }
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//----------------------------------------------------------

  public void ejbRemove(){
      BMPConnection bmp=getConnection();
      try
	  {
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_lot_dpi_tab  WHERE cod_lot_dpi=?");
          ps.setLong (1, COD_LOT_DPI);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("LottiDPI con ID= non è trovato");
      }
      catch(Exception ex)
	  {
          throw new EJBException(ex);
      }
      finally{bmp.close();
	  }
  }
//----------------------------------------------------------

  public void ejbStore()
  {
    if(!isModified()) return;
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_lot_dpi_tab  SET cod_tpl_dpi=?, ide_lot_dpi=?, dat_csg_lot=?,qta_frt=?,qta_ast=?,qta_dsp=?,cod_for_azl=?,cod_azl=?	 WHERE cod_lot_dpi=?");
				ps.setLong	(1, COD_TPL_DPI);
				ps.setString(2, IDE_LOT_DPI);
				ps.setDate	(3, DAT_CSG_LOT);
	  			ps.setLong	(4, QTA_FRT);
				ps.setLong	(5, QTA_AST);
				ps.setLong	(6, QTA_DSP);
				ps.setLong	(7, COD_FOR_AZL);
				ps.setLong	(8, COD_AZL);
				ps.setLong  (9, COD_LOT_DPI);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("LottiDPI con ID= non è trovato");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>
//<comment description="setter/getters">
	//1
	public long getCOD_LOT_DPI(){
      return COD_LOT_DPI;
		}
	//2
    public void setCOD_TPL_DPI(long newCOD_TPL_DPI){
      if (COD_TPL_DPI == newCOD_TPL_DPI ) return;
      COD_TPL_DPI = newCOD_TPL_DPI;
      setModified();
    }
		public long getCOD_TPL_DPI(){
      return COD_TPL_DPI;
    }
	//3
	public void setIDE_LOT_DPI(String newIDE_LOT_DPI){
      if (IDE_LOT_DPI.equals(newIDE_LOT_DPI))  return;
      IDE_LOT_DPI = newIDE_LOT_DPI;
      setModified();
    }
    public String getIDE_LOT_DPI(){
      return IDE_LOT_DPI;
    }
  //4
	public void setDAT_CSG_LOT(java.sql.Date newDAT_CSG_LOT)
	{
		if( DAT_CSG_LOT.equals(newDAT_CSG_LOT)) return;
		DAT_CSG_LOT = newDAT_CSG_LOT;
		setModified();
	}
	public java.sql.Date getDAT_CSG_LOT()
	{
		return DAT_CSG_LOT;
	}
	//5
    public void setQTA_FRT(long newQTA_FRT){
      if (QTA_FRT == newQTA_FRT ) return;
      QTA_FRT = newQTA_FRT;
      setModified();
    }
		public long getQTA_FRT(){
      return QTA_FRT;
    }
	//6
    public void setQTA_AST(long newQTA_AST){
      if (QTA_AST == newQTA_AST ) return;
      QTA_AST = newQTA_AST;
      setModified();
    }
		public long getQTA_AST(){
      return QTA_AST;
    }
	//7
    public void setQTA_DSP(long newQTA_DSP){
      if (QTA_DSP == newQTA_DSP ) return;
      QTA_DSP = newQTA_DSP;
      setModified();
    }
		public long getQTA_DSP(){
      return QTA_DSP;
    }
	//8
    public void setCOD_FOR_AZL(long newCOD_FOR_AZL){
      if (COD_FOR_AZL == newCOD_FOR_AZL ) return;
      COD_FOR_AZL = newCOD_FOR_AZL;
      setModified();
    }
		public long getCOD_FOR_AZL(){
      return COD_FOR_AZL;
    }
	//9
    public void setCOD_AZL(long newCOD_AZL){
      if (COD_AZL == newCOD_AZL ) return;
      COD_AZL = newCOD_AZL;
      setModified();
    }
		public long getCOD_AZL(){
      return COD_AZL;
    }

   //</comment>

   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>

   //<comment description="extended setters/getters">
//--- view per LotttiDPI
public Collection ejbGetLottiDPI_IDE_DATA_View(long AZL_ID){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_lot_dpi, ide_lot_dpi, dat_csg_lot, qta_frt, qta_ast, qta_dsp  FROM ana_lot_dpi_tab WHERE cod_azl=?  ORDER BY ide_lot_dpi ");
          ps.setLong(1, AZL_ID);
		  ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            LottiDPI_IDE_DATA_View obj=new LottiDPI_IDE_DATA_View();
			obj.COD_LOT_DPI=rs.getLong(1);
			obj.IDE_LOT_DPI=rs.getString(2);
			obj.DAT_CSG_LOT=rs.getDate(3);
			obj.QTA_FRT=rs.getLong(4);
			obj.QTA_AST=rs.getLong(5);
			obj.QTA_DSP=rs.getLong(6);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
     finally{bmp.close();}
  }

//--- view per fornitore
   public Collection ejbGetLottiDPIByFORAZLID_View(long FOR_AZL_ID, long AZL_ID){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT ld.cod_lot_dpi, ld.ide_lot_dpi, ld.qta_frt, ld.qta_ast, ld.qta_dsp, td.nom_tpl_dpi FROM ana_lot_dpi_tab ld, tpl_dpi_tab td, ana_for_azl_tab fa WHERE td.cod_tpl_dpi = ld.cod_tpl_dpi AND ld.cod_for_azl = fa.cod_for_azl AND ld.cod_for_azl=? AND fa.cod_azl=? ORDER BY  ld.ide_lot_dpi ");
          ps.setLong(1, FOR_AZL_ID);
		  ps.setLong(2, AZL_ID);
		  ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            LottiDPIByFORAZLID_View obj=new LottiDPIByFORAZLID_View();
			obj.COD_LOT_DPI=rs.getLong(1);
			obj.IDE_LOT_DPI=rs.getString(2);
			obj.QTA_FRT=rs.getLong(3);
			obj.QTA_AST=rs.getLong(4);
			obj.QTA_DSP=rs.getLong(5);
			obj.NOM_TPL_DPI=rs.getString(6);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
     finally{bmp.close();}
  }
//--- view per tipologia DPI
   public Collection ejbGetLottiDPIByTPLDPIID_View(long TPL_DPI_ID){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT ld.cod_lot_dpi, ld.ide_lot_dpi, ld.dat_csg_lot, fa.rag_soc_for_azl FROM ana_lot_dpi_tab ld, ana_for_azl_tab fa WHERE fa.cod_for_azl = ld.cod_for_azl AND ld.cod_tpl_dpi=? ORDER BY fa.rag_soc_for_azl, ld.ide_lot_dpi ");
		  ps.setLong(1, TPL_DPI_ID);
		  ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            LottiDPIByTPLDPIID_View obj=new LottiDPIByTPLDPIID_View();
			obj.COD_LOT_DPI=rs.getLong(1);
			obj.IDE_LOT_DPI=rs.getString(2);
			obj.DAT_CSG_LOT=rs.getDate(3);
			obj.RAG_SOC_FOR_AZL=rs.getString(4);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
     finally{bmp.close();}
  }
  //-------------------
  //</comment>
//--- mary for search
	public Collection findEx(
		long lCOD_AZL,
		Long lCOD_TPL_DPI,
		String strIDE_LOT_DPI,
		java.sql.Date	dDAT_CSG_LOT,
		Long lQTA_FRT,
		Long lCOD_FOR_AZL,
		int iOrderParameter //not used for now
	){
		return ejbFindEx(lCOD_AZL, lCOD_TPL_DPI, strIDE_LOT_DPI, dDAT_CSG_LOT, lQTA_FRT, lCOD_FOR_AZL, iOrderParameter);
	}
	//
	public Collection ejbFindEx(
		long lCOD_AZL,
		Long lCOD_TPL_DPI,
		String strIDE_LOT_DPI,
		java.sql.Date	dDAT_CSG_LOT,
		Long lQTA_FRT,
		Long lCOD_FOR_AZL,
		int iOrderParameter //not used for now
	){
		String strSql="SELECT a.cod_lot_dpi, a.ide_lot_dpi, a.dat_csg_lot, a.qta_frt, a.qta_ast, a.qta_dsp, b.nom_tpl_dpi FROM ana_lot_dpi_tab a, tpl_dpi_tab b  WHERE a.cod_tpl_dpi = b.cod_tpl_dpi  AND a.cod_azl = ? ";

		if(lCOD_TPL_DPI!=null){
				strSql+=" AND a.cod_tpl_dpi=? ";
		}
		if(strIDE_LOT_DPI!=null){
				strSql+=" AND UPPER(a.ide_lot_dpi) LIKE ? ";
		}
		if(dDAT_CSG_LOT!=null){
				strSql+=" AND a.dat_csg_lot=? ";
		}
		if(lQTA_FRT!=null){
				strSql+=" AND a.qta_frt=? ";
		}
		if(lCOD_FOR_AZL!=null){
				strSql+=" AND a.cod_for_azl=? ";
		}
		strSql+=" ORDER BY UPPER(a.ide_lot_dpi)";

		int i=1;
		BMPConnection bmp=getConnection();
			try{
				PreparedStatement ps=bmp.prepareStatement(strSql);
				ps.setLong(i++, lCOD_AZL);
				if(lCOD_TPL_DPI!=null) ps.setLong(i++, lCOD_TPL_DPI.longValue());
				if(strIDE_LOT_DPI!=null) ps.setString(i++, strIDE_LOT_DPI.toUpperCase());
				if(dDAT_CSG_LOT!=null) ps.setDate(i++, dDAT_CSG_LOT);
				if(lQTA_FRT!=null) ps.setLong(i++, lQTA_FRT.longValue());
				if(lCOD_FOR_AZL!=null) ps.setLong(i++, lCOD_FOR_AZL.longValue());
				ResultSet rs=ps.executeQuery();
	      java.util.ArrayList ar= new java.util.ArrayList();
	      while(rs.next()){
	      	LottiDPI_IDE_DATA_View obj=new LottiDPI_IDE_DATA_View();
	        	obj.COD_LOT_DPI=rs.getLong(1);
				obj.IDE_LOT_DPI=rs.getString(2);
				obj.DAT_CSG_LOT=rs.getDate(3);
				obj.QTA_FRT=rs.getLong(4);
				obj.QTA_AST=rs.getLong(5);
				obj.QTA_DSP=rs.getLong(6);
				obj.NOM_TPL_DPI=rs.getString(7);
	        	ar.add(obj);
	      }
		return ar;
	  	}
        catch(Exception ex){
					throw new EJBException(strSql+"/n"+ex);
      }
		  finally{bmp.close();}
	}
///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  LottiDPIBean"/>

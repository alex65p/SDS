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

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%
/*
<file>
  <versions>	
    <version number="1.0" date="25/01/2004" author="Treskina Maria">
      <comments>
		 <comment date="25/01/2004" author="Treskina Maria">
		   <description>Bean dla TPL_DPI_TAB</description>
		 </comment>
		 <comment date="25/02/2004" author="Pogrebnoy Yura">
		   <description>removeLUO_FSC_DPI</description>
		 </comment>
		 <comment date="27/03/2004" author="Treskina Mary">
		   <description>FindEx dla search</description>
		 </comment>
 	  </comments> 
    </version>
  </versions>
</file> 
*/ 
%>

<%!
///////////////ATTENTION!!//////////////////////////////////////////////
//<comment description="Zdes opredeliaetsia realizatzija EJB obiekta"/>

public class TipologiaDPIBean extends BMPEntityBean implements ITipologiaDPI, ITipologiaDPIHome
//class TipologiaDPIBean extends ITipologiaDPIHome
{
  //<comment description="Member Variables">
	//*reguired fields
	long COD_TPL_DPI;	//1
	String NOM_TPL_DPI;	//2
	String DES_CAR_DPI; //3
	//*not requered fields
	String MDL_PTR_UTI_DPI;
	String IMG_CSI_DPI; 
	long CAG_DPI;
	long PER_MES_SST; 
	long PER_MES_MNT;
  //</comment>
 
////////////////////// CONSTRUCTOR///////////////////
 private TipologiaDPIBean(){}
/////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public ITipologiaDPI create(String strNOM_TPL_DPI, String strDES_CAR_DPI) throws CreateException
  {
 	 TipologiaDPIBean bean =  new  TipologiaDPIBean();
	 try{
	 Object primaryKey=bean.ejbCreate(strNOM_TPL_DPI, strDES_CAR_DPI);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(strNOM_TPL_DPI, strDES_CAR_DPI);
     return bean;
	 }catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
     }
  }

 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
  	TipologiaDPIBean iTipologiaDPIBean=new  TipologiaDPIBean();
    try{
    	Object obj=iTipologiaDPIBean.ejbFindByPrimaryKey((Long)primaryKey);
        iTipologiaDPIBean.setEntityContext(new EntityContextWrapper(obj));
        iTipologiaDPIBean.ejbActivate();
        iTipologiaDPIBean.ejbLoad();
        iTipologiaDPIBean.ejbRemove();
    }catch(Exception ex){
          throw new EJBException(ex);
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public ITipologiaDPI findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	TipologiaDPIBean bean =  new  TipologiaDPIBean();
	try{
   		bean.setEntityContext(new EntityContextWrapper(primaryKey));
   		bean.ejbActivate();
   		bean.ejbLoad();
   		return bean;
	} catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }
  // (Home Intrface) findAll()
  public Collection findAll() throws FinderException
  {
  	try{
   		return this.ejbFindAll();
	}catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }
 
  // (Home Intrface) 
  public Collection getTipologiaDPI_Name_View()
  {
  	return (new  TipologiaDPIBean()).ejbGetTipologiaDPI_Name_View();
  }
//--- view dla ANA_NOR_SEN cherez nor_sen_tpl_dpi_tab
  public Collection getNormativeSentenzeByTPLID_View(long COD_TPL_DPI)
  {
  	return (new  TipologiaDPIBean()).ejbGetNormativeSentenzeByTPLID_View(COD_TPL_DPI);
  }
//--- view dla ANA_DOC_TAB cherez DOC_DPI_TAB 
  public Collection getDocumentByTPLDPIID_View(long COD_TPL_DPI)
  {
  	return (new  TipologiaDPIBean()).ejbGetDocumentByTPLDPIID_View(COD_TPL_DPI);
  }
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</ITipologiaDPIHome-implementation>
  public Long ejbCreate(String strNOM_TPL_DPI, String strDES_CAR_DPI)
  {
    this.NOM_TPL_DPI=strNOM_TPL_DPI;
    this.DES_CAR_DPI=strDES_CAR_DPI;
    this.COD_TPL_DPI=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement(
	   "INSERT INTO tpl_dpi_tab (cod_tpl_dpi, nom_tpl_dpi,des_car_dpi) VALUES(?,?,?)");
         ps.setLong   (1, COD_TPL_DPI);
         ps.setString (2, NOM_TPL_DPI);
         ps.setString (3, DES_CAR_DPI);
         ps.executeUpdate();
         return new Long(COD_TPL_DPI);
    }catch(Exception ex){
        throw new EJBException(ex);
    }finally{bmp.close();}
  }

//-------------------------------------------------------   
  public void ejbPostCreate(String strNOM_TPL_DPI, String strDES_CAR_DPI) { }	
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_tpl_dpi FROM tpl_dpi_tab ");
		  ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            al.add(new Long(rs.getLong(1)));
          }
          return al;
      }catch(Exception ex){
          throw new EJBException(ex);
      }finally{bmp.close();}
  }

//-----------------------------------------------------------
  public Long ejbFindByPrimaryKey(Long primaryKey){
    return primaryKey;
  }
//----------------------------------------------------------
  public void ejbActivate(){
    this.COD_TPL_DPI=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------
  public void ejbPassivate(){
      this.COD_TPL_DPI=-1;
  }
//----------------------------------------------------------
  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM tpl_dpi_tab  WHERE cod_tpl_dpi=?");
           ps.setLong (1, COD_TPL_DPI);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
               	this.NOM_TPL_DPI=rs.getString("NOM_TPL_DPI");
				this.DES_CAR_DPI=rs.getString("DES_CAR_DPI");
  	   			this.MDL_PTR_UTI_DPI=rs.getString("MDL_PTR_UTI_DPI");
				this.IMG_CSI_DPI=rs.getString("IMG_CSI_DPI");
    			this.CAG_DPI=rs.getLong("CAG_DPI");
				this.PER_MES_SST=rs.getLong("PER_MES_SST");
				this.PER_MES_MNT=rs.getLong("PER_MES_MNT");
	       }else{
              throw new NoSuchEntityException("Tipologia DPI con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM tpl_dpi_tab  WHERE cod_tpl_dpi=?");
          ps.setLong (1, COD_TPL_DPI);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("Tipologia DPI con ID="+COD_TPL_DPI+" non è trovata");
      }catch(Exception ex){
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE tpl_dpi_tab  SET nom_tpl_dpi=?, des_car_dpi=?, mdl_ptr_uti_dpi=?, img_csi_dpi=?, cag_dpi=?, per_mes_sst=?, per_mes_mnt=?	 WHERE cod_tpl_dpi=?");
          ps.setString(1, NOM_TPL_DPI);
          ps.setString(2, DES_CAR_DPI );
	  	  ps.setString(3, MDL_PTR_UTI_DPI);
		  ps.setString(4, IMG_CSI_DPI);
          ps.setLong(5, CAG_DPI);
          ps.setLong(6, PER_MES_SST);	
		  ps.setLong(7, PER_MES_MNT);	
		  ps.setLong(8, COD_TPL_DPI);	
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("Tipologia DPI with ID= non &egrave trovata");
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
  	public long getCOD_TPL_DPI(){
      return COD_TPL_DPI;
    }
  //2 NOM_TPL_DPI ()
	public void setNOM_TPL_DPI(String newNOM_TPL_DPI){
			if(NOM_TPL_DPI.equals(newNOM_TPL_DPI)) return;
      NOM_TPL_DPI = newNOM_TPL_DPI;
      setModified();
    }
	
  	public String getNOM_TPL_DPI(){
      return NOM_TPL_DPI;
    }
  //3 DES_CAR_DPI ()
	public void setDES_CAR_DPI(String newDES_CAR_DPI){
			if(DES_CAR_DPI.equals(newDES_CAR_DPI)) return;
      DES_CAR_DPI = newDES_CAR_DPI;
      setModified();
    }
  	public String getDES_CAR_DPI(){
      return DES_CAR_DPI;
    }
	//4 MDL_PTR_UTI_DPI ()
		public void setMDL_PTR_UTI_DPI(String newMDL_PTR_UTI_DPI){
      if(MDL_PTR_UTI_DPI != null) if(MDL_PTR_UTI_DPI.equals(newMDL_PTR_UTI_DPI)) return;
      MDL_PTR_UTI_DPI = newMDL_PTR_UTI_DPI;
      setModified();
    }
  	public String getMDL_PTR_UTI_DPI(){
		  if(MDL_PTR_UTI_DPI==null){return "";}
      return MDL_PTR_UTI_DPI;
    }
	//5 IMG_CSI_DPI ()
		public void setIMG_CSI_DPI(String newIMG_CSI_DPI){
      if(IMG_CSI_DPI != null) if(IMG_CSI_DPI.equals(newIMG_CSI_DPI)) return;
      IMG_CSI_DPI = newIMG_CSI_DPI;
      setModified();
    }
  	public String getIMG_CSI_DPI(){
      if(IMG_CSI_DPI==null){return "";}
			return IMG_CSI_DPI;
    }
  //6 CAG_DPI ()
		public void setCAG_DPI(long newCAG_DPI){
      if( CAG_DPI == newCAG_DPI ) return;
      CAG_DPI = newCAG_DPI;
	  setModified();
    }
  	public long getCAG_DPI(){
      return CAG_DPI;
    }
	//7 PER_MES_SST ()
		public void setPER_MES_SST(long newPER_MES_SST){
      if( PER_MES_SST == newPER_MES_SST ) return;
      PER_MES_SST = newPER_MES_SST;
	  setModified();
    }
  	public long getPER_MES_SST(){
      return PER_MES_SST;
    }
	//8 PER_MES_MNT ()
		public void setPER_MES_MNT(long newPER_MES_MNT){
      if( PER_MES_MNT == newPER_MES_MNT ) return;
      PER_MES_MNT = newPER_MES_MNT;
	  setModified();
    }
  	public long getPER_MES_MNT(){
      return PER_MES_MNT;
    }
   //</comment>
 
//-----------------------------#############################################
    // %%%Link%%% Table NOR_SEN_TPL_DPI_TAB
    public void addCOD_NOR_SEN(long newCOD_NOR_SEN){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("INSERT INTO nor_sen_tpl_dpi_tab (cod_nor_sen,cod_tpl_dpi) VALUES(?,?)");
		   ps.setLong(1, newCOD_NOR_SEN);
           ps.setLong(2, COD_TPL_DPI);
           ps.executeUpdate();
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
	}

    // %%%UNLink%%% Table NOR_SEN_TPL_DPI_TAB
    public void removeCOD_NOR_SEN(long newCOD_NOR_SEN){
      BMPConnection bmp=getConnection();
      try
      {
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM nor_sen_tpl_dpi_tab  WHERE cod_tpl_dpi=? AND cod_nor_sen=?");
         ps.setLong (1, COD_TPL_DPI);
         ps.setLong (2, newCOD_NOR_SEN);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Normative con ID="+newCOD_NOR_SEN+" non &egrave trovata");
      }
      catch(Exception ex)
      {
         throw new EJBException(ex);
      }
      finally{bmp.close();}
		}

   /////////////////////////////////////////////////
   // %%%Link%%% Table DOC_DPI_TAB
    public void addCOD_DOC(long newCOD_DOC){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("INSERT INTO doc_dpi_tab (cod_doc,cod_tpl_dpi) VALUES(?,?)");
		 ps.setLong (1, newCOD_DOC);
         ps.setLong (2, COD_TPL_DPI);
         ps.executeUpdate();
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
 	}

    // %%%UNLink%%% Table DOC_DPI_TAB
    public void removeCOD_DOC(long newCOD_DOC){
      BMPConnection bmp=getConnection();
      try
      {
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM doc_dpi_tab  WHERE cod_tpl_dpi=? AND cod_doc=?");
         ps.setLong (1, COD_TPL_DPI);
         ps.setLong (2, newCOD_DOC);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Documento con ID="+newCOD_DOC+" non &egrave trovato");
      }
      catch(Exception ex)
      {
         throw new EJBException(ex);
      }
      finally{bmp.close();}
		}

    //-----------------------------#############################################

 
 
   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>

   //<comment description="extended setters/getters">
   public Collection ejbGetTipologiaDPI_Name_View(){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_tpl_dpi,nom_tpl_dpi,per_mes_sst,per_mes_mnt FROM tpl_dpi_tab ORDER BY nom_tpl_dpi ");
		  ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            TipologiaDPI_Name_View obj=new TipologiaDPI_Name_View();
            obj.COD_TPL_DPI=rs.getLong(1);
            obj.NOM_TPL_DPI=rs.getString(2);
			//Added params by Podmasteriev at 5/03/2004
            obj.PER_MES_SST=rs.getLong(3);
            obj.PER_MES_MNT=rs.getLong(4);
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
	
//--- view dla ANA_NOR_SEN cherez nor_sen_tpl_dpi_tab
   public Collection ejbGetNormativeSentenzeByTPLID_View(long COD_TPL_DPI){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT ns.cod_nor_sen, ns.dat_nor_sen, ns.num_doc_nor_sen, ns.tit_nor_sen FROM ana_nor_sen_tab ns, nor_sen_tpl_dpi_tab nstdpi WHERE nstdpi.cod_nor_sen=ns.cod_nor_sen AND nstdpi.cod_tpl_dpi=? order by ns.tit_nor_sen ");
		ps.setLong(1, COD_TPL_DPI);
		ResultSet rs=ps.executeQuery();
        java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            NormativeSentenzeByTPLID_View obj=new NormativeSentenzeByTPLID_View();
            obj.COD_NOR_SEN=rs.getLong(1);
						obj.DAT_NOR_SEN=rs.getDate(2);
            obj.NUM_DOC_NOR_SEN=rs.getString(3);
						obj.TIT_NOR_SEN=rs.getString(4);
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
//--- view dla ANA_DOC_TAB cherez DOC_DPI_TAB
   public Collection ejbGetDocumentByTPLDPIID_View(long COD_TPL_DPI){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT d.cod_doc, d.tit_doc, d.rsp_doc, d.dat_rev_doc FROM  ana_doc_tab d, doc_dpi_tab dd WHERE d.cod_doc = dd.cod_doc AND dd.cod_tpl_dpi=? order by d.tit_doc ");
		ps.setLong(1, COD_TPL_DPI);
		ResultSet rs=ps.executeQuery();
        java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            DocumentByTPLDPIID_View obj=new DocumentByTPLDPIID_View();
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
     finally{bmp.close();}
  }
  //-------------------
  //</comment>       
  public void removeLUO_FSC_DPI(){
	  BMPConnection bmp=getConnection();
    try{
      PreparedStatement ps=bmp.prepareStatement("DELETE FROM dpi_luo_fsc_tab  WHERE cod_tpl_dpi=? ");
			ps.setLong(1, COD_TPL_DPI);
      ps.executeUpdate();
    }catch(Exception ex){
       throw new EJBException(ex);
    }
    finally { bmp.close(); }
	}
	public void removeGEST_MAN_DPI(){
	  BMPConnection bmp=getConnection();
    try{
      PreparedStatement ps=bmp.prepareStatement("DELETE FROM dpi_man_tab WHERE cod_tpl_dpi=? ");
			ps.setLong(1, COD_TPL_DPI);
      ps.executeUpdate();
    }catch(Exception ex){
       throw new EJBException(ex);
    }
    finally { bmp.close(); }
	}

	//---- for search ---//
	public Collection findEx(  
		String strNOM_TPL_DPI,
		String strDES_CAR_DPI,
		int iOrderParameter 
	){
		return ejbFindEx(strNOM_TPL_DPI, strDES_CAR_DPI, iOrderParameter);
	}
	
	public Collection ejbFindEx( 
		String strNOM_TPL_DPI,
		String strDES_CAR_DPI,
		int iOrderParameter //not used for now
	){
		String strSql="SELECT cod_tpl_dpi, nom_tpl_dpi, des_car_dpi, mdl_ptr_uti_dpi, per_mes_sst, per_mes_mnt,  img_csi_dpi, cag_dpi FROM tpl_dpi_tab";
		String strWhere="";
		if(strNOM_TPL_DPI!=null){
				strWhere+=" AND UPPER(nom_tpl_dpi) LIKE ? ";
		}
		if(strDES_CAR_DPI!=null){
				strWhere+=" AND UPPER(des_car_dpi) LIKE ? ";
		}
		if (!strWhere.equals("")) strWhere=" WHERE " + strWhere.substring(5, strWhere.length());
		strSql=strSql + strWhere + " ORDER BY UPPER(nom_tpl_dpi)";
		int i=1;
		BMPConnection bmp=getConnection();
		try{
		  PreparedStatement ps=bmp.prepareStatement(strSql);
		  if(strNOM_TPL_DPI!=null) ps.setString(i++, strNOM_TPL_DPI.toUpperCase());
		  if(strDES_CAR_DPI!=null) ps.setString(i++, strDES_CAR_DPI.toUpperCase());
		  ResultSet rs=ps.executeQuery();
	      java.util.ArrayList ar= new java.util.ArrayList();
	      while(rs.next()){
	      	TipologiaDPI_Name_Desc obj=new TipologiaDPI_Name_Desc();
	        obj.COD_TPL_DPI=rs.getLong(1);
            obj.NOM_TPL_DPI=rs.getString(2);
			obj.DES_CAR_DPI=rs.getString(3);
            obj.MDL_PTR_UTI_DPI=rs.getString(4);
	        ar.add(obj); 
	      }
		  return ar;
		}catch(Exception ex){
			throw new EJBException(strSql+"/n"+ex);
      }finally{bmp.close();}
	}
	
///////////ATTENTION!!/////////////////////////////////////////////
}//<comment description="end of implementation  TipologiaDPIBean"/>
%>
<%
////////////////////////////////////////// <BINDING> //////////
PseudoContext.bind("TipologiaDPIBean", new TipologiaDPIBean());
////////////////////////////////////////// </BINDING>//////////
%>

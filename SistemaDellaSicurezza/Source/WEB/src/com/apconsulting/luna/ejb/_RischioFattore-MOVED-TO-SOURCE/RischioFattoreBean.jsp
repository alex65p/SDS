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
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.util.*"%>

<%!
public class RischioFattoreBean extends BMPEntityBean implements IRischioFattore, IRischioFattoreHome
{
  //<member-varibles description="Member Variables">
	long lCOD_FAT_RSO;
	String strNOM_FAT_RSO;
	String strDES_FAT_RSO;
	long lNUM_FAT_RSO;
	long lCOD_CAG_FAT_RSO;
	long lCOD_NOR_SEN;
  //</member-varibles>

 //<IRischioFattoreHome-implementation>

      public static final String BEAN_NAME="RischioFattoreBean";
      
      public RischioFattoreBean(){}

      public void remove(Object primaryKey){
            RischioFattoreBean bean=new RischioFattoreBean();
            try{
              Object obj=bean.ejbFindByPrimaryKey((Long)primaryKey);
              bean.setEntityContext(new EntityContextWrapper(obj));
              bean.ejbActivate();
              bean.ejbLoad();
              bean.ejbRemove();
            }
            catch(Exception ex){
            	ex.printStackTrace();
              throw new EJBException(ex.getMessage());
            }
      }

      public IRischioFattore create(String strNOM_FAT_RSO, long lNUM_FAT_RSO, long lCOD_CAG_FAT_RSO) throws javax.ejb.CreateException {
         RischioFattoreBean bean=new RischioFattoreBean();
             try{
              Object primaryKey=bean.ejbCreate(  strNOM_FAT_RSO, lNUM_FAT_RSO, lCOD_CAG_FAT_RSO);
              bean.setEntityContext(new EntityContextWrapper(primaryKey));
              bean.ejbPostCreate(  strNOM_FAT_RSO, lNUM_FAT_RSO, lCOD_CAG_FAT_RSO);
              return bean;
            }
            catch(Exception ex){
            	ex.printStackTrace();
              throw new javax.ejb.CreateException(ex.getMessage());
            }
      }

      public IRischioFattore findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException{
      RischioFattoreBean bean=new RischioFattoreBean();
			try{
					bean.setEntityContext(new EntityContextWrapper(primaryKey));
					bean.ejbActivate();
					bean.ejbLoad();
					return bean;
			}
			catch(Exception ex){
      	ex.printStackTrace();
        throw new javax.ejb.FinderException(ex.getMessage());
      }
    }
      
      public Collection findAll() throws javax.ejb.FinderException {
			try{
				return this.ejbFindAll();
			}
			catch(Exception ex){
				ex.printStackTrace();
				throw new javax.ejb.FinderException(ex.getMessage());
			}
      }
  public Long ejbCreate(String strNOM_FAT_RSO, long lNUM_FAT_RSO, long lCOD_CAG_FAT_RSO)
  {
	this.lCOD_FAT_RSO= NEW_ID();
	this.strNOM_FAT_RSO=strNOM_FAT_RSO;
	this.lNUM_FAT_RSO=lNUM_FAT_RSO;
	this.lCOD_CAG_FAT_RSO=lCOD_CAG_FAT_RSO;
    
	this.unsetModified();

	BMPConnection bmp=getConnection();
	try{

		PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_fat_rso_tab (cod_fat_rso,nom_fat_rso,num_fat_rso,cod_cag_fat_rso) VALUES(?,?,?,?)");
			ps.setLong(1, lCOD_FAT_RSO);
			ps.setString(2, strNOM_FAT_RSO);
			ps.setLong(3, lNUM_FAT_RSO);
			ps.setLong(4, lCOD_CAG_FAT_RSO);
			ps.executeUpdate();
		return new Long(lCOD_FAT_RSO);
	}
	catch(Exception ex){
		ex.printStackTrace();
		throw new EJBException(ex);
	}
	finally{bmp.close();}
  }

  public void ejbPostCreate(String strNOM_FAT_RSO, long lNUM_FAT_RSO, long lCOD_CAG_FAT_RSO) { }

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_fat_rso FROM ana_fat_rso_tab");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            al.add(new Long(rs.getLong(1)));
          }
          return al;
      }
      catch(Exception ex){
      	ex.printStackTrace();
        throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

  public Long ejbFindByPrimaryKey(Long primaryKey){
    return primaryKey;
  }

  public void ejbActivate(){
    this.lCOD_FAT_RSO=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.lCOD_FAT_RSO=-1;
  }

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT cod_fat_rso,nom_fat_rso,des_fat_rso,num_fat_rso,cod_cag_fat_rso,cod_nor_sen FROM ana_fat_rso_tab WHERE cod_fat_rso=?");
           ps.setLong(1, lCOD_FAT_RSO);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
            lCOD_FAT_RSO=rs.getLong(1);
			strNOM_FAT_RSO=rs.getString(2);
			strDES_FAT_RSO=rs.getString(3);
			lNUM_FAT_RSO=rs.getLong(4);
			lCOD_CAG_FAT_RSO=rs.getLong(5);
			lCOD_NOR_SEN=rs.getLong(6);
           }
           else{
              throw new NoSuchEntityException("RischioFattore with ID="+lCOD_FAT_RSO+" not found");
           }
      }
      catch(Exception ex){
      	ex.printStackTrace();
        throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

  public void ejbRemove(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_fat_rso_tab WHERE cod_fat_rso=?");
         ps.setLong(1, lCOD_FAT_RSO);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("RischioFattore with ID="+lCOD_FAT_RSO+" not found");
      }
      catch(Exception ex){
      	ex.printStackTrace();
        throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

  public void ejbStore()
  {
    if(!isModified()) return;
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_fat_rso_tab SET cod_fat_rso=?, nom_fat_rso=?, des_fat_rso=?, num_fat_rso=?, cod_cag_fat_rso=?, cod_nor_sen=? WHERE cod_fat_rso=?");
			ps.setLong(1, lCOD_FAT_RSO);
			ps.setString(2, strNOM_FAT_RSO);
			ps.setString(3, strDES_FAT_RSO);
			ps.setLong(4, lNUM_FAT_RSO);
			ps.setLong(5, lCOD_CAG_FAT_RSO);
			if(lCOD_NOR_SEN==0) ps.setNull(6,java.sql.Types.BIGINT); else ps.setLong(6, lCOD_NOR_SEN);
			ps.setLong(7, lCOD_FAT_RSO);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("RischioFattore with ID="+lCOD_FAT_RSO+" not found");
      }
      catch(Exception ex){
      	ex.printStackTrace();
        throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
	//<alex "19/03/2004">
	public void deleteFattoriRischiByAttivita(long lCOD_AZL, long lCOD_MAN){
		ejbDeleteFattoriRischiByAttivita(lCOD_AZL,lCOD_MAN);
	}
	public void addFattoreRischioPerAttivita(long lCOD_AZL, long lCOD_MAN, long lCOD_FAT_RSO){
		 ejbAddFattoreRischioPerAttivita( lCOD_AZL,  lCOD_MAN, lCOD_FAT_RSO);
	}
	
	public void deleteFattoriRischiByUnita(long lCOD_AZL, long lCOD_UNI_ORG){
		ejbDeleteFattoriRischiByUnita(lCOD_AZL, lCOD_UNI_ORG);
	}
	public void addFattoreRischioPerUnita(long lCOD_AZL, long lCOD_UNI_ORG, long lCOD_FAT_RSO){
		 ejbAddFattoreRischioPerUnita( lCOD_AZL,  lCOD_UNI_ORG, lCOD_FAT_RSO);
	}
	
  //<views>
	public Collection getFattoreRischio_View(){
		return (new  RischioFattoreBean()).ejbGetFattoreRischio_View();
	}
	
 	public Collection getReport_RischioFattore_RischioView(long lCOD_AZL, long lCOD_MAN, long lCOD_FAT_RSO){
		return this.ejbGetReport_RischioFattore_RischioView(lCOD_AZL, lCOD_MAN, lCOD_FAT_RSO);
	}
	
	public Collection getReport_RischioFattore_ComboView(long lCOD_AZL, long lCOD_MAN, long lCOD_CAG_FAT_RSO){
  		return this.ejbGetReport_RischioFattore_ComboView(lCOD_AZL, lCOD_MAN, lCOD_CAG_FAT_RSO);
  	}
	 //<alex "19/03/2004">
	 public Collection getFattoriWithoutRischiView(long lCOD_AZL, long lCOD_MAN){
  	 	return (new  RischioFattoreBean()).ejbGetFattoriWithoutRischi(lCOD_AZL, lCOD_MAN);
	 }
	 public Collection getFattoriUWithoutRischiView(long lCOD_AZL, long lCOD_UNI_ORG){
  	 	return (new  RischioFattoreBean()).ejbGetFattoriUWithoutRischi(lCOD_AZL, lCOD_UNI_ORG);
	 }
	 
  	public Collection ejbGetReport_RischioFattore_RischioView(long lCOD_AZL, long lCOD_MAN, long lCOD_FAT_RSO){
	  BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement
                  (SQLContainer.getReport_RischioFattore_RischioViewQUERY());
		  ps.setLong(1, lCOD_MAN);
		  ps.setLong(2, lCOD_FAT_RSO);
		  ps.setLong(3, lCOD_AZL);
		   
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            Report_RischioFattore_RischioView view = new Report_RischioFattore_RischioView();
	            view.lCOD_RSO=rs.getLong(1);
	            view.strNOM_RSO=rs.getString(2);
				view.strDES_RSO=rs.getString(3);
				view.lPRB_EVE_LES=rs.getLong(4);
				view.lENT_DAN=rs.getLong(5);
				view.lSTM_NUM_RSO=rs.getFloat(6);
                                view.lFRQ_RIP_ATT_DAN=rs.getLong(7);
                                view.lNUM_INC_INF=rs.getLong(8);
            al.add(view);
          }
          return al;
      }
      catch(Exception ex){
      	ex.printStackTrace();
        throw new EJBException(ex);
      }
      finally{bmp.close();}		
	}

	public Collection getComboView(long lCOD_AZL, long lCOD_UNI_ORG, long lCOD_CAG_FAT_RSO){
		return ejbGetComboView(lCOD_AZL, lCOD_UNI_ORG, lCOD_CAG_FAT_RSO);
	}
	
 	public Collection ejbGetComboView(long lCOD_AZL, long lCOD_UNI_ORG, long lCOD_CAG_FAT_RSO){
      BMPConnection bmp=getConnection();
      try{
		 PreparedStatement ps=bmp.prepareStatement(SQLContainer.getEjbGetComboView());

          ps.setLong(1, lCOD_CAG_FAT_RSO);
		  ps.setLong(2, lCOD_UNI_ORG);
		  ps.setLong(3, lCOD_AZL);
		  ps.setLong(4, lCOD_UNI_ORG);
		  ps.setLong(5, lCOD_AZL);
		  

          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            RischioFattore_ComboView2 obj=new RischioFattore_ComboView2();
				obj.lCOD_FAT_RSO=rs.getLong(1);
				obj.strNOM_FAT_RSO=rs.getString(2);
				obj.lNUM_FAT_RSO=rs.getLong(3);
            al.add(obj);
          }
          return al;
      }
      catch(Exception ex){
      	ex.printStackTrace();
        throw new EJBException(ex);
      }
     finally{bmp.close();}
	}
	
public Collection getReport_RischioFattore_RischioView2(long lCOD_AZL, long lCOD_LUO_FSC, long lCOD_FAT_RSO){
		return this.ejbGetReport_RischioFattore_RischioView2(lCOD_AZL, lCOD_LUO_FSC, lCOD_FAT_RSO);
	}
	
	public Collection ejbGetReport_RischioFattore_RischioView2(long lCOD_AZL, long lCOD_UNI_ORG, long lCOD_FAT_RSO){
	      BMPConnection bmp=getConnection();
	      try{
	          PreparedStatement ps=bmp.prepareStatement(
			  SQLContainer.getReport_RischioFattore_RischioView2QUERY());
	          ps.setLong(1,lCOD_AZL);
			  ps.setLong(2,lCOD_FAT_RSO);
			  ps.setLong(3,lCOD_UNI_ORG);
	          ResultSet rs=ps.executeQuery();
	          java.util.ArrayList al=new java.util.ArrayList();
	          while(rs.next()){
		           Report_RischioFattore_RischioView view = new Report_RischioFattore_RischioView();
			            view.lCOD_RSO=rs.getLong(1);
			            view.strNOM_RSO=rs.getString(2);
						view.strDES_RSO=rs.getString(3);
						view.lPRB_EVE_LES=rs.getLong(4);
						view.lENT_DAN=rs.getLong(5);
						view.lSTM_NUM_RSO=rs.getFloat(6);
                                                view.lFRQ_RIP_ATT_DAN=rs.getLong(7);
                                                view.lNUM_INC_INF=rs.getLong(8);
	            al.add(view);
	          }
	          return al;
	      }
	      catch(Exception ex){
	      	ex.printStackTrace();
	        throw new EJBException(ex);
	      }
	     finally{bmp.close();}
	}
	
	public Collection ejbGetReport_RischioFattore_ComboView(long lCOD_AZL, long lCOD_MAN, long lCOD_CAG_FAT_RSO){
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement
                  (SQLContainer.getEjbGetReport_RischioFattore_ComboView());
          ps.setLong(1, lCOD_CAG_FAT_RSO);
		  ps.setLong(2, lCOD_MAN);
		  ps.setLong(3, lCOD_AZL);
		  ps.setLong(4, lCOD_MAN);
		  ps.setLong(5, lCOD_AZL);
		  ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            RischioFattore_ComboView2 view = new RischioFattore_ComboView2();
            view.lCOD_FAT_RSO=rs.getLong(1);
            view.strNOM_FAT_RSO=rs.getString(2);
			view.lNUM_FAT_RSO=rs.getLong(3);
            al.add(view);
          }
          return al;
      }
      catch(Exception ex){
      	ex.printStackTrace();
        throw new EJBException(ex);
      }
      finally{bmp.close();}		
	}
	
	public Collection getComboView(){
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_fat_rso, nom_fat_rso  FROM ana_fat_rso_tab ORDER BY 2");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            RischioFattore_ComboView view = new RischioFattore_ComboView();
            view.lCOD_FAT_RSO=rs.getLong(1);
            view.strNOM_FAT_RSO=rs.getString(2);
            al.add(view);
          }
          return al;
      }
      catch(Exception ex){
      	ex.printStackTrace();
        throw new EJBException(ex);
      }
      finally{bmp.close();}		
	}
  //</views>
  //<setter-getters>
  
	public long getCOD_FAT_RSO(){
		return lCOD_FAT_RSO;
	}

	public String getNOM_FAT_RSO(){
		return strNOM_FAT_RSO;
	}

	public void setNOM_FAT_RSO(String strNOM_FAT_RSO){
		if(  (this.strNOM_FAT_RSO!=null) && (this.strNOM_FAT_RSO.equals(strNOM_FAT_RSO))  ) return;
		this.strNOM_FAT_RSO=strNOM_FAT_RSO;
		setModified();
	}

	public String getDES_FAT_RSO(){
		return strDES_FAT_RSO;
	}

	public void setDES_FAT_RSO(String strDES_FAT_RSO){
		if(  (this.strDES_FAT_RSO!=null) && (this.strDES_FAT_RSO.equals(strDES_FAT_RSO))  ) return;
		this.strDES_FAT_RSO=strDES_FAT_RSO;
		setModified();
	}

	public long getNUM_FAT_RSO(){
		return lNUM_FAT_RSO;
	}

	public void setNUM_FAT_RSO(long lNUM_FAT_RSO){
		if(this.lNUM_FAT_RSO==lNUM_FAT_RSO) return;
		this.lNUM_FAT_RSO=lNUM_FAT_RSO;
		setModified();
	}

	public long getCOD_CAG_FAT_RSO(){
		return lCOD_CAG_FAT_RSO;
	}

	public void setCOD_CAG_FAT_RSO(long lCOD_CAG_FAT_RSO){
		if(this.lCOD_CAG_FAT_RSO==lCOD_CAG_FAT_RSO) return;
		this.lCOD_CAG_FAT_RSO=lCOD_CAG_FAT_RSO;
		setModified();
	}

	public long getCOD_NOR_SEN(){
		return lCOD_NOR_SEN;
	}

	public void setCOD_NOR_SEN(long lCOD_NOR_SEN){
		if(this.lCOD_NOR_SEN==lCOD_NOR_SEN) return;
		this.lCOD_NOR_SEN=lCOD_NOR_SEN;
		setModified();
	}
  //</setter-getters>
// %%%Link%%% Table DOC_FAT_RSO_TAB
    public void addDOC_FAT_RSO(long lCOD_DOC){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("INSERT INTO doc_fat_rso_tab (cod_doc,cod_fat_rso) VALUES(?,?)");
         ps.setLong   (1, lCOD_DOC);
		     ps.setLong   (2, lCOD_FAT_RSO);
         ps.executeUpdate();
      }
      catch(Exception ex){
      	ex.printStackTrace();
        throw new EJBException(ex);
      }
      finally{bmp.close();}
 		}
    // %%%UNLink%%% Table DOC_FAT_RSO_TAB
    public void removeDOC_FAT_RSO(long lCOD_DOC){
      BMPConnection bmp=getConnection();
      try {
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM doc_fat_rso_tab  WHERE cod_doc=? AND cod_fat_rso=? ");
         ps.setLong (1, lCOD_DOC);
         ps.setLong (2, lCOD_FAT_RSO);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Documento con ID="+lCOD_DOC+" non &egrave trovata");
      }
      catch(Exception ex) {
      	ex.printStackTrace();
        throw new EJBException(ex);
      }
      finally{bmp.close();}
		}
		
	public Collection ejbGetFattoreRischio_View(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT cod_fat_rso, nom_fat_rso, num_fat_rso, des_fat_rso FROM ana_fat_rso_tab ORDER BY 2");
           ResultSet rs=ps.executeQuery();
		       java.util.ArrayList ar=new java.util.ArrayList();
           while(rs.next()){
		   		FattoreRischio_View obj= new FattoreRischio_View();
		  	  	obj.COD_FAT_RSO=rs.getLong("COD_FAT_RSO");
           	    obj.NOM_FAT_RSO=rs.getString("NOM_FAT_RSO");
			    obj.NUM_FAT_RSO=rs.getLong("NUM_FAT_RSO");
				obj.DES_FAT_RSO=rs.getString("DES_FAT_RSO");
				ar.add(obj);
           }
		   return ar;
      }
      catch(Exception ex){
      	ex.printStackTrace();
        throw new EJBException(ex);
      }
      finally{bmp.close();}		
  }
    //<artur>
	public Collection ejbGetFattoriUWithoutRischi(long lCOD_AZL, long lCOD_UNI_ORG){
  	  BMPConnection bmp=getConnection();
      try{
				String SQL="";
				SQL+="SELECT F.cod_fat_rso, F.NOM_fat_rso, 0 ";
				SQL+="FROM 	ANA_FAT_RSO_TAB F ";
				SQL+="WHERE F.cod_fat_rso NOT IN ( ";
				SQL+="	SELECT DISTINCT D.cod_fat_rso ";
				SQL+="	FROM RSO_LUO_FSC_TAB C, ANA_LUO_FSC_TAB B, UNI_ORG_LUO_FSC_TAB A, ANA_FAT_RSO_TAB D, ANA_RSO_TAB R ";
				SQL+="	WHERE  ";
				SQL+="	 C.PRS_RSO = 'S' ";
				SQL+="	 AND C.COD_LUO_FSC = B.COD_LUO_FSC ";
				SQL+="	 AND A.COD_LUO_FSC = B.COD_LUO_FSC ";
				SQL+="	 AND R.COD_RSO = C.COD_RSO ";
				SQL+="	 AND R.COD_AZL = C.COD_AZL ";
				SQL+="	 AND C.COD_AZL =? ";
				SQL+="	 AND cod_uni_org= ? ) ";
				SQL+="	AND F.COD_FAT_RSO NOT IN ( ";
				SQL+="    SELECT G.cod_fat_rso FROM ana_uni_org_fat_rso_tab G ";
				SQL+="    WHERE 	G.COD_AZL = ? AND G.cod_uni_org = ?) ";
				SQL+="UNION ";
				SQL+="SELECT 	A.cod_fat_rso, A.nom_fat_rso, 1 ";
				SQL+="FROM ana_fat_rso_tab A, ana_uni_org_fat_rso_tab G ";
				SQL+="WHERE A.COD_FAT_RSO = g.COD_FAT_RSO ";
				SQL+="	AND G.COD_AZL = ? AND G.cod_uni_org = ? ";
				SQL+="	AND A.COD_FAT_RSO NOT IN ( ";
				SQL+="		 SELECT DISTINCT D.cod_fat_rso ";
				SQL+="		 FROM RSO_LUO_FSC_TAB C, ANA_LUO_FSC_TAB B, UNI_ORG_LUO_FSC_TAB A, ANA_FAT_RSO_TAB D, ANA_RSO_TAB R ";
				SQL+="		 WHERE  ";
				SQL+="			 C.PRS_RSO = 'S' ";
				SQL+="			 AND C.COD_LUO_FSC = B.COD_LUO_FSC ";
				SQL+="			 AND A.COD_LUO_FSC = B.COD_LUO_FSC ";
				SQL+="			 AND R.COD_RSO = C.COD_RSO ";
				SQL+="			 AND R.COD_AZL = C.COD_AZL ";
				SQL+="			 AND C.COD_AZL =? ";
				SQL+="			 AND cod_uni_org=?) ";
				SQL+="ORDER BY 2";

			  PreparedStatement ps=bmp.prepareStatement(SQL);
			  ps.setLong(1, lCOD_AZL);
			  ps.setLong(2, lCOD_UNI_ORG);
			  ps.setLong(3, lCOD_AZL);
			  ps.setLong(4, lCOD_UNI_ORG);
			  ps.setLong(5, lCOD_AZL);
			  ps.setLong(6, lCOD_UNI_ORG);
			  ps.setLong(7, lCOD_AZL);
			  ps.setLong(8, lCOD_UNI_ORG);	  
		  
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            FattoreRischio_View obj=new FattoreRischio_View();
            obj.COD_FAT_RSO=rs.getLong(1);
            obj.NOM_FAT_RSO=rs.getString(2);
            obj.lFlag=rs.getLong(3);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
      	ex.printStackTrace();
        throw new EJBException(ex);
      }
     finally{bmp.close();}
	}
	
	public void ejbDeleteFattoriRischiByUnita(long lCOD_AZL, long lCOD_UNI_ORG){
		BMPConnection bmp=getConnection();
		  try{
          PreparedStatement ps=bmp.prepareStatement("delete from ana_uni_org_fat_rso_tab where cod_azl=? and cod_uni_org=?");
		  ps.setLong(1, lCOD_AZL);
		  ps.setLong(2, lCOD_UNI_ORG);
		  ps.executeUpdate();
      }
      catch(Exception ex){
      	ex.printStackTrace();
        throw new EJBException(ex);
      }
     finally{bmp.close();}
	}

	public void ejbAddFattoreRischioPerUnita(long lCOD_AZL, long lCOD_UNI_ORG, long COD_FAT_RSO){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_uni_org_fat_rso_tab (cod_azl,cod_uni_org,cod_fat_rso) VALUES(?,?,?)");
         ps.setLong(1, lCOD_AZL);
		 ps.setLong(2, lCOD_UNI_ORG);
		 ps.setLong(3, COD_FAT_RSO);
         ps.executeUpdate();
      }
      catch(Exception ex){
      	ex.printStackTrace();
        throw new EJBException(ex);
      }
      finally{bmp.close();}
	}
	
	//</artur>
	//<alex "19/03/2004">
	public Collection ejbGetFattoriWithoutRischi(long lCOD_AZL, long lCOD_MAN){
  	  BMPConnection bmp=getConnection();
      try{
		  PreparedStatement ps=bmp.prepareStatement("select 	a.cod_fat_rso, a.nom_fat_rso, 0 from ana_fat_rso_tab a where 	a.cod_fat_rso not in (select distinct a.cod_fat_rso	from   ana_rso_tab a, rso_man_tab b where  a.cod_azl = b.cod_azl and a.cod_rso = b.cod_rso and b.prs_rso = 'S' and b.cod_man = ? and a.cod_azl = ?) and a.cod_fat_rso not in (select g.cod_fat_rso from ana_man_fat_rso_tab g where g.cod_man = ? and g.cod_azl = ?) union all select a.cod_fat_rso, a.nom_fat_rso, 1 from ana_fat_rso_tab a, ana_man_fat_rso_tab g where a.cod_fat_rso = g.cod_fat_rso and g.cod_man = ?	and g.cod_azl = ? and a.cod_fat_rso not in (select distinct a.cod_fat_rso from   ana_rso_tab a, rso_man_tab b where  a.cod_azl = b.cod_azl	and a.cod_rso = b.cod_rso	and b.prs_rso = 'S' and b.cod_man = ? and a.cod_azl = ?) order by 2");
		  ps.setLong(1, lCOD_MAN);
		  ps.setLong(2, lCOD_AZL);
		  ps.setLong(3, lCOD_MAN);
		  ps.setLong(4, lCOD_AZL);
		  ps.setLong(5, lCOD_MAN);
		  ps.setLong(6, lCOD_AZL);
		  ps.setLong(7, lCOD_MAN);
		  ps.setLong(8, lCOD_AZL);
		  
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            FattoreRischio_View obj=new FattoreRischio_View();
            obj.COD_FAT_RSO=rs.getLong(1);
            obj.NOM_FAT_RSO=rs.getString(2);
            obj.lFlag=rs.getLong(3);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
      	ex.printStackTrace();
        throw new EJBException(ex);
      }
     finally{bmp.close();}
	}
	
	public void ejbDeleteFattoriRischiByAttivita(long lCOD_AZL, long lCOD_MAN){
		BMPConnection bmp=getConnection();
		  try{
          PreparedStatement ps=bmp.prepareStatement("delete from ana_man_fat_rso_tab where cod_azl=? and cod_man=?");
		  ps.setLong(1, lCOD_AZL);
		  ps.setLong(2, lCOD_MAN);
		  ps.executeUpdate();
          bmp.close();
      }
      catch(Exception ex){
      	ex.printStackTrace();
        throw new EJBException(ex);
      }
     finally{bmp.close();}
	}

	public void ejbAddFattoreRischioPerAttivita(long lCOD_AZL, long lCOD_MAN, long lCOD_FAT_RSO){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_man_fat_rso_tab (cod_azl,cod_man,cod_fat_rso) VALUES(?,?,?)");
         ps.setLong(1, lCOD_AZL);
		 ps.setLong(2, lCOD_MAN);
		 ps.setLong(3, lCOD_FAT_RSO);
         ps.executeUpdate();
      }
      catch(Exception ex){
      	ex.printStackTrace();
        throw new EJBException(ex);
      }
      finally{bmp.close();}
	}
	//</alex>
	public Collection findEx(String strNOM_FAT_RSO, String strDES_FAT_RSO, long lNUM_FAT_RSO, long lCOD_CAG_FAT_RSO, long lCOD_NOR_SEN, int iOrderParameter){
		return ejbFindEx(strNOM_FAT_RSO, strDES_FAT_RSO, lNUM_FAT_RSO, lCOD_CAG_FAT_RSO, lCOD_NOR_SEN, iOrderParameter);
	}

 	public Collection ejbFindEx(String strNOM_FAT_RSO, String strDES_FAT_RSO, long lNUM_FAT_RSO, long lCOD_CAG_FAT_RSO, long lCOD_NOR_SEN, int iOrderParameter){
		String strSql="SELECT cod_fat_rso, UPPER(nom_fat_rso) AS nom_fat_rso,des_fat_rso,num_fat_rso,cod_cag_fat_rso,cod_nor_sen FROM ana_fat_rso_tab ";
		boolean ifWhere = false;
		if (strNOM_FAT_RSO != null){
			strSql += " WHERE UPPER(nom_fat_rso) LIKE ? ";
			ifWhere = true;
		}
		if (strDES_FAT_RSO != null){
		  strSql += (ifWhere) ? " AND " : " WHERE ";
			strSql += "UPPER (des_fat_rso) LIKE ? ";
			ifWhere = true;
		}
		if (lNUM_FAT_RSO != 0){
		  strSql += (ifWhere) ? " AND " : " WHERE ";
			strSql += " num_fat_rso = ? ";
			ifWhere = true;
		}
		if (lCOD_CAG_FAT_RSO != 0){
	  	strSql += (ifWhere) ? " AND " : " WHERE ";
		strSql += " cod_cag_fat_rso IN (SELECT cod_cag_fat_rso FROM cag_fat_rso_tab WHERE cod_cag_fat_rso = ?) ";
			ifWhere = true;
		}
		if (lCOD_NOR_SEN != 0){
		  strSql += (ifWhere) ? " AND " : " WHERE ";
			strSql += " cod_nor_sen IN (SELECT cod_nor_sen FROM ana_nor_sen_tab WHERE cod_nor_sen = ?) ";
		}

		strSql += " ORDER BY 2 ";
		int i=1;
		BMPConnection bmp=getConnection();
	    try{
		PreparedStatement ps=bmp.prepareStatement(strSql);
		if(strNOM_FAT_RSO != null)ps.setString(i++, strNOM_FAT_RSO.toUpperCase());
		if(strDES_FAT_RSO != null)ps.setString(i++, strDES_FAT_RSO.toUpperCase());
		if(lNUM_FAT_RSO != 0)ps.setLong(i++, lNUM_FAT_RSO);
		if(lCOD_CAG_FAT_RSO != 0)ps.setLong(i++, lCOD_CAG_FAT_RSO);
		if(lCOD_NOR_SEN != 0)ps.setLong(i, lCOD_NOR_SEN);
	  	ResultSet rs=ps.executeQuery();
      	java.util.ArrayList ar= new java.util.ArrayList();
        while(rs.next()){
          FattoreRischio_View obj=new FattoreRischio_View();
           obj.COD_FAT_RSO = rs.getLong(1);
           obj.NOM_FAT_RSO = rs.getString(2);
           obj.DES_FAT_RSO = rs.getString(3);
		   obj.NUM_FAT_RSO = rs.getLong(4);
           ar.add(obj);
        }
			  return ar;
	     }
	     catch(Exception ex){
	     	ex.printStackTrace();
       	throw new EJBException("NUM_FAT_RSO= "+lNUM_FAT_RSO+"\nCOD_CAG= "+lCOD_CAG_FAT_RSO+"\nlCOD_NOR_SEN= "+lCOD_NOR_SEN+"\nSql= "+strSql+ex);
       }
       finally{
       	bmp.close();
       }
	}
}//========================================================================
%>
<%
///////////////////////////////////////////////////////////////////////////
PseudoContext.bind(RischioFattoreBean.BEAN_NAME, new RischioFattoreBean());
///////////////////////////////////////////////////////////////////////////
%>

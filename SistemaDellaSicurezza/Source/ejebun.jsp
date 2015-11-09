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
    <version number="1.0" date_start="25/01/2004 22:00"  date_finish="26/01/2004 2:30" author="Artur Denysenko">		
      <comments>
			   <comment date="25/01/2004" author="Artur Denysenko">
				   <description>Borites' i poborite</description>
			   </comment>		
      </comments> 
    </version>
  <-versions>
</file> 
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
*/
%>

<%@ include file="/WEB/src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="/WEB/src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="/WEB/src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%!
	HttpServletRequest g_request=null;
	HttpServletResponse g_response=null;
	
	boolean isNull(String strName){
		return ( g_request.getParameter(strName)==null);
	}

%>

<%
		g_request=request;
		g_response=response;

class Member{
	int iIndex;
	String strName;
	String strJavaType;
	String strJavaPrefix;
	String strJavaName;
	String strJdbcMethod;
	String strOriginalType;
	int iSqlType;
	boolean isNullable;
	int iInputSize;
	String strHtmlTag="INPUT";
	
	
	public String toString(){
		return strName+";" + strJavaType+";"+ iSqlType +";"+isNullable+";<br>";
	}
	
	public String methodPair(){
		return strJavaType+" "+strJavaName;
	}
}

class Generator extends BMPEntityBean{
	public void ejbRemove(){}
	public void ejbLoad(){}
	public void ejbStore(){}
	
	public void ejbActivate(){}
	public void ejbPassivate(){}
	
	private java.util.Vector m_members=new java.util.Vector();
	private java.util.Vector m_rmembers=new java.util.Vector();
	
	public Generator(String strTableName, String strKey) throws Exception{
		m_strKey=strKey.toUpperCase();
		m_strTableName=strTableName;
		this.ParseMembers();
	}
	
	private String m_strKey;
	private Member m_key;
	private String m_strTableName;
	
	protected void ParseMembers() throws Exception{
		PreparedStatement ps=getConnection().prepareStatement("SELECT * FROM " + (m_strTableName));
		ResultSetMetaData md=ps.executeQuery().getMetaData();
		for(int i=1; i<=md.getColumnCount(); i++){
			Member m = new Member();
				m.iIndex=i;
				m.strName=md.getColumnName(i).toUpperCase();
				m.iSqlType=md.isNullable(i);
				m.strOriginalType=md.getColumnTypeName(i);
				m.strJavaType=md.getColumnTypeName(i);
				//m.strJavaType=md.getColumnClassName();
				setJavaType(m);
				m.strJavaName=m.strJavaPrefix+m.strName;
				m.isNullable=md.isNullable(i)==java.sql.ResultSetMetaData.columnNullable;
				m.iInputSize=md.getColumnDisplaySize(i);
			m_members.add(m);
			
			m.isNullable=isNull(m.strName);
			
			if(!m.isNullable) {
				if (m.strName.equals(m_strKey)){
					m_key=m;
					continue;
				}
				m_rmembers.add(m);
			}
		}
	}
	
	protected String getJavaType(int iSqlType){
		return null;
	}
	
	protected void setJavaType(Member m) throws Exception{
		
		if(m.strOriginalType.equals("int8")) {
			m.strJavaType="long";
			m.strJavaPrefix="l";
			m.strJdbcMethod="Long";
			m.iInputSize=5;
			return;
		}
		if(m.strOriginalType.equals("date")){
			m.strJavaType= "java.sql.Date";
			m.strJavaPrefix="dt";
			m.strJdbcMethod="Date";
			m.iInputSize=10;
			return;
		}
		if(m.strOriginalType.equals("varchar")) {
			m.strJavaType="String";
			m.strJavaPrefix="str";
			m.strJdbcMethod="String";
			//m.iInputSize=1;
			return;
		}
		if(m.strOriginalType.equals("numeric")) {
			m.strJavaType="double";
			m.strJavaPrefix="db";
			m.strJdbcMethod="Double";
			m.iInputSize=20;
			return;
		}
		if(m.strOriginalType.equals("char")) {
			m.strJavaType="String";
			m.strJavaPrefix="str";
			m.strJdbcMethod="String";
			m.iInputSize=20;
			return;
		}	
		if(m.strOriginalType.equals("text")) {
			m.strJavaType="String";
			m.strJavaPrefix="str";
			m.strJdbcMethod="String";
			m.iInputSize=1;
			m.strHtmlTag="TEXTAREA";
			return;
		}	
		if(m.strOriginalType.equals("float8")) {
			m.strJavaType="double";
			m.strJavaPrefix="db";
			m.strJdbcMethod="Double";
			m.iInputSize=5;
			return;
		}	

		if(m.strOriginalType.equals("bpchar")) {
			m.strJavaType="String";
			m.strJavaPrefix="str";
			m.strJdbcMethod="String";
			m.iInputSize=1;
			return;
		}
				
		throw new Exception(m.strOriginalType);
	}
	
	protected String getStandartMethodHeader(int iMember, boolean isSet){
			Member m= (Member)m_members.get(iMember);
			if (isSet){
				return "public void set"+m.strName+"("+ m.methodPair()+")";
			}
			else{
				return "public "+m.strJavaType+" get"+m.strName+"()";
			}
	}
	public String getInterfaceMethods(){
		String str="";
		for(int i=0; i<m_members.size(); i++){
			str+="\t"+getStandartMethodHeader(i, false);
			str+=";\n";
			
			if(m_members.get(i).equals(m_key)) { str+="\n"; continue;}
			str+="\t"+getStandartMethodHeader(i, true);
			str+=";\n\n";
		}
		return str;
	}
	
	protected String getStandartMethodRealization(int iMember, boolean isSet){
		Member m= (Member)m_members.get(iMember);
		if (isSet){
			String str="";
			if (Character.isUpperCase(m.strJavaType.charAt(0))){ //Object
				
					str+="\t\tif(  (this."+m.strJavaName+"!=null) && ";
					str+="(this."+m.strJavaName+".equals("+m.strJavaName+"))  ) return;\n";
					str+="\t\tthis."+m.strJavaName+"="+m.strJavaName+";\n";
					str+="\t\tsetModified();";
					
					return str;
			}
			else{//simple type
					str+="\t\tif(this."+m.strJavaName+"=="+m.strJavaName+") return;\n";
					str+="\t\tthis."+m.strJavaName+"="+m.strJavaName+";\n";
					str+="\t\tsetModified();";
					return str;
			}
		}
		else{
			return "\t\treturn "+m.strJavaName+";";
		}
	}
	
	public String getStandartMethods(){
		String str="";
		for(int i=0; i<m_members.size(); i++){
			
			str+="\t"+getStandartMethodHeader(i, false);
			str+="{\n";
				str+=getStandartMethodRealization(i, false);
				str+="\n";
			str+="\t}\n\n";
			
			if(m_members.get(i).equals(m_key)) continue;
			str+="\t"+getStandartMethodHeader(i, true);
			str+="{\n";
				str+=getStandartMethodRealization(i, true);
				str+="\n";
			str+="\t}\n\n";
		}
		return str;		
	}
	
	
	public String  getRequiredMembers(){
		String str="   ";
		for(int i=0; i<m_rmembers.size(); i++){
			str+=((Member)m_rmembers.get(i)).methodPair()+", ";
		}
		return str.substring(1, str.length()-2).trim();
	}
	
	public String  getRequiredMemberNames(){
		String str="   ";
		for(int i=0; i<m_rmembers.size(); i++){
			str+=((Member)m_rmembers.get(i)).strJavaName+", ";
		}
		return str.substring(1, str.length()-2);
	}

	public String  getMembersList(){
		String str="";
		for(int i=0; i<m_members.size(); i++){
			str+="\t"+((Member)m_members.get(i)).methodPair()+";\n";
		}
		return str.substring(1, str.length()-1);
	}
	
	public String  getMembersAssigmentList(){
		String str="";
		for(int i=0; i<m_members.size(); i++){
			Member m = (Member)m_members.get(i);
			str+="\t"+m.strJavaName+"=bean.get"+m.strName+"();\n";
		}
		return str.substring(1, str.length()-1);
	}
	
	public String getAssign(Member m){
		return "this."+ m.strJavaName +"=" + m.strJavaName;
	}
	
	public String getAssigns(){
		String str="";
		str+="\t"+ "this."+ m_key.strJavaName +"= NEW_ID();\n";
		
		for(int i=0; i<m_rmembers.size(); i++){
			str+="\t"+getAssign((Member)m_rmembers.get(i))+";\n";
		}
		return str.substring(1, str.length()-1);	
	}
	
	public String getSqlSet(Member m){
		return "ps.set"+m.strJdbcMethod+"("+m.iIndex+", "+ m.strJavaName +")";
	}
	
	public String getRequredSqlSets(){
		String str="";
		str+="\t\t\t"+getSqlSetEx(m_key, 1)+";\n";
		for(int i=0; i<m_rmembers.size(); i++){
			Member m=(Member)m_rmembers.get(i);
			str+="\t\t\t"+getSqlSetEx(m, i+2)+";\n";
		}
		return str.substring(1, str.length()-1);			
	}
	
	private String SK(String str){
		return "\\\""+str.toLowerCase()+"\\\"";
	}
	public String getSqlInsert(){
		String str="";
		String str1="?,";
		str+=SK(m_key.strName)+",";
		
		for(int i=0; i<m_rmembers.size(); i++){
			Member m=(Member)m_rmembers.get(i);
			str+=SK(m.strName)+",";
			str1+="?,";
		}
		str=str.substring(0, str.length()-1);
		str1=str1.substring(0, str1.length()-1);
		return  "INSERT INTO "+ SK(m_strTableName)+" ("+ str +") VALUES("+ str1+")";

	}
	public String getSqlSelectIndex(){
		return  "SELECT " +  SK(m_key.strName) + " FROM " + SK(m_strTableName);
	}	
	public String getSqlSelect(){
		String str="";
		
		for(int i=0; i<m_members.size(); i++){
			Member m=(Member)m_members.get(i);
			str+=SK(m.strName)+",";
		}
		str=str.substring(0, str.length()-1);
		return  "SELECT " + str + " FROM " + SK(m_strTableName)+ " WHERE "+SK(m_key.strName)+"=?";		
	}
	
	public String getSqlGet(Member m){
		return  m.strJavaName +"="+ "rs.get"+m.strJdbcMethod+"("+m.iIndex+")";
	}
	
	public String getSelectSqlSets(){
		String str="";
		for(int i=0; i<m_members.size(); i++){
			Member m=(Member)m_members.get(i);
			str+="\t\t\t"+getSqlGet(m)+";\n";
		}
		return str.substring(1, str.length()-1);
	}
	
	public String getSqlDelete(){
		return  "DELETE FROM " + SK(m_strTableName)+ " WHERE "+SK(m_key.strName)+"=?";	
	}
	
	public String getSqlUpdate(){
		String str="";
		
		for(int i=0; i<m_members.size(); i++){
			Member m=(Member)m_members.get(i);
			if(m.equals(m_key)) continue;
			str+=SK(m.strName)+"=?, ";
		}
		str=str.substring(0, str.length()-2);
		return  "UPDATE " + SK(m_strTableName)+ " SET " +str+" WHERE "+SK(m_key.strName)+"=?";	
		
	}
	
	private String getSqlSet(Member m, int iIndex){
		return "ps.set"+m.strJdbcMethod+"("+iIndex+", "+ m.strJavaName +")";
	}

	private String getSqlSetEx(Member m, int iIndex){
		String str="";
		
		if(m.isNullable && m.strJdbcMethod.equals("Long")){
			str+="if("+ m.strJavaName +"==0) ps.setNull("+iIndex+",java.sql.Types.BIGINT);";
			str+=" else ps.set"+m.strJdbcMethod+"("+iIndex+", "+ m.strJavaName +")";
			return str;
		}
		else{
			return "ps.set"+m.strJdbcMethod+"("+iIndex+", "+ m.strJavaName +")";
		}
	}

	public String getAllSqlSets1(){
		String str=" ";
		int j=0;
		for(int i=0; i<m_members.size(); i++){
			Member m=(Member)m_members.get(i);
			if(m.equals(m_key)) continue;
			str+="\t\t\t"+getSqlSetEx(m, ++j)+";\n";
		}
		str+="\t\t\t"+getSqlSet(m_key, j+1)+";\n";
		return str.substring(1, str.length()-1);			
	}
			
	public String getAllSqlSets(){
		String str=" ";
		for(int i=0; i<m_members.size(); i++){
			Member m=(Member)m_members.get(i);
			str+="\t\t\t"+getSqlSetEx(m, m.iIndex)+";\n";
		}
		str+="\t\t\t"+getSqlSet(m_key, m_members.size()+1)+";\n";
		return str.substring(1, str.length()-1);			
	}
	
	
	public String getDate(){
		java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("dd/MM/yyyy");
		String s=sdf.format(new java.util.Date());
		return s;
	}
	
	private String SKK(String str){
		return "\""+str+"\"";
	}
	
	public String getSetOperators(){
		String str="";
		for(int i=0; i<m_members.size(); i++){
			Member m=(Member)m_members.get(i);
			str+=m.strJavaType+" ";
			str+=m.strJavaName+"";
			str+="=c.check"+m.strJdbcMethod+"("+SKK(m.strName)+",request.getParameter("+SKK(m.strName)+"),"+ (m.isNullable?false:true)+");\n";
		}
		return str.substring(0, str.length()-1);			
	}
	
	public String getSetBeanOperators(boolean bRequired){
		String str=" ";
		for(int i=0; i<m_members.size(); i++){
			Member m=(Member)m_members.get(i);
			if (bRequired && m.isNullable) continue;
			if (!bRequired && !m.isNullable) continue;
			
			if(m==m_key) continue;
			str+="\t\tbean.set";
			str+=m.strName+"(";
			str+=m.strJavaName+");\n";
		}
		return str.substring(0, str.length()-1);		
	}
	
	public String getInputs(){
		String str=" ";
		for(int i=0; i<m_members.size(); i++){
			Member m=(Member)m_members.get(i);
			if(m.strHtmlTag.equals("INPUT")){
				str+="<input type=\"text\" size=\""+m.iInputSize+"\" maxlength=\""+m.iInputSize+"\"  name=\""+m.strName+"\" value=\"<%=Formatter.format("+m.strJavaName+")%\>\">\n";
			}
			else{
				str+="<TEXTAREA cols=3 rows=4  name=\""+m.strName+"\"><%=Formatter.format("+m.strJavaName+")%\></TEXTAREA>\n";			
			}
		}
		return str.substring(0, str.length()-1);			
	}
			
}
%>
<h1><font color="red" >EJBun 1.0</font></h1>
<hr>
<%
Generator g=null;
String EJB_MAME=null;
try
{
	 //g =new Generator("ana_doc_vlu_tab","cod_doc_vlu");
	 g =new Generator(request.getParameter("TABLE"),request.getParameter("KEY"));
	 if (g.m_key==null) throw new Exception( request.getParameter("KEY")+ " not found in [" + request.getParameter("TABLE")+"]");
	 EJB_MAME=request.getParameter("NAME");
}
catch(Exception ex)
{
%>
			
<pre>
	<h4>
	<font color="red" ><%=ex.getMessage()%></font><br>
	Pishem vse pareametri v URL:
		BEAN - nazvanie Beana, naprimer  [User, Azienda, ....]
		TABLE - tabliza dlia kotoroy sozdaetsia, naprimer "ana_doc_vlu_tab"
		KEY - nazvanie polia kotoroe javlietsia primary keyem, naprimer "cod_doc_vlu"
	</h4>
</pre>
			
		<%
		return;
}
%>


<br>

<pre>
< %
/*
< file>
  < versions>	
    < version number="1.0" date="<%=g.getDate()%>" author="Artur Denysenko">		
      < comments>
			   < comment date="<%=g.getDate()%>" author="Artur Denysenko">
				   <description>Interfaces dlia objecta <%=EJB_MAME%></description>
			   < /comment>		
      < /comments> 
    < /version>
  < /versions>
< /file> 
*/
%>

< %@ page import="javax.ejb.*"%>
< %@ page import="java.util.*"%>

< %!
//< ejb-interfaces description="EJB Interfaces">

  public interface  I<%=EJB_MAME%> extends EJBObject
  {
  <%=g.getInterfaceMethods()%>
  }

  public interface I<%=EJB_MAME%>Home extends EJBHome
  {
     public I<%=EJB_MAME%> create(<%=g.getRequiredMembers()%>) throws CreateException;
     public I<%=EJB_MAME%> findByPrimaryKey(Long primaryKey) throws  FinderException;
     public Collection findAll() throws FinderException;
     public void remove(Object primaryKey);
  }
  
//< ejb-interfaces>
%>
</pre>
<hr>
<%//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////%>
<pre>
< %
/*
< file>
  < versions>	
    < version number="1.0" date="<%=g.getDate()%>" author="Artur Denysenko">		
      < comments>
			   < comment date="<%=g.getDate()%>" author="Artur Denysenko">
				   < description>Realizazija EJB dlia objecta <%=EJB_MAME%></description>
				 < /comment>		
      < /comments> 
    < /version>
  < /versions>
< /file> 
*/
%>

< %@ page import="javax.ejb.*"%>
< %@ page import="javax.naming.*"%>
< %@ page import="java.util.*"%>

< %!
public class <%=EJB_MAME%>Bean extends BMPEntityBean implements I<%=EJB_MAME%>, I<%=EJB_MAME%>Home

{
  //< member-varibles description="Member Variables">
	<%=g.getMembersList()%>
  //< /member-varibles>

 //< I<%=EJB_MAME%>Home-implementation>

      public static final String BEAN_NAME="<%=EJB_MAME%>Bean";
      
      public <%=EJB_MAME%>Bean(){}

      public void remove(Object primaryKey){
            <%=EJB_MAME%>Bean bean=new <%=EJB_MAME%>Bean();
            try{
              Object obj=bean.ejbFindByPrimaryKey((Long)primaryKey);
              bean.setEntityContext(new EntityContextWrapper(obj));
              bean.ejbActivate();
              bean.ejbLoad();
              bean.ejbRemove();
            }
            catch(Exception ex){
              throw new EJBException(ex.getMessage());
            }
      }

      public I<%=EJB_MAME%> create(<%=g.getRequiredMembers()%>) throws javax.ejb.CreateException {
         <%=EJB_MAME%>Bean bean=new <%=EJB_MAME%>Bean();
             try{
              Object primaryKey=bean.ejbCreate(<%=g.getRequiredMemberNames()%>);
              bean.setEntityContext(new EntityContextWrapper(primaryKey));
              bean.ejbPostCreate(<%=g.getRequiredMemberNames()%>);
              return bean;
            }
            catch(Exception ex){
              throw new javax.ejb.CreateException(ex.getMessage());
            }
      }

      public I<%=EJB_MAME%> findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException{
      <%=EJB_MAME%>Bean bean=new <%=EJB_MAME%>Bean();
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
 //</ I<%=EJB_MAME%>Home-implementation>

  public Long ejbCreate(<%=g.getRequiredMembers()%>)
  {
	<%=g.getAssigns()%>
    
	this.unsetModified();

	BMPConnection bmp=getConnection();
	try{

		PreparedStatement ps=bmp.prepareStatement("<%=g.getSqlInsert()%>");
	<%=g.getRequredSqlSets()%>
			ps.executeUpdate();
		return new Long(<%=g.m_key.strJavaName%>);
	}
	catch(Exception ex){
		throw new EJBException(ex);
	}
	finally{bmp.close();}
  }

  public void ejbPostCreate(<%=g.getRequiredMembers()%>) { }

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("<%=g.getSqlSelectIndex()%>");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            al.add(new Long(rs.getLong(1))); // performance of the [new] operator?
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
    this.<%=g.m_key.strJavaName%>=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.<%=g.m_key.strJavaName%>=-1;
  }

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("<%=g.getSqlSelect()%>");
           ps.setLong(1, <%=g.m_key.strJavaName%>);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
              <%=g.getSelectSqlSets()%>
           }
           else{
              throw new NoSuchEntityException("<%=EJB_MAME%> with ID="+<%=g.m_key.strJavaName%>+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("<%=g.getSqlDelete()%>");
         ps.setLong(1, <%=g.m_key.strJavaName%>);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("<%=EJB_MAME%> with ID="+<%=g.m_key.strJavaName%>+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("<%=g.getSqlUpdate()%>");
<%=g.getAllSqlSets1()%>
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("<%=EJB_MAME%> with ID="+<%=g.m_key.strJavaName%>+" not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }


  //< setter-getters>
  
<%=g.getStandartMethods()%>
  //< /setter-getters>
}
%>
< %
////////////////////////////////////////// <BINDING> /////////////////////////////////////////////////////////////////
PseudoContext.bind(<%=EJB_MAME%>Bean.BEAN_NAME, new <%=EJB_MAME%>Bean());
////////////////////////////////////////// </BINDING> /////////////////////////////////////////////////////////////////
%>

<hr>
< %
/*
< file>
  < versions>	
    < version number="1.0" date="<%=g.getDate()%>" author="Artur Denysenko">		
      < comments>
			   < comment date="<%=g.getDate()%>" author="Artur Denysenko">
				   < description>Realizazija EJB dlia objecta <%=EJB_MAME%></description>
			   < /comment>		
      < /comments> 
    < /version>
  < /versions>
< /file> 
*/
%>


< %@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
< %@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
< %@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
< %@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

< %@ include file="../src/com/apconsulting/luna/ejb/<%=EJB_MAME%>/<%=EJB_MAME%>Bean_Interfaces.jsp" %>
< %@ include file="../src/com/apconsulting/luna/ejb/<%=EJB_MAME%>/<%=EJB_MAME%>Bean.jsp" %>

< %@ include file="../_include/Checker.jsp" %>

< %!
	String ReqMODE;	// parameter of request 
%>

< script>
var err=false;
< /script>

< %
I<%=EJB_MAME%> bean=null;
//-----start check section--------------------------------
Checker c = new Checker();

<%=g.getSetOperators()%>

if (c.isError){
	String err = c.printErrors();
	out.print("< script>err=true;alert(\""+err+"\");< /script>");
	return;
}

I<%=EJB_MAME%>Home home=(I<%=EJB_MAME%>Home)PseudoContext.lookup("<%=EJB_MAME%>Bean");

//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
		bean = home.findByPrimaryKey(new Long(<%=g.m_key.strJavaName%>));
		
<%=g.getSetBeanOperators(true)%>	
	}
	else{
		bean=home.create(<%=g.getRequiredMemberNames()%>);
	}
	if(bean!=null){
<%=g.getSetBeanOperators(false)%>
	}
}
%>
< script>
 parent.window.returnValue="OK";
 parent.window.close();
< /script>
<hr>
<%=g.getMembersAssigmentList()%>
<hr>
<pre>
<%=g.getInputs()%>
</pre>

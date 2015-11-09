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

//****** AllWebMenus Libraries Version # 526 ******

// Copyright (c) Likno Software 2000-2004
// The present javascript code is property of Likno Software.
// This code can only be used inside Internet/Intranet web sites located on *web servers*, as the outcome of a licensed AllWebMenus application only. 
// This code *cannot* be used inside distributable implementations (such as demos, applications or CD-based webs), unless this implementation is licensed with an "AllWebMenus License for Distributed Applications". 
// Any unauthorized use, reverse-engineering, alteration, transmission, transformation, facsimile, or copying of any means (electronic or not) is strictly prohibited and will be prosecuted.
// ***Removal of the present copyright notice is strictly prohibited***

var awmhd=200,awmDefaultStatusbarText="",is60=(navigator.userAgent.indexOf("6.0")!=-1),n=null,awmcrm,awmcre,awmmo,awmso,awmctm=n,awmuc,awmud,awmctu,awmun,awmdid,awmsht="",awmsoo=0,awmNS6OffsetX,awmNS6OffsetY;var awmlsx=window.pageXOffset,awmlsy=window.pageYOffset,awmalt=["left","center","right"],awmplt=["absolute","relative"],awmvlt=["visible","hidden","inherit"],awmctlt=["default","pointer","crosshair","help","move","text","wait"];var awmwblt,isGecko1=parseFloat(navigator.userAgent.substring(navigator.userAgent.indexOf("rv:")+3,navigator.userAgent.indexOf("rv:")+4));var awmRightToLeftFrame;var awmCoordId,vl,vt,vr,vb;awmCoordinates();if (awmso>0){awmsoo=awmso+1;}else  {var awmsc=new Array();}var awmlssx=window.pageXOffset;var awmlssy=window.pageYOffset;var awmSelectedItem;if (!awmun) awmun=0;if (awmcre>=0); else  awmcre=0;var awmUnloadFunction;window.onresize = awmwr;
function awmhidediv(){var m=1;while (document.getElementById("awmflash"+m)){document.getElementById("awmflash"+m).style.visibility="hidden";m++;}}
function awmshowdiv(){var m=1;while (document.getElementById("awmflash"+m)){document.getElementById("awmflash"+m).style.visibility="visible";m++;}}
function awmiht (image){return "<img src='"+awmMenuPath+awmImagesPath+"/"+awmImagesColl[image*3]+"' width="+awmImagesColl[image*3+1]+" height="+awmImagesColl[image*3+2]+" align='absmiddle'>";}
function awmatai (text,image,algn){if (text==null) text="";var s1=(text!="" && text!=null && (algn==0 || algn==2) && image!=null)?"<br>":"";var s2=(image!=n)?awmiht (image):"";return "<nobr>"+((algn==0 || algn==3)?s2+s1+text:text+s1+s2)+"</nobr>";}
function awmCreateCSS (pos,vis,algnm,fgc,bgc,bgi,fnt,tdec,bs,bw,bc,pd,crs){if (awmso>=0) awmso++; else  awmso=0;var style={ id:"AWMST"+awmso,id2:"AWMSTTD"+awmso,pos:pos,vis:vis,algnm:algnm,fgc:fgc,bgc:bgc,bgi:bgi,fnt:fnt,tdec:tdec,bs:bs,bw:bw,bc:bc,zi:awmzindex,pd:pd,crs:crs};awmsht+="."+style.id+" {position:absolute; width:0px; visibility:"+awmvlt[vis]+"; "+"text-align:"+awmalt[algnm]+"; "+((fnt!=n)?"font:"+fnt+"; ":"")+((tdec!=n)?"text-decoration:"+tdec+"; ":"")+((fgc!=n)?"color:"+fgc+";":"")+"background-color:"+((bgc!=n)?bgc+"; ":"transparent; ")+((bgi!=n)?"background-image:url('"+awmMenuPath+awmImagesPath+"/"+awmImagesColl[bgi*3]+"'); ":"")+((bs!=n)?"border-style:"+bs+"; ":"")+((bw!=n)?"border-width:"+bw+"px; ":"")+((bc!=n)?"border-color:"+bc+"; ":"")+" cursor:"+awmctlt[crs]+";z-index:"+style.zi+"}";awmsht+="."+style.id2+" {border-style:none;border-width:0px;text-align:"+awmalt[algnm]+"; "+((fnt!=n)?"font:"+fnt+"; ":"")+((tdec!=n)?"text-decoration:"+tdec+"; ":"")+((fgc!=n)?"color:"+fgc+";":"")+"background-color:"+((bgc!=n && bgi==n)?bgc+";":"transparent;")+"}";awmsc[awmsc.length]=style;}
function awmCreateMenu (cll,swn,swr,mh,ud,sa,mvb,dft,crn,dx,dy,ss,ct,cs,ts,tn,ttt,ti,tia,dbi,ew,eh,jcoo,jcoc,opacity,elemRel){if (awmmo>=0) awmmo++; else  {awmm=new Array(); awmmo=0};var me={ ind:awmmo,nm:awmMenuName,cn:new Array(),fl:!awmsc[cs].pos,cll:cll,mvb:mvb,dft:dft,crn:crn,dx:(ct<2)?dx:0,dy:dy,ss:ss,sht:"<STYLE>"+awmsht+"</STYLE>",rep:0,mio:0,st:awmOptimize?2:3,submenusFrameOffset:awmSubmenusFrameOffset,selectedItem:(typeof(awmSelectedItem)=='undefined')?0:awmSelectedItem,opacity:(typeof(opacity)=='undefined')?100:opacity,offX:(awmNS6OffsetX)?awmNS6OffsetX:0,offY:(awmNS6OffsetY)?awmNS6OffsetY:0,elemRel:(typeof(elemRel)=='undefined')?0:elemRel,addSubmenu:awmas,ght:awmmght,whtd:awmmwhttd,buildMenu:awmbmm,cm:awmmcm};me.pm=me;me.addSubmenu(ct,swn,swr,mh,ud,sa,1,cs,ts,tn,ttt,ti,tia,dbi,ew,eh,jcoo,jcoc,opacity);if (typeof(awmRelativeCorner)=='undefined'){me.rc=0} else  {me.rc=awmRelativeCorner;awmRelativeCorner=0}me.cn[0].pi=null;if (mvb) document.onmousemove=awmotmm;awmm[awmmo]=me;awmsht="";return me.cn[0];}
function awmas (ct,swn,swr,shw,ud,sa,od,cs,ts,tn,ttt,ti,tia,dbi,ew,eh,jcoo,jcoc,opacity){cnt={ id:"AWMEL"+(awmcre++),it:new Array(),tid:"AWMEL"+(awmcre++),ct:ct,swn:swn,swr:swr,shw:(shw>2)?2:shw,ud:ud,sa:sa,od:od,cs:awmsc[cs+awmsoo],ts:(ts!=null)?awmsc[ts+awmsoo]:null,tn:tn,ttt:ttt,ti:ti,ht:(tn!=null || ti!=null),tia:tia,dbi:dbi,ew:ew,eh:eh,jcoo:jcoo,jcoc:jcoc,pi:this,pm:this.pm,pm:this.pm,siw:0,wtd:false,argd:0,ft:0,mio:0,hsid:null,uid:null,dox:0,doy:0,opacity:(typeof(opacity)=='undefined')?100:opacity,addItem:awmai,addItemWithImages:awmaiwi,show:awmcs,fe:awmcfe,arr:awmca,ght:awmcght,pc:awmpc,unf:awmcu,hdt:awmchdt,onmouseover:awmocmo,onmouseout:awmocmot,otmd:awmotmd,otmu:awmotmu,otmm:awmotmm};this.sm=cnt;cnt.pm.cn[cnt.ind=cnt.pm.cn.length]=cnt;cnt.cd=(cnt.ind==0 && cnt.pm.cll==0)?0:1;return cnt;}
function awmai (st0,st1,st2,in0,in1,in2,tt,sbt,jc0,jc1,jc2,url,tf,minWidth,minHeight){var itm={ id:"AWMEL"+(awmcre++),style:[(st0==n)?n:awmsc[st0+awmsoo],(st1==n)?n:awmsc[st1+awmsoo],(st2==n)?n:awmsc[st2+awmsoo]],inm:[in0,(in1==n)?in0:in1,(in2==n)?in0:in2],ii:[n,n,n],ia:[n,n,n],hsi:[n,n,n],tt:tt,sbt:sbt,jc:[jc0,jc1,jc2],tf:tf,top:0,left:0,layer:[n,n,n],ps:this,pm:this.pm,sm:null,minHeight:(minHeight)?minHeight:0,minWidth:(minWidth)?minWidth:0,ght:awmight,shst:awmiss,addSubmenu:awmas,onmouseover:awmoimo,onmouseout:awmoimot,onmousedown:awmoimd,onmouseup:awmoimu};if (url!=null){var prf=url.substring(0,7);if ((prf!="http://") && (prf!="https:/") && (prf!="mailto:") && (prf!="file://") && (url.substring(0,9)!="outlook:/") && (url.substring(0,6)!="ftp://") && (url.substring(0,6)!="mms://") && (url.substring(0,1)!="/")) url=awmMenuPath+"/"+url;}itm.url=url;this.it[itm.ind=this.it.length]=itm;return itm;}
function awmaiwi (st0,st1,st2,in0,in1,in2,tt,ii0,ii1,ii2,ia0,ia1,ia2,hsi0,hsi1,hsi2,sbt,jc0,jc1,jc2,url,tf,minWidth,minHeight){var itm=this.addItem (st0,st1,st2,in0,in1,in2,tt,sbt,jc0,jc1,jc2,url,tf,minWidth,minHeight);itm.ii=[ii0,ii1,ii2];itm.ia=[ia0,ia1,ia2];itm.hsi=[hsi0,hsi1,hsi2];this.siw=Math.max(this.siw,Math.max(((hsi0!=n)?awmImagesColl[hsi0*3+1]:0),Math.max(((hsi1!=n)?awmImagesColl[hsi1*3+1]:0),((hsi2!=n)?awmImagesColl[hsi2*3+1]:0))));return itm;}
function awmmght(cnt){for (var cno=0; cno<this.cn.length; cno++)this.cn[cno].ght();}
function awmcght(){var is="",hct="";if (this.pm.fl || this.pi!=null) hct+="left:-3000px;top:-3000px;"; if (isGecko1>0) hct+="-moz-opacity:"+(this.opacity/100)+";";if (hct!="") hct=" style='"+hct+"'";this.htx="<div id='"+this.id+"' class='"+this.cs.id+"'"+hct+" onMouseOver='this.prc.onmouseover();' onMouseOut='this.prc.onmouseout();'>";if (this.ht){var es="";var tst=this.ts;this.htx+="<table id='"+this.tid+"_0' title='"+this.ttt+"' class='"+this.ts.id+"' border='0' cellpadding='0' cellspacing='0'"+es+"><tr><td class='"+this.ts.id2+"' valign=middle style='padding:"+tst.pd+"px; "+((tst.fnt!=n)?"font:"+tst.fnt+"; ":"")+((tst.tdec!=n)?"text-decoration:"+tst.tdec+"; ":"")+((tst.fgc!=n)?"color:"+tst.fgc+";":"")+"'>"+awmatai(this.tn,this.ti,this.tia)+"</td></table>";}for (p=0; p<this.it.length; p++){this.htx+=this.it[p].ght();if (p<this.it.length-1) this.htx+=is;}this.htx+="<span style='font-size:0'>&nbsp</span></div>";return this.htx;}
function awmight(){var htx="";for (var q=0; q<this.pm.st; q++){var ist=this.style[q]; htx+="<table id='"+this.id+"_"+q+"' title='"+this.tt+"' class='"+this.style[q].id+"' style='left:-3000' width='100%' border='0' cellpadding='0' cellspacing='0'><tr><td class='"+this.style[q].id2+"' valign='middle' style='padding:"+ist.pd+"px;"+((this.ps.siw>0)?"padding-right:0px;":"")+((ist.fnt!=n)?"font:"+ist.fnt+"; ":"")+((ist.tdec!=n)?"text-decoration:"+ist.tdec+"; ":"")+((ist.fgc!=n)?"color:"+ist.fgc+";":"")+"'>"+awmatai(this.inm[q],this.ii[q],this.ia[q])+"</td>";if (this.ps.siw>0){htx+="<td class='"+this.style[q].id2+"' style='padding:"+ist.pd+"px; padding-left:0px;' width='"+this.ps.siw+"'>";if (this.hsi[q]!=n) htx+=awmiht(this.hsi[q]);else  htx+="<span style='font-size:0;'>&nbsp;</span>";htx+="</td>";}htx+="</tr></table>";}htx+="<img id='"+this.id+"_4' title='"+this.tt+"' style='position:absolute; cursor:"+awmctlt[this.style[0].crs]+"; z-index:"+awmzindex+";' src='"+awmMenuPath+awmLibraryPath+"/dot.gif' onMouseOver='this.pi.onmouseover();' onMouseOut='this.pi.onmouseout();' onMouseDown='this.pi.onmousedown();' alt=''>";return htx;}
function awmmwhttd(){var s="",crc;document.write(this.sht);for (var i=0; i<this.cn.length; i++) document.write(this.cn[i].htx);}
function awmcfe(){if (this.ft) return;this.layer=document.getElementById(this.id);this.layer.prc=this;if (this.ht){this.tl=this.layer.childNodes[0];this.tl.prc=this;if (this.pm.mvb && this.pi==null){this.tl.onmousedown=awmotmd;this.tl.onmousemove=awmotmm;this.tl.onmouseup=awmotmu;}}var var1=(this.ht)?1:0;for (var p=0; p<this.it.length; p++){this.it[p].elr=this.layer.childNodes[(this.pm.st+1)*(p+1)+var1-1];this.it[p].elr.pi=this.it[p];this.it[p].elr.onmouseup=awmoimu;for (var q=0; q<this.pm.st; q++){this.it[p].layer[q]=this.layer.childNodes[p*(this.pm.st+1)+q+var1];this.it[p].layer[q].pi=this.it[p];}}this.ft=1;}
function awmca(){if (this.argd) return;var w, h, tw, th, iw, ih, mwt=0, mht=0, nl=0, nt=0;var wts=new Array(), hts=new Array();if (this.ht){tw=mwt=this.tl.offsetWidth;th=mht=this.tl.offsetHeight;}for (var p=0; p<this.it.length; p++){iw=this.it[p].minWidth+((this.it[p].style[0].bs=="none")?0:2*this.it[p].style[0].bw);ih=this.it[p].minHeight+((this.it[p].style[0].bs=="none")?0:2*this.it[p].style[0].bw);for (var q=this.pm.st-1; q>=0; q--){iw=Math.max(iw,this.it[p].layer[q].offsetWidth);ih=Math.max(ih,this.it[p].layer[q].offsetHeight);mwt=Math.max(iw,mwt);mht=Math.max(ih,mht);}wts[p]=iw;hts[p]=ih;}if (this.ht){w=(this.ew)?mwt:tw;h=(this.eh)?mht:th;this.tl.setAttribute("style","left:0px; top:0px; width:"+w+"px; height:"+h+"px;");if (this.ct==0) nt+=h+this.dbi; else  nl+=w+this.dbi;}for (var p=0; p<this.it.length; p++){w=(this.ew)?mwt:wts[p];h=(this.eh)?mht:hts[p];for (var q=0; q<this.pm.st; q++)this.it[p].layer[q].setAttribute("style",((q>0)?"visibility:hidden; ":"")+"left:"+(this.it[p].left=nl)+"px; top:"+(this.it[p].top=nt)+"px; width:"+(this.it[p].width=w)+"px; height:"+(this.it[p].height=h)+"px;");var els=this.it[p].elr.style;els.left=nl+"px";els.top=nt+"px";els.width=w+"px";els.height=h+"px";if (this.ct==0) nt+=h+this.dbi; else  nl+=w+this.dbi;}if (this.ct==0){this.layer.style.width=mwt+"px";this.layer.style.height=(nt-this.dbi)+"px";} else  {this.layer.style.width=(nl-this.dbi)+"px";this.layer.style.height=mht+"px";}if (this.ct==2) this.layer.style.width=(window.innerWidth-2*this.cs.bw)+"px";this.argd=1;}
function awmcs(sf,x,y){if (sf){this.cd=0;this.fe();this.arr();if (arguments.length==1) this.pc();else  {this.left=x;this.layer.style.left=x+"px";this.top=y;this.layer.style.top=y+"px";}this.layer.style.visibility="visible";if (this.shw>0 && !awmun) this.unf();if (this.jcoo!=null) eval("setTimeout(\""+this.jcoo+"\",10);");if (this.ind==0) if (this.pm.selectedItem>0) this.it[this.pm.selectedItem-1].shst(2);} else  {if (!this.ft || this.mio || this.cd) return;this.layer.style.left="-3000px";this.layer.style.top="-3000px";clearInterval (this.uid);awmun=0;if (this.pi!=null) if (this.pm.selectedItem<1){this.pi.shst(0);}else  {if (this.pi.ind==this.pm.selectedItem-1 && this.pi.ps.ind==0){this.pi.shst(2);} else  {this.pi.shst(0);}}if (this.jcoc!=null && ! this.cd) eval("setTimeout(\""+this.jcoc+"\",10);");this.cd=1;}}
function awmchdt(flg){var p;for (p=0; p<this.it.length; p++){if (this.it[p].sm!=n) this.it[p].sm.hdt(0);}if (arguments.length==1 && !this.cd) this.show(0);}
function awmmcm(flg){if (this.mio && !flg) return;for (var cno=(this.cll && awmctm==null)?0:1; cno<this.cn.length; cno++){if (flg){this.cn[cno].mio=0;}this.cn[cno].show(0);}if (awmSubmenusFrame!=""){for (p=0; p<this.cn[0].it.length; p++){if (this.cn[0].it[p].sm!=n) this.cn[0].it[p].sm.pm.cm(flg);}}}
function awmodmd(){for (mno=0; mno<awmm.length; mno++){awmm[mno].cm(0);}}
function awmocmo(){this.mio=1;this.pm.mio=1;if (this.pi!=null) this.pi.shst((this.swn==0)?1:2);if (this.ind>0) clearTimeout(this.pi.ps.hsid);clearTimeout(this.hsid);}
function awmocmot(){this.mio=0;this.pm.mio=0;if (!this.pm.ss){var nth=setTimeout("awmm["+this.pm.ind+"].cm(0);",awmhd);if (awmSubmenusFrame=="") this.hsid=setTimeout("awmm["+this.pm.ind+"].cn["+this.ind+"].hdt("+((this.ind==0)?"":"0")+");",awmhd);}}
function awmiss(sts){if (sts==2 && this.pm.st==2) sts=1;for (q=0; q<this.pm.st; q++){this.layer[q].style.visibility=(q==sts)?"visible":"hidden";}}
function awmoimo(){this.shst(1);if (this.ii[1]!=null){this.layer[1].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].src=this.layer[1].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].src;}if (awmctm!=null) return;if (awmSubmenusFrame!=""){eval ("var frex=window.top."+awmSubmenusFrame);if (frex){eval("this.sm=window.top."+awmSubmenusFrame+".awm"+this.pm.nm+"_sub_"+(this.ind+1));if (this.sm){this.sm.pi=this;this.sm.pm.ss=this.pm.ss;} else  this.sm=null;}}this.ps.mio=1;this.pm.mio=1;this.ps.hdt();window.status=this.sbt;if (this.sm!=n) if (!this.sm.swn){clearTimeout(this.sm.hsid);this.sm.show(1);}if (this.jc[1]!=null) eval("setTimeout(\""+this.jc[1]+"\",10);");}
function awmoimot(){if (this.sm==null || (this.sm!=null && this.sm.cd)){if (this.pm.selectedItem<1){this.shst(0);}else  {if (this.ps.ind==0 && this.ind==this.pm.selectedItem-1){this.shst(2);} else  {this.shst(0);}}}if (!this.pm.ss){if (this.sm!=n && awmSubmenusFrame=="") this.sm.hsid=setTimeout("awmm["+this.pm.ind+"].cn["+this.sm.ind+"].hdt(0);",awmhd);}window.status=awmDefaultStatusbarText;if (this.jc[0]!=null) eval("setTimeout(\""+this.jc[0]+"\",10);");}
function awmoimd(){this.shst(2);if (this.sm!=n) if (this.sm.swn){clearTimeout(this.sm.hsid);this.sm.show(1);}if (this.jc[2]!=null) eval("setTimeout(\""+this.jc[2]+"\",10);");if (this.url!=null){this.awmoimot;if (this.tf==null) setTimeout("eval(window.location='"+this.url+"')",100);else  if (this.tf=="new") setTimeout("window.open('"+this.url+"');",50);else  if (this.tf=="top") window.top.location=this.url;else  eval("window.top."+this.tf+".location=this.url");}}
function awmoimu(){this.pi.shst(1);}
function awmotmd(e){this.prc.pm.mio=0;awmctm=this.prc;this.prc.pm.cm(0);this.prc.pm.mio=1;awmmox=e.clientX-awmctm.layer.offsetLeft;awmmoy=e.clientY-awmctm.layer.offsetTop;awmml=awmctm.layer.offsetLeft-awmctm.layer.style.left;awmmt=awmctm.layer.offsetTop-awmctm.layer.style.top;}
function awmotmm(e){if (awmctm!=null){awmctm.pm.rep=1;awmctm.left=e.clientX-awmmox;awmctm.layer.style.left=awmctm.left+"px";awmctm.top=e.clientY-awmmoy;awmctm.layer.style.top=awmctm.top+"px";}}
function awmotmu(e){if (awmctm!=null){awmctm.pm.rep=1;awmctm=null;}}
function awmpc(flg){this.fe();this.arr();var me=this.pm;if (this.pi==null){var tmpEl=document.getElementById("awmAnchor-"+this.pm.nm);var x=this.pm.offX,y=this.pm.offY;if (tmpEl){x+=tmpEl.offsetLeft;y+=tmpEl.offsetTop;if (me.rc==4){x-=this.layer.offsetWidth/2}if (me.rc==1 || me.rc==2){x-=this.layer.offsetWidth}if (me.rc==2 || me.rc==3){y-=this.layer.offsetHeight}} else  {var crn=me.crn;x+=(crn==0 || crn==4 || crn==3)?(me.dx):((crn==1 || crn==6 || crn==2)?vr-vl-this.layer.offsetWidth-me.dx:(vr-vl-this.layer.offsetWidth)/2);y+=(crn==0 || crn==5 || crn==1)?(me.dy):((crn==3 || crn==7 || crn==2)?vb-vt-this.layer.offsetHeight-me.dy:(vb-vt-this.layer.offsetHeight)/2);}if ((this.left!=x+awmlssx || this.top!=y+awmlssy) && !this.pm.rep){x+=(this.pm.dft==1 || this.pm.dft==3 || this.pm.dft==4 || this.pm.dft==6)?vl:0;y+=(this.pm.dft==1 || this.pm.dft==2 || this.pm.dft==4 || this.pm.dft==5)?vt:0;this.left=x;this.layer.style.left=x+"px";this.top=y;this.layer.style.top=y+"px";if (vb-this.top<21){this.top-=21-(vb-this.top);this.layer.style.top=this.top+"px";}}} else  {if(!this.pi.ps) return;if(flg) return;var psl=this.pi.ps.layer;var pil=this.pi.layer[0];var parentBorder=(is60)?this.pi.ps.cs.bw:0;this.lod=this.od;if (this.lod==0){if (this.pi.ps.ct==0)this.lod=((psl.offsetLeft+psl.offsetWidth+this.swr+this.layer.offsetWidth>vr) && (psl.offsetLeft-this.swr-this.layer.offsetWidth>vl))?2:1;else this.lod=((psl.offsetTop+psl.offsetHeight+this.swr+this.layer.offsetHeight>vb) && (psl.offsetTop-this.swr-this.layer.offsetHeight>vl))?2:1;}if (this.pi.ps.ct==0){this.left=(this.lod==1)?((this.pm.submenusFrameOffset>-9000 && this.ind==0)?vl:psl.offsetLeft+psl.offsetWidth)+this.swr-parentBorder:psl.offsetLeft-this.layer.offsetWidth-this.swr-parentBorder;if (this.pm.submenusFrameOffset>-9000 && this.ind==0 && awmRightToLeftFrame==1){this.left=window.innerWidth-this.layer.offsetWidth-this.swr-parentBorder;}this.layer.style.left=this.left+"px";this.top=((this.sa==0)?((is60)?0:psl.offsetTop+this.pi.ps.cs.bw)+pil.offsetTop:((this.sa==1)?psl.offsetTop-parentBorder:((this.sa==2)?psl.offsetTop+psl.offsetHeight-this.layer.offsetHeight-parentBorder:psl.offsetTop-parentBorder+(psl.offsetHeight-this.layer.offsetHeight)/2)));this.top+=((this.pm.submenusFrameOffset>-9000 && this.ind==0)?this.pm.submenusFrameOffset-this.pi.ps.doy+vt:0);this.layer.style.top=this.top+"px";if (this.top+this.layer.offsetHeight>vb) this.layer.style.top=this.top=vb-this.layer.offsetHeight;} else {this.left=(this.sa==0)?((is60)?0:psl.offsetLeft+this.pi.ps.cs.bw)+pil.offsetLeft:((this.sa==1)?psl.offsetLeft-parentBorder:((this.sa==2)?psl.offsetLeft+psl.offsetWidth-this.layer.offsetWidth-parentBorder:psl.offsetLeft-parentBorder+(psl.offsetWidth-this.layer.offsetWidth)/2));this.left+=((this.pm.submenusFrameOffset>-9000 && this.ind==0)?this.pm.submenusFrameOffset-this.pi.ps.dox+vl:0);this.layer.style.left=this.left+"px";if (this.left+this.layer.offsetWidth>vr) this.layer.style.left=this.left=vr-this.layer.offsetWidth;this.top=(this.lod==1)?((this.pm.submenusFrameOffset>-9000 && this.ind==0)?vt:psl.offsetTop+psl.offsetHeight)+this.swr-parentBorder:psl.offsetTop-this.layer.offsetHeight-this.swr-parentBorder;this.layer.style.top=this.top+"px";}}}
function awmu(){if (awmuc>10 || awmctu.shw==2){awmctu.layer.style.visibility="hidden";awmctu.layer.style.visibility="visible";}if (awmuc>10){clearInterval (awmctu.uid);awmun=0;return;}var layer=awmctu.layer;switch (awmud){case 1: if (awmctu.shw==1){layer.style.left=(awmctu.left-layer.offsetWidth*(10-awmuc)/10)+"px";layer.style.clip="rect(0px,"+layer.offsetWidth+"px,"+layer.offsetHeight+"px,"+Math.round(layer.offsetWidth*(10-awmuc)/10)+"px)";} else  layer.style.clip="rect(0px,"+Math.round(layer.offsetWidth*awmuc/10)+"px,"+layer.offsetHeight+"px,0px)";break;case 2: if (awmctu.shw==1){layer.style.left=(awmctu.left+layer.offsetWidth*(10-awmuc)/10)+"px";layer.style.clip="rect(0px,"+Math.round(layer.offsetWidth*awmuc/10)+"px,"+layer.offsetHeight+"px,0px)";} else  layer.style.clip="rect(0px,"+layer.offsetWidth+"px,"+layer.offsetHeight+"px,"+layer.offsetWidth*(10-awmuc)/10+"px)";break;case 3: if (awmctu.shw==1){layer.style.top=(awmctu.top-layer.offsetHeight*(10-awmuc)/10)+"px";layer.style.clip="rect("+Math.round(layer.offsetHeight*(10-awmuc)/10)+"px,"+layer.offsetWidth+"px,"+layer.offsetHeight+"px,0px)";} else  layer.style.clip="rect(0px,"+layer.offsetWidth+"px,"+Math.round(layer.offsetHeight*awmuc/10)+"px,0px)";break;case 4: if (awmctu.shw==1){layer.style.top=(awmctu.top+layer.offsetHeight*(10-awmuc)/10)+"px";layer.style.clip="rect(0px,"+layer.offsetWidth+"px,"+Math.round(layer.offsetHeight*awmuc/10)+"px,0px)";} else  layer.style.clip="rect("+Math.round(layer.offsetHeight*(10-awmuc)/10)+"px,"+layer.offsetWidth+"px,"+layer.offsetHeight+"px,0px)";break;case 5: if (awmctu.shw==1){layer.style.left=(awmctu.left-layer.offsetWidth*(10-awmuc)/10)+"px";layer.style.top=(awmctu.top-layer.offsetHeight*(10-awmuc)/10)+"px";layer.style.clip="rect("+Math.round(layer.offsetHeight*(10-awmuc)/10)+"px,"+layer.offsetWidth+"px,"+layer.offsetHeight+"px,"+Math.round(layer.offsetWidth*(10-awmuc)/10)+"px)";} else  layer.style.clip="rect(0px,"+Math.round(layer.offsetWidth*awmuc/10)+"px,"+Math.round(layer.offsetHeight*awmuc/10)+"px,0px)";break;case 6: if (awmctu.shw==1){layer.style.left=(awmctu.left-layer.offsetWidth*(10-awmuc)/10)+"px";layer.style.top=(awmctu.top+layer.offsetHeight*(10-awmuc)/10)+"px";layer.style.clip="rect(0px,"+layer.offsetWidth+"px,"+Math.round(layer.offsetHeight*awmuc/10)+"px,"+Math.round(layer.offsetWidth*(10-awmuc)/10)+"px)";} else  layer.style.clip="rect("+Math.round(layer.offsetHeight*(10-awmuc)/10)+"px,"+Math.round(layer.offsetWidth*awmuc/10)+"px,"+layer.offsetHeight+"px,0px)";break;case 7: if (awmctu.shw==1){layer.style.left=(awmctu.left+layer.offsetWidth*(10-awmuc)/10)+"px";layer.style.top=(awmctu.top-layer.offsetHeight*(10-awmuc)/10)+"px";layer.style.clip="rect("+Math.round(layer.offsetHeight*(10-awmuc)/10)+"px,"+Math.round(layer.offsetWidth*awmuc/10)+"px,"+layer.offsetHeight+"px,"+layer.offsetWidth*(10-awmuc)/10+"px)";} else  layer.style.clip="rect(0px,"+layer.offsetWidth+"px,"+Math.round(layer.offsetHeight*awmuc/10)+"px,"+layer.offsetWidth*(10-awmuc)/10+"px)";break;case 8: if (awmctu.shw==1){layer.style.left=(awmctu.left+layer.offsetWidth*(10-awmuc)/10)+"px";layer.style.top=(awmctu.top+layer.offsetHeight*(10-awmuc)/10)+"px";layer.style.clip="rect(0px,"+Math.round(layer.offsetWidth*awmuc/10)+"px,"+Math.round(layer.offsetHeight*awmuc/10)+"px,0px)";} else  layer.style.clip="rect("+Math.round(layer.offsetHeight*(10-awmuc)/10)+"px,"+layer.offsetWidth+"px,"+layer.offsetHeight+"px,"+layer.offsetWidth*(10-awmuc)/10+"px)";break;}awmuc+=2;}
function awmcu(){clearInterval(this.uid);this.layer.style.clip='rect(0,0,0,0)';this.layer.style.visibility="visible";awmun=1;awmuc=0;awmud=(this.ud!=0)?this.ud:(this.lod+((this.pi.ps.ct==0)?0:2));awmctu=this;this.uid=setInterval("awmu()",50);}
function awmwr(){if (!(awmSubmenusFrameOffset>-9000)){for (var mno=0; mno<awmm.length; mno++){if (awmm[mno].cn[0].ct==2) awmm[mno].cn[0].layer.style.width=(window.innerWidth-2*awmm[mno].cn[0].cs.bw);if (!awmm[mno].rep && !awmm[mno].cll) awmm[mno].cn[0].pc();awmm[mno].cm(0);if (awmm[mno].cll && !awmm[mno].cd) awmm[mno].cn[0].hdt(0);}}}
function awmwu(){if (awmUnloadFunction!=null) awmUnloadFunction ();if (awmSubmenusFrameOffset>-9000){for (var mno=0; mno<awmm.length; mno++){if (awmm[mno].cn[0].pi!=null){awmm[mno].cn[0].pi.shst(0);awmm[mno].cn[0].pi.sm=null;}}}}
function awmwl(){awmwbl();for (var mno=0; mno<awmm.length; mno++){if (!awmm[mno].cll) awmm[mno].cn[0].pc();}}
function awmwbl(){}
function awmd(){var clientX=window.innerWidth;var clientY=window.innerHeight;var sx=10;var sy=10;var divider=5;var snx,sny;if (vl!=awmlsx ||vt!=awmlsy){for (var mno=0; mno<awmm.length; mno++){var crm=awmm[mno];crm.mio=0;crm.cm(0);if (crm.dft==1 || crm.dft==3){crm.cn[0].left=parseInt(crm.cn[0].layer.style.left)+vl-awmlsx;crm.cn[0].layer.style.left=crm.cn[0].left+"px";if (awmSubmenusFrame!='' && crm.cn[0].ct>0) crm.cn[0].dox=vl;}if (crm.dft==1 || crm.dft==2){crm.cn[0].top=parseInt(crm.cn[0].layer.style.top)+vt-awmlsy;crm.cn[0].layer.style.top=crm.cn[0].top+"px";if (awmSubmenusFrame!='' && crm.cn[0].ct==0) crm.cn[0].doy=vt;}}awmlsx=vl;awmlsy=vt;}if (vl!=awmlssx || vt!=awmlssy){for (var mno=0; mno<awmm.length; mno++){var crm=awmm[mno];if (crm.cn[0].ft){if ((crm.dft==4 || crm.dft==6) && vl!=awmlssx){crm.mio=0;crm.cm(0);snx=Math.abs(vl-awmlssx)/(vl-awmlssx);if((Math.round(Math.abs(vl-awmlssx)/divider))>=sx) sx=Math.round(Math.abs(vl-awmlssx)/divider);if (Math.abs(vl-awmlssx)<sx) sx=Math.abs(vl-awmlssx);crm.cn[0].left=parseInt(crm.cn[0].layer.style.left)+snx*sx;crm.cn[0].layer.style.left=crm.cn[0].left+"px";if (awmSubmenusFrame!='' && crm.cn[0].ct>0) crm.cn[0].dox=vl;}if ((crm.dft==4 || crm.dft==5) && vt!=awmlssy){crm.mio=0;crm.cm(0);sny=Math.abs(vt-awmlssy)/(vt-awmlssy);if((Math.round(Math.abs(vt-awmlssy)/divider))>=sy) sy=Math.round(Math.abs(vt-awmlssy)/divider);if (Math.abs(vt-awmlssy)<sy) sy=Math.abs(vt-awmlssy);crm.cn[0].top=parseInt(crm.cn[0].layer.style.top)+sny*sy;crm.cn[0].layer.style.top=crm.cn[0].top+"px";if (awmSubmenusFrame!='' && crm.cn[0].ct==0) crm.cn[0].doy=vt;}}}if (vl!=awmlssx && crm.dft>3) awmlssx+=snx*sx;if (vt!=awmlssy && crm.dft>3) awmlssy+=sny*sy;}for (var mno=0; mno<awmm.length; mno++) awmm[mno].cn[0].pc(1);}
function awmCoordinates(){vl=window.scrollX;vt=window.scrollY;vr=vl+window.innerWidth;vb=vt+window.innerHeight;}
function awmdb(mi){var crc=awmm[mi].cn[0];if (document.getElementById(crc.id).offsetWidth>0 || !is60){if (!awmm[mi].cll){if (!awmm[mi].elemRel || document.getElementById("awmAnchor-"+awmm[mi].nm)) crc.show(1);else  setTimeout("awmdb("+mi+")",10);}} else  setTimeout("awmdb("+mi+")",0);}
function awmbmm(){if (typeof(awmTarget)!='undefined' && this.ind>0) return;document.onmousedown=awmodmd;window.status="."+(this.ind+1);this.ght();this.whtd();clearInterval(awmCoordId);awmCoordId=setInterval("awmCoordinates()",50);awmdb(this.ind);window.status=awmDefaultStatusbarText;clearInterval(awmdid);awmdid=setInterval("awmd()",150);awmsoo=awmso+1;if (this.ind==0){if (typeof(window.onload)!='undefined'){awmwbl=window.onload;awmwblt=window.onload;}else  awmwblt=awmwbl;window.onload=awmwl;awmUnloadFunction=window.onunload;window.onunload=awmwu;}else  awmwbl=awmwblt;}
function awmHideMenu(menuName){var ml=awmm;if (ml){var i=0;while (i<ml.length){if (ml[i].nm==menuName || menuName==null){ml[i].cm(1);ml[i].cn[0].show(0);}i++;}ml=null;}}
function awmShowMenu (menuName,x,y,frame){var ml;if (arguments.length<4 || frame==null) ml=awmm;else  {eval ("var frex=window.top."+awmSubmenusFrame);if (!frex) return;eval("ml=window.top."+frame+".awmm;");}if (ml){var i=0;while (ml[i].nm!=menuName && i<ml.length-1) i++;if (ml[i].nm==menuName){ml[i].cn[0].top=-3000;ml[i].cn[0].left=-3000;if (arguments.length<3 || x==null || y==null) ml[i].cn[0].show(1);else  {ml[i].cn[0].pm.rep=1;ml[i].cn[0].show(1,x,y);}}ml=null;}}

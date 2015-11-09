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

// Title: COOLjsTree
// Version: 1.4.0.
// URL: http://javascript.cooldev.com/scripts/cooltree/
// Author: Sergey Nosenko <jsinfo@cooldev.com>
// Modified by Alex Kyba 18/02/2004
var TREE_NODES_EXAMPLE = 
	[
		['Node 1', null, null,
			['Sub Item 1', null, null],
			['Level 2', null, null,
				['Sub Item 2', null, null],
				['Sub Item 3', null, null],
				['Sub Item 4', null, null],
			],
		],
		['Node 2', null, null,
			['Level 2 Node 1', null, null,
				['Sub Item 2', null, null],
			],
		['Node 3', null, null]	
		]
	]	
; 
	
	
var TREE1_FORMAT =
[
//0. left position
	10,
//1. top position
	10,
//2. show +/- buttons
	true,
//3. couple of button images (collapsed/expanded/blank)
	["../_images/c.gif", "../_images/e.gif", "../_images/b.gif"],
//4. size of images (width, height,ident for nodes w/o children)
	[16,16,16],
//5. show folder image
	false,
//6. folder images (closed/opened/document)
	[],
//7. size of images (width, height)
	[16,16],
//8. identation for each level [0/*first level*/, 16/*second*/, 32/*third*/,...]
	[0,16,32,48,64,80,96,112,128,144,160,176,192,208,224,240,256,272],
//9. tree background color ("" - transparent)
	"",
//10. default style for all nodes
	"clsNode",
//11. styles for each level of menu (default style will be used for undefined levels)
	[],
//12. true if only one branch can be opened at same time
	false,
//13. item pagging and spacing
	[0,0],
];

window.NTrees=[];

function pldImg(arg){
	for(var i in arg)
	{
		var im=new Image();
		im.src=arg[i];
	}
}

function CTreeFormat(fmt, tree){
	this.init=function(fmt, tree)
	{
		this.left=fmt[0];
		this.top=fmt[1];
		this.showB=fmt[2];
		this.clB=fmt[3][0];
		this.exB=fmt[3][1];
		this.iE=fmt[3][2];
		this.Bw=fmt[4][0];
		this.Bh=fmt[4][1];
		this.Ew=fmt[4][2];
		this.showF=fmt[5];
		this.clF=fmt[6][0];
		this.exF=fmt[6][1];
		this.iF=fmt[6][2];
		this.Fw=fmt[7][0];
		this.Fh=fmt[7][1];
		this.ident=fmt[8];
		this.nst=fmt[10];
		this.nstl=fmt[11];
		this.so=fmt[12];
		this.pg=fmt[13][0];
		this.sp=fmt[13][1];
		if (this.showB) pldImg([this.clB,this.exB,this.iE]);
		if (this.showF) pldImg([this.exF,this.clF,this.iF]);
	}
	this.nstyle=function(lvl){
		return (und(this.nstl[lvl]))? this.nst : this.nstl[lvl];
	}
	this.idn=function(lvl){
					var r=(und(this.ident[lvl])) ? this.ident[0]*lvl : this.ident[lvl];
					return r;
				}
	this.init(fmt, tree);
}
function COOLjsTree(name, nodes, format, obj){
	this.name=name;
	this.fmt=new CTreeFormat(format, this);
	if (und(window.NTrees)) 
		window.NTrees=[];
	window.NTrees[this.name]=this;
	this.Nodes=[];
	this.rootNode=new CTreeNode(null, "", "", "", null);
	this.rootNode.treeView=this;
	this.selectedNode=null;
	this.maxWidth=0;
	this.maxHeight=0;
	this.ondraw=null;	
	this.parentObj = obj; 
	this.nodesUrl=null;
	this.selectedNode=null;
	this.selectedID = null;
	this.lastSearchIndex=0;
	this.loadNodes=function(target){
		
	}
	this.nbn=function(nm){
				for (var i=0;i<this.Nodes.length;i++) 
					if (this.Nodes[i].text == nm) 
						return this.Nodes[i];
					return null;
				};
	this.nodeByName=this.nbn;
	this.nodeByID=function(id){
					for (var i=0;i<this.Nodes.length;i++) 
							if (this.Nodes[i].nodeID==id) 
								return this.Nodes[i];
							return null;
					}
	this.nodeByURL=function(u){
						for(var i=0;i<this.Nodes.length;i++) 
							if (this.Nodes[i].url==u) 
								return this.Nodes[i];
							return null;
						};
	this.addNode=function(node){
					var parentNode=node.parentNode;
					this.Nodes[this.Nodes.length]=node;
					node.index=this.Nodes.length-1;
					if (parentNode == null) 
						this.rootNode.children[this.rootNode.children.length]=node;
					else 
						parentNode.children[parentNode.children.length]=node;
					return node;
				}
	this.rebuildTree=function(){
						this.parentObj.innerHTML="";
						for (var i=0;i < this.Nodes.length;i++){ 
							str = this.Nodes[i].init();
							this.parentObj.insertAdjacentHTML("BeforeEnd", str);
						}	
							
			     	   	for (var i=0;i < this.Nodes.length;i++){
							var node=this.Nodes[i];
							node.el=document.getElementById(node.id()+"d");		
						}
						
					}
	this.getImgEl=function(node){
				if (this.fmt.showB&&!node.nb)
					node.nb= document.getElementById(node.id()+"nb");
				if (this.fmt.showF&&!node.nf)node.nf=
					document.getElementById(node.id()+"nf");
				}
	this.draw=function(){
		this.currTop=this.fmt.top;
		this.maxHeight =0;this.maxWidth=0;
		for (var i=0;i < this.rootNode.children.length;i++) this.rootNode.children[i].draw(true);
		if (this.ondraw!=null) this.ondraw();
	}
	this.updateImages=function(node, ff){
	
		this.getImgEl(node);
		var b = this.fmt[node.expanded? "exB" : "clB"];
		var f = this.fmt[node.hasChildren()?(node.expanded?"exF":"clF"):"iF"]; 
		if (node.treeView.fmt.showB && node.nb && node.nb.src!=b) node.nb.src=b;
		if (node.treeView.fmt.showF && node.nf && node.nf.src!=f) node.nf.src=f;
	}
	this.expandNode=function(index){
		var node=this.Nodes[index];
		var pNode=node.parentNode ? node.parentNode : null;
		if (!und(node) && node.hasChildren()){
			node.expanded=!node.expanded;
			this.updateImages(node);
			if (!node.expanded)
				node.hideChildren();
			else 
				if (this.fmt.so)
					for (var i=0;i < this.Nodes.length;i++){
						this.Nodes[i].show(false);
						if(this.Nodes[i] != node && this.Nodes[i].parentNode == pNode) {
							this.Nodes[i].expanded=false;
							this.updateImages(this.Nodes[i]);
						}
					}
            this.draw();
		}
	}
	this.selectNode=function(index){
		var node=this.Nodes[index];
		if(!und(node)) this.selectedNode=node;
		node.draw();
	}
	this.readNodes=function(nodes){
		var ind=0;var par=null;
		function readOne(arr , tree){
			if (und(arr)) return;
			var i=0;var nodeID=0;
			if (arr[0]&&arr[0].id) {nodeID=arr[0].id;i++};
			var node=tree.addNode(new CTreeNode(tree, par, arr[i], url=arr[i+1] == null? "": arr[i+1], arr[i+2] == null? "": arr[i+2]));
			node.nodeID=nodeID;
			while (!und(arr[i+3])){
				par=node;
				readOne(arr[i+3], tree);
				i++;
			}
		}
		if (und(nodes) || und(nodes[0]) || und(nodes[0][0])) return;
		for (var i=0;i<nodes.length;i++){
			par=null;readOne(nodes[i], this);
		}
	}
	this.collapseAll=function(rd){
		for (var i=0;i < this.Nodes.length;i++){
			if (this.Nodes[i].parentNode != this.rootNode) this.Nodes[i].show(false);
			this.Nodes[i].expanded=false;
			this.updateImages(this.Nodes[i]);
		}
		if (rd) this.draw();
	}
	this.expandAll=function(rd){
		for (var i=0;i < this.Nodes.length;i++){
			this.Nodes[i].expanded=true;
			this.updateImages(this.Nodes[i]);
		}
		if (rd) this.draw();
	}
	this.init=function(){
		this.readNodes(nodes);
		this.rebuildTree();
		this.draw();
	}
	//-------- Search in Node ----------
	this.search = function(str){
		var i;
		if (this.lastSearchIndex==this.Nodes.length-1)
			si=0;			
		else
			si=this.lastSearchIndex+1;
				
		for (i=si;i<this.Nodes.length;i++){ 
			txtSearch = this.Nodes[i].text.toUpperCase();
			strSearch = str.toUpperCase(); 
			if (txtSearch.indexOf(strSearch)!=-1){ 
				document.all["node"+this.lastSearchIndex].className="node";
				this.lastSearchIndex=i;
				node = this.Nodes[i];
				tree.selectedNode = node;
				document.all["node"+i].className="selectedNode";		
				node.expandParents();
				return ;
			}
		}	
		return alert(arraylng["MSG_0115"]);
	};
	//---------------------------------
	this.init();
	return this;
}

function CTreeNode(treeView, parentNode , text, url, target){
	this.index=-1;
	this.treeView=treeView;
	this.parentNode=parentNode;
	this.text=text;this.url=url;this.target=target;this.expanded=false;
	this.children=[];
	
	this.level=function(){
		var node=this;var i=0;
		while (node.parentNode != null){i++;node=node.parentNode;}
		return i;
	}
	this.hasChildren=function(){return this.children.length > 0;}
	this.init=function(){
		return '<div id="'+this.id()+'d" style="position:;display:none; visibility:;z-index:'+this.index+10+';">'+this.getContent()+'</div>';
	}
	this.getH=function(){
		this.css=this.el.style;
		this.doc=document;
		this.h=this.el.offsetHeight||this.css.clip.height||this.doc.height||this.css.pixelHeight;
		return this.h;
	}
	
	this.getH1=function(){
					if(!this.h)
						this.h=this.el.firstChild.offsetHeight;
					return this.h
				}
    this.getW=function(){
					if(!this.w)
						this.w= this.el.firstChild.offsetWidth;
					return this.w
					}
	this.id=function(){return 'nt'+this.treeView.name+this.index;}
	this.getContent=function(){
		function itemSquare(node){
                var img=node.treeView.fmt[node.hasChildren()?(node.expanded?"exF":"clF"):"iF"]; 
				var w=node.treeView.fmt.Fw;
				var h=node.treeView.fmt.Fh;
				var img = "<img id=\""+node.id()+"nf\" name=\""+node.id()+"nf\" src=\"" + img + "\" width="+w+" height="+h+" border=0>"
				img = node.hasChildren()?'<span onclick="CTExpand(\''+node.treeView.name+'\','+node.index+', false)">'+img+'</span>':img;
				return "<td valign=\"middle\" width=\""+w+"\">"+img+"</td>\n";
		}
		function buttonSquare(node){
            var img=node.treeView.fmt[node.expanded? "exB" : "clB"]; 
			var w=node.treeView.fmt.Bw;
			var h=node.treeView.fmt.Bh;
			return '<td valign=\"middle\" width="'+w+'"><span onclick="CTExpand(\''+node.treeView.name+'\','+node.index+', false)"><img name=\''+node.id()+'nb\' id=\''+node.id()+'nb\' src="' + img + '" width="'+w+'" height="'+h+'" border=0></span></td>\n';
		}
		function blankSquare(node, ww){
			var img=node.treeView.fmt.iE;
			return "<td width=\""+ww+"\"><img src=\"" + img + "\" width="+ww+" height=1 border=0></td>\n";
		}

		var s='';
		var ll=this.level();
		s += '<table cellpadding='+this.treeView.fmt.pg+' cellspacing='+this.treeView.fmt.sp+' border=0 class="cls'+this.treeView.name+'_back'+ll+'"><tr>';
		var idn=this.treeView.fmt.idn(ll);
		if (idn > 0) s += blankSquare(this, idn);
		
		if(this.treeView.fmt.showB) s += this.hasChildren() ? buttonSquare(this) : blankSquare(this, this.treeView.fmt.Ew);
		
		if(this.treeView.fmt.showF) s += itemSquare(this);
		
		var n = this.treeView.name;
		if(this.url == ""){	
				
			s += this.hasChildren()? '<td nowrap=\"1\"><span id=\"node'+this.index+'\" class="'+this.treeView.fmt.nstyle(ll)+'" onclick="CTExpand(\''+n+'\','+this.index+', true)">'+this.text+'</span></td></tr></table>' : 
				'<td nowrap=\"1\"><span class="'+this.treeView.fmt.nstyle(ll)+'" onclick="">'+this.text+'</span></td></tr></table>';
		}
		else 
			s += '<td nowrap=\"1\"><span id=\"node'+this.index+'\" class="'+this.treeView.fmt.nstyle(ll)+'" onmouseover="OnMouseOver(this, \''+n+'\', '+this.index+')" onmouseout="OnMouseOut(this, \''+n+'\', '+this.index+')" ondblclick="'+this.target+'"  onclick="CTExpand(\''+n+'\','+this.index+', true);'+this.url+'">'+this.text+'</span></td></tr></table>';
        
		return s;
	}
	this.show=function(sh){
					if (this.visible == sh)
						return;
					this.visible=sh;
					var vis=sh ? 'inline': 'none';
					this.el.style.display=vis;
					
				}
	this.hideChildren=function(){
							this.show(false);
							for (var i=0;i < this.children.length;i++)
								this.children[i].hideChildren();
						}
	this.draw=function(){
					var ll=this.treeView.fmt.left;
					this.show(true);
					var w = this.getW();
					if (ll+ w> this.treeView.maxWidth)
						this.treeView.maxWidth=ll+w;
					this.treeView.currTop += this.getH();
					if (this.treeView.currTop > this.treeView.maxHeight)
						this.treeView.maxHeight=this.treeView.currTop;
					if (this.expanded && this.hasChildren())
						for (var i=0;i < this.children.length;i++)
							this.children[i].draw();
					}
	//------------Expand parent nodes of this node------------
	this.expandParents=function(){
		var cNode;
		cNode = this;
		while (cNode.parentNode){
			cNode = cNode.parentNode;
			if (!cNode.expanded){
				tree.expandNode(cNode.index);
			}
		}
	}
	//---------------------------------------------------------
}

function und(val){
		return typeof(val) == 'undefined';
}

//----- window.oldCTOnLoad=window.onload; -----
function OnMouseOver(obj, name, index){
	var tree = NTrees[name];
	var node=tree.Nodes[index];
	if (tree.selectedNode){
		if (node.index==tree.selectedNode.index){
			obj.className="overNode selected";
		}
		else{
			obj.className="overNode";
		}	
	}
	else{
		obj.className="overNode";		
	}	
}

function OnMouseOut(obj, name, index ){
	var tree = NTrees[name];
	var node=tree.Nodes[index];
	if (tree.selectedNode){
		if (node.index==tree.selectedNode.index){
			obj.className="selectedNode";
		}
		else
			obj.className="node";
	}
	else{
		obj.className="node";	
	}
}
function CTOnLoad(){
	if (typeof(window.oldCTOnLoad)=='function') window.oldCTOnLoad();
}
function CTExpand(name, index, isSelect){
	var tree = NTrees[name];
	var node=tree.Nodes[index];
	if (isSelect){
		if (tree.selectedNode) document.all["node"+tree.selectedNode.index].className="node";
		document.all["node"+index].className="overNode selected";
		tree.selectedNode = node;
	}	
	tree.expandNode(index);
}

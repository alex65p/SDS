<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" >
            <fo:layout-master-set>
                <fo:simple-page-master
				master-name="A4-vertical-notes"
				margin-top="2.0cm"
				margin-bottom="1.5cm"
				margin-left="1.5cm"
				margin-right="1.5cm"
				page-width="21.0cm"
				page-height="29.7cm">
                    <fo:region-body margin-bottom="2.5cm" margin-right="0.5cm" margin-left="0.5cm"/>
                    <fo:region-before extent="2cm" region-name="xsl-region-before-hor"/>
              
                    <fo:region-after extent="1.0cm" region-name="xsl-region-after-ver"></fo:region-after>
                    <fo:region-end extent="1.0cm" region-name="xsl-region-end-ver"></fo:region-end>
                </fo:simple-page-master>
                
                <fo:simple-page-master
				master-name="A4-vertical"
				margin-top="2.0cm"
				margin-bottom="1.5cm"
				margin-left="1.5cm"
				margin-right="1.5cm"
				page-width="21.0cm"
				page-height="29.7cm">
                    <fo:region-body margin-bottom="1.5cm" margin-right="0.5cm" margin-left="0.5cm"/>
                    <fo:region-before extent="2cm" region-name="xsl-region-before-hor"/>
              
                    <fo:region-after extent="1.0cm" region-name="xsl-region-after-ver"></fo:region-after>
                    <fo:region-end extent="1.0cm" region-name="xsl-region-end-ver"></fo:region-end>
                </fo:simple-page-master>
                
                <fo:simple-page-master
				master-name="A4-horizontal"
				margin-top="1.5cm"
				margin-bottom="1.5cm"
				margin-left="1.5cm"
				margin-right="1.5cm"
				page-width="29.7cm"
				page-height="21.0cm">
                    <fo:region-body display-align="before" margin-bottom="0cm" margin-right="1.0cm" margin-left="1.5cm" margin-top="0cm"/>
                    <fo:region-before extent="2cm" region-name="xsl-region-before-hor"/>
                   
                    <fo:region-after display-align="after" extent="1.0cm" reference-orientation="-90" region-name="xsl-region-after-hor"/>
                    <fo:region-start display-align="before" extent="1.0cm" reference-orientation="-90" region-name="xsl-region-start-hor"></fo:region-start>
                   
                    <fo:region-end display-align="before" extent="1.0cm" reference-orientation="-90" region-name="xsl-region-end-hor"></fo:region-end>
                     
                </fo:simple-page-master>
            </fo:layout-master-set>
		
			<!-- **************************************************************  DUVRI_01 **************************************************************  -->
            <fo:page-sequence master-reference="A4-vertical">
                
                <fo:static-content flow-name="xsl-region-after-ver" display-align="after" margin-right="15pt">
                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                        <fo:inline>S2S S.r.l Sistema della sicurezza</fo:inline>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block text-align="center" padding-before="40mm" padding-after="55mm">
                        <fo:external-graphic
                                           content-height="40%" >
                            <xsl:attribute name="src">url(
                                <xsl:value-of select="DUVRI/IMAGE" />)
                            </xsl:attribute>
    
                        </fo:external-graphic>
                       
                        
                       <!--   <xsl:template match="IMAGE">
                            <fo:external-graphic>
                              url('<xsl:value-of select="IMAGE" />')
                              
                            </fo:external-graphic>
                        </xsl:template>-->
                    </fo:block>
                    <fo:block padding="2pt" font-size="22pt" font-weight="bold" text-align="center">
										DOCUMENTO UNICO DI VALUTAZIONE DEI RISCHI DI INTERFERENZA
                        <fo:block font-size="10pt" font-weight="normal" margin-top="4pt">
											INFORMAZIONE, COOPERAZIONE E COORDINAMENTO (art. 26 comma 3 D.LGS. 81/08)
                        </fo:block>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            <fo:page-sequence master-reference="A4-vertical">
               
                <fo:static-content flow-name="xsl-region-after-ver" display-align="after" margin-right="15pt">
                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                        <fo:block text-align="center" padding-before="5mm" padding-after="4mm"/>
                   
                        <fo:inline>S2S S.r.l Sistema della sicurezza</fo:inline>
                    </fo:block>
                </fo:static-content>

                <fo:static-content flow-name="xsl-region-end-ver">
                    <fo:block font-family="sans-serif" font-size="8pt" text-align="right" margin-top="740pt">
						Pag.
                        <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                     
                <fo:flow flow-name="xsl-region-body">
                   
                    <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="22pt" font-style="normal" font-weight="bold" text-align="center">
                        <fo:table-column column-width="100%" />
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell padding="4pt">
                                    <fo:block padding="2pt">
										DOCUMENTO UNICO DI VALUTAZIONE DEI RISCHI DI INTERFERENZA
                                        <fo:block font-size="11pt" font-weight="normal" margin-top="4pt">
											INFORMAZIONE, COOPERAZIONE E COORDINAMENTO (art. 26 comma 3 D.LGS. 81/08)
                                          
               
                                        </fo:block>
                                    </fo:block>

                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block></fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
				
                    <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="9pt" font-style="italic" font-weight="normal" text-align="left" margin-top="10pt">
                        <fo:table-column column-width="60%" />
                        <fo:table-column column-width="40%" />
                        <fo:table-body>
                            <fo:table-row height="10pt">
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt" padding-top="8pt" padding-bottom="4pt">
                                    <fo:block>
                                        <fo:inline text-decoration="no-underline">D.U.V.R.I.  </fo:inline>
                                        <fo:inline text-decoration="no-underline"> NUMERO</fo:inline>
                                        <fo:inline text-decoration="no-underline"> :</fo:inline>
                                        <fo:inline text-decoration="no-underline" font-size="12pt" font-style="normal" padding-left="30pt" >
                                            <xsl:value-of select="DUVRI/DUVRI_01/DUVRI/PRO_DUV"/>
                                        </fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt" padding-top="8pt" padding-bottom="4pt">
                                    <fo:block>
                                        <fo:inline text-decoration="no-underline">DATA</fo:inline>
                                        <fo:inline text-decoration="no-underline"> :</fo:inline>
                                        <fo:inline text-decoration="no-underline" font-size="12pt" font-style="normal" padding-left="30pt">
                                            <xsl:text >.../.../......</xsl:text>
                                        </fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row height="10pt">
                                <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt" padding-top="8pt" padding-bottom="4pt">
                                    <fo:block >
                                        <fo:inline text-decoration="underline">SERVIZIO RESPONSABILE</fo:inline>
                                        <fo:inline text-decoration="no-underline"> :</fo:inline>
                                        <fo:inline text-decoration="no-underline" font-size="12pt" font-style="normal" font-weight="bold" padding-left="30pt">
                                            <xsl:value-of select="DUVRI/DUVRI_01/DUVRI/NOM_UNI_ORG"/>
                                        </fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
                        
                        <!-- COMMITTENTE -->
                    <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="8pt" font-style="italic" font-weight="normal" text-align="left" margin-top="10pt">
                        <fo:table-column column-width="0%" />
                        <fo:table-column column-width="32%" />
                        <fo:table-column column-width="36%" />
                        <fo:table-column column-width="32%" />
                        <fo:table-column column-width="0%" />
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell number-columns-spanned="5" border="solid 0.25pt #000000" font-weight="bold" padding="4pt">
                                    <fo:block>
                                        <fo:inline font-size="9pt" text-decoration="underline">COMMITTENTE</fo:inline>
                                        <fo:inline font-size="9pt" text-decoration="no-underline"> :</fo:inline>
                                        <fo:block>
                                            <fo:inline font-size="12pt" font-style="normal" padding-before="4pt">
                                                <xsl:value-of select="DUVRI/DUVRI_01/COMMITTENTE/RAG_SCL_AZL"/>
                                            </fo:inline>
                                        </fo:block>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row height="8pt">
                                <fo:table-cell number-columns-spanned="5" border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block>
                                        <fo:inline>INDIRIZZO</fo:inline>
                                        <fo:inline> :</fo:inline>
                                        <fo:block font-size="12pt" font-style="normal" font-weight="bold" padding-before="4pt">
                                            <fo:inline>
                                                <xsl:value-of select="DUVRI/DUVRI_01/COMMITTENTE/IDZ_AZL"/>
                                            </fo:inline>
                                            <fo:inline>
                                                <xsl:value-of select="DUVRI/DUVRI_01/COMMITTENTE/NUM_CIC_AZL"/>
                                            </fo:inline>
                                        </fo:block>
                                        <fo:block font-size="12pt" font-style="normal" font-weight="bold" padding-before="3pt">
                                            <fo:inline>
                                                <xsl:value-of select="DUVRI/DUVRI_01/COMMITTENTE/CAP_AZL"/>
                                            </fo:inline>
                                            <fo:inline>
                                                <xsl:value-of select="DUVRI/DUVRI_01/COMMITTENTE/CIT_AZL"/>
                                            </fo:inline>
                                            <fo:inline>
                                                <xsl:value-of select="DUVRI/DUVRI_01/COMMITTENTE/PRV_AZL"/>
                                            </fo:inline>
                                        </fo:block>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row height="8pt">
                                <fo:table-cell number-columns-spanned="5" border="solid 0.25pt #000000" padding="4pt" padding-top="5pt" padding-bottom="4pt">
                                    <fo:block>
                                        <fo:inline>EMAIL</fo:inline>
                                        <fo:inline> :</fo:inline>
                                        <fo:inline font-size="10pt" font-style="normal" padding-left="8pt">
                                            <xsl:value-of select="DUVRI/DUVRI_01/COMMITTENTE/IDZ_PSA_ELT_RSP_AZL"/>
                                        </fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row height="8pt">
                                <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block>
                                        <fo:inline>RECAPITI FISSI</fo:inline>
                                        <fo:inline> :</fo:inline>
                                        <fo:block>
                                            <xsl:for-each select="DUVRI/DUVRI_01/COMMITTENTE/Contatti_fissi/Numeri_telefono">
                                                <xsl:apply-templates />
                                            </xsl:for-each>
                                        </fo:block>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" border-left="solid 0.25pt #000000" border-right="solid 0.25pt #000000" padding="4pt">
                                    <fo:block>
                                        <fo:inline>RECAPITI MOBILI</fo:inline>
                                        <fo:inline> :</fo:inline>
                                        <fo:block>
                                            <xsl:for-each select="DUVRI/DUVRI_01/COMMITTENTE/Contatti_mobili/Numeri_cellulare">
                                                <xsl:apply-templates />
                                            </xsl:for-each>
                                        </fo:block>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block>
                                        <fo:inline>FAX</fo:inline>
                                        <fo:inline> :</fo:inline>
                                        <fo:block>
                                            <xsl:for-each select="DUVRI/DUVRI_01/COMMITTENTE/Contatti_fax/Numeri_fax">
                                                <xsl:apply-templates />
                                            </xsl:for-each>
                                        </fo:block>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>

<!-- IMPRESA APPALTATRICE -->
                    <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="8pt" font-style="italic" font-weight="normal" text-align="left" margin-top="10pt">
                        <fo:table-column column-width="0%" />
                        <fo:table-column column-width="34%" />
                        <fo:table-column column-width="16%" />
                        <fo:table-column column-width="17%" />
                        <fo:table-column column-width="33%" />
                        <fo:table-column column-width="0%" />
                        <fo:table-body>
                            <fo:table-row height="8pt">
                                <fo:table-cell number-columns-spanned="6" border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block font-weight="bold">
                                        <fo:inline font-size="9pt" text-decoration="underline">IMPRESA APPALTATRICE / AFFIDATARIA</fo:inline>
                                        <fo:inline font-size="9pt" text-decoration="no-underline"> :</fo:inline>
                                        <fo:block font-size="12pt" font-style="normal" font-weight="bold" padding-before="4pt">
                                            <xsl:value-of select="DUVRI/DUVRI_01/APPALTATRICE/RAG_SCL_DTE"/>
                                        </fo:block>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row height="8pt">
                                <fo:table-cell number-columns-spanned="6" border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block>
                                        <fo:inline text-decoration="no-underline">INDIRIZZO</fo:inline>
                                        <fo:inline text-decoration="no-underline"> :</fo:inline>
                                        <fo:block font-size="12pt" font-style="normal" font-weight="bold" padding-before="4pt">
                                            <fo:inline>
                                                <xsl:value-of select="DUVRI/DUVRI_01/APPALTATRICE/IDZ_DTE"/>
                                            </fo:inline>
                                            <fo:inline>
                                                <xsl:value-of select="DUVRI/DUVRI_01/APPALTATRICE/NUM_CIC_DTE"/>
                                            </fo:inline>
                                        </fo:block>
                                        <fo:block font-size="12pt" font-style="normal" font-weight="bold" padding-before="3pt">
                                            <fo:inline>
                                                <xsl:value-of select="DUVRI/DUVRI_01/APPALTATRICE/CAP_DTE"/>
                                            </fo:inline>
                                            <fo:inline>
                                                <xsl:value-of select="DUVRI/DUVRI_01/APPALTATRICE/CIT_DTE"/>
                                            </fo:inline>
                                            <fo:inline>
                                                <xsl:value-of select="DUVRI/DUVRI_01/APPALTATRICE/PRV_DTE"/>
                                            </fo:inline>
                                        </fo:block>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row height="8pt">
                                <fo:table-cell number-columns-spanned="6" border="solid 0.25pt #000000" padding="4pt" padding-top="5pt" padding-bottom="4pt">
                                    <fo:block>
                                        <fo:inline text-decoration="no-underline">EMAIL</fo:inline>
                                        <fo:inline text-decoration="no-underline"> :</fo:inline>
                                        <fo:inline text-decoration="no-underline" font-size="10pt" font-style="normal" padding-left="8pt">
                                            <xsl:value-of select="DUVRI/DUVRI_01/APPALTATRICE/APP_EMAIL"/>
                                        </fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row height="8pt">
                                <fo:table-cell number-columns-spanned="3" border="solid 0.25pt #000000" padding="4pt" padding-top="5pt" padding-bottom="4pt">
                                    <fo:block>
                                        <fo:inline text-decoration="no-underline">RECAPITO FISSO</fo:inline>
                                        <fo:inline text-decoration="no-underline"> :</fo:inline>
                                        <fo:inline text-decoration="no-underline" font-size="10pt" font-style="normal" padding-left="8pt">
                                            <xsl:value-of select="DUVRI/DUVRI_01/APPALTATRICE/APP_TEL"/>
                                        </fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell number-columns-spanned="3" border="solid 0.25pt #000000" padding="4pt" padding-top="5pt" padding-bottom="4pt">
                                    <fo:block>
                                        <fo:inline text-decoration="no-underline">FAX</fo:inline>
                                        <fo:inline text-decoration="no-underline"> :</fo:inline>
                                        <fo:inline text-decoration="no-underline" font-size="10pt" font-style="normal" padding-left="8pt">
                                            <xsl:value-of select="DUVRI/DUVRI_01/APPALTATRICE/APP_FAX"/>
                                        </fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell number-columns-spanned="6" padding="3pt">
										
										
                                    <fo:table width="100%" border="solid 0.5pt #000000" font-family="sans-serif" font-size="8pt" font-style="italic" font-weight="normal" text-align="left" margin-top="8pt" margin-bottom="3pt">
                                        <fo:table-column column-width="40%" />
                                        <fo:table-column column-width="60%" />
                                        <fo:table-body>
                                            <fo:table-row height="6pt">
                                                <fo:table-cell border="solid 0.25pt #000000" font-weight="bold" text-align="left" padding="4pt">
                                                    <fo:block>
															RIFERIMENTO CONTRATTO/ORDINE
                                                    </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell font-size="10pt" font-style="normal" text-align="left" padding="4pt">
                                                    <fo:block>
                                                        <xsl:value-of select="DUVRI/DUVRI_01/APPALTATRICE/RIF_CON"/>
                                                    </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                        </fo:table-body>
                                    </fo:table>
										
										
                                    <fo:table width="100%" border="solid 0.5pt #000000" font-family="sans-serif" font-size="8pt" font-style="italic" font-weight="normal" text-align="left" margin-bottom="3pt">
                                        <fo:table-column column-width="40%" />
                                        <fo:table-column column-width="60%" />
                                        <fo:table-body>
                                            <fo:table-row>
                                                <fo:table-cell border="solid 0.25pt #000000" font-weight="bold" text-align="left" padding="4pt">
                                                    <fo:block>
															TIPO DI LAVORO/SERVIZIO DA ESEGUIRE (Descrizione generica)
                                                    </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell font-size="10pt" font-style="normal" text-align="left" padding="4pt">
                                                    <fo:block>
                                                        <xsl:value-of select="DUVRI/DUVRI_01/APPALTATRICE/DES_CON"/>
                                                    </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                        </fo:table-body>
                                    </fo:table>
										
										
                                  <!--  <fo:table width="100%" border="solid 0.5pt #000000" font-family="sans-serif" font-size="8pt" font-style="italic" font-weight="normal" text-align="left">
                                        <fo:table-column column-width="40%" />
                                        <fo:table-column column-width="60%" />
                                        <fo:table-body>
												
                                            <fo:table-row>
                                                <fo:table-cell  border="solid 0.5pt #000000" font-weight="bold" text-align="center" padding="4pt">
                                                    <fo:block>
															LUOGHI DI ESECUZIONE
                                                    </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell  border="solid 0.5pt #000000" font-weight="bold" text-align="center" padding="4pt">
                                                    <fo:block>
															DESCRIZIONE
                                                    </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                            <xsl:for-each select="DUVRI/DUVRI_01/APPALTATRICE/Luoghi_esecuzione/Luoghi_fisici">
                                                <xsl:apply-templates />
                                            </xsl:for-each>
												
                                        </fo:table-body>
                                    </fo:table>-->
										
                                </fo:table-cell>
                            </fo:table-row>
                                
                        </fo:table-body>
                    </fo:table>
				
				
                </fo:flow>
            </fo:page-sequence>

            <fo:page-sequence master-reference="A4-vertical">

                <fo:static-content flow-name="xsl-region-after-ver" display-align="after" margin-right="15pt">
                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                        <fo:inline>S2S S.r.l Sistema della sicurezza</fo:inline>
                    </fo:block>
                </fo:static-content>

                <fo:static-content flow-name="xsl-region-end-ver">
                    <fo:block font-family="sans-serif" font-size="8pt" text-align="right" margin-top="740pt">
						Pag.
                        <fo:page-number/>
                    </fo:block>
                </fo:static-content>

                <fo:static-content flow-name="xsl-region-before-hor">
                    <fo:block font-size="22pt" font-weight="bold" text-align="center" display-align="justify" margin-left="14pt" margin-top="-20pt">

                        <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="8pt" font-style="italic" font-weight="normal" text-align="left">
                            <fo:table-column column-width="41.3%" />
                            <fo:table-column column-width="61.8%" />
                            <fo:table-body>

                                <fo:table-row>
                                    <fo:table-cell  border="solid 1.5pt #000000" font-weight="bold" text-align="center" padding="4pt">
                                        <fo:block>
															LUOGHI DI ESECUZIONE
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell  border="solid 1.5pt #000000" font-weight="bold" text-align="center" padding="4pt">
                                        <fo:block>
															DESCRIZIONE
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                             
                            </fo:table-body>
                        </fo:table>
                    </fo:block>

                </fo:static-content>

                <fo:flow flow-name="xsl-region-body">
                    <fo:block padding="2pt" font-size="22pt" font-weight="bold" text-align="center">
                        <fo:table width="100%" border="solid 0.5pt #000000" font-family="sans-serif" font-size="8pt" font-style="italic" font-weight="normal" text-align="left">
                            <fo:table-column column-width="40%" />
                            <fo:table-column column-width="60%" />
                            <fo:table-body>


                                <xsl:for-each select="DUVRI/DUVRI_01/APPALTATRICE/Luoghi_esecuzione/Luoghi_fisici">
                                    <xsl:apply-templates />
                                </xsl:for-each>

                            </fo:table-body>
                        </fo:table>

                    </fo:block>
                     
                </fo:flow>
            </fo:page-sequence>
      
<!-- Inizio pagina verticale -->
<!-- ************************************************************  DUVRI_02 ************************************************************  -->
            <fo:page-sequence master-reference="A4-vertical">
                
                <fo:static-content flow-name="xsl-region-after-ver" display-align="after" margin-right="15pt">
                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                        <fo:block text-align="center" padding-before="5mm" padding-after="4mm"/>

                        <fo:inline>S2S S.r.l Sistema della sicurezza</fo:inline>
                    </fo:block>
                </fo:static-content>

                <fo:static-content flow-name="xsl-region-end-ver">
                    <fo:block font-family="sans-serif" font-size="8pt" text-align="right" margin-top="740pt">
						Pag.
                        <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                
                <fo:flow flow-name="xsl-region-body">
						<!-- INFORMAZIONI SUI LAVORI/SERVIZI -->
                    <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="8pt" font-style="normal" font-weight="normal" text-align="left" margin-top="10pt">
                        <fo:table-column column-width="0%" />
                        <fo:table-column column-width="45%" />
                        <fo:table-column column-width="55%" />
                        <fo:table-column column-width="0%" />
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell number-columns-spanned="4" border="solid 1.5pt #000000" display-align="center" padding="4pt">
                                    <fo:block font-size="10pt" font-weight="bold" text-align="left">
                                        <fo:inline text-decoration="no-underline">INFORMAZIONI SUI LAVORI/SERVIZI</fo:inline>
                                        <fo:inline> :</fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt" padding-top="6pt" padding-bottom="6pt">
                                    <fo:block font-size="8pt">
                                        <fo:inline font-style="italic" text-decoration="no-underline">DATA DI INIZIO DELL'INTERVENTO</fo:inline>
                                        <fo:inline> :</fo:inline>
                                        <fo:inline font-size="10pt" padding-left="8pt">
                                            <xsl:value-of select="DUVRI/DUVRI_01/INFO_LAVORI/DAT_INI_LAV"/>
                                        </fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt" padding-top="6pt" padding-bottom="6pt">
                                    <fo:block font-size="8pt">
                                        <fo:inline font-style="italic" text-decoration="no-underline">DATA DI CONCLUSIONE DELL'INTERVENTO</fo:inline>
                                        <fo:inline> :</fo:inline>
                                        <fo:inline font-size="10pt" padding-left="8pt">
                                            <xsl:value-of select="DUVRI/DUVRI_01/INFO_LAVORI/DAT_FIN_LAV"/>
                                        </fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt" padding-top="6pt" padding-bottom="6pt">
                                    <fo:block font-size="8pt">
                                        <fo:inline font-style="italic" text-decoration="no-underline">ORARIO DI LAVORO</fo:inline>
                                        <fo:inline> :</fo:inline>
                                        <fo:inline font-size="10pt" padding-left="8pt">
                                            <xsl:value-of select="DUVRI/DUVRI_01/INFO_LAVORI/ORA_LAV"/>
                                        </fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt" padding-top="6pt" padding-bottom="6pt">
                                    <fo:block font-size="8pt">
                                        <fo:inline font-style="italic" text-decoration="no-underline">LAVORO NOTTURNO</fo:inline>
                                        <fo:inline> :</fo:inline>
                                        <fo:inline font-size="10pt" padding-left="8pt">
                                            <xsl:value-of select="DUVRI/DUVRI_01/INFO_LAVORI/LAV_NOT"/>
                                        </fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell number-columns-spanned="4" border="solid 0.25pt #000000" padding="4pt" padding-top="6pt" padding-bottom="6pt">
                                    <fo:block font-size="8pt">
                                        <fo:inline font-style="italic" text-decoration="no-underline">NUMERO DI LAVORATORI PREVISTI IN CANTIERE</fo:inline>
                                        <fo:inline> :</fo:inline>
                                        <fo:inline font-size="10pt" padding-left="8pt">
                                            <xsl:value-of select="DUVRI/DUVRI_01/INFO_LAVORI/NUM_LAV_PRE"/>
                                        </fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>

                    <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="10pt" font-style="normal" text-align="left" margin-top="40pt">
                        <fo:table-column column-width="0%" />
                        <fo:table-column column-width="20%" />
                        <fo:table-column column-width="80%" />
                        <fo:table-column column-width="0%" />
               
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell number-columns-spanned="4" border="solid 1.5pt #000000" font-size="12pt" font-weight="bold" text-align="left" padding="4pt">
                                    <fo:block>
										ELENCO ALLEGATI AL PRESENTE DOCUMENTO
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                       <!--     <fo:table-row>
                                <fo:table-cell display-align="center" padding="4pt">
                                    <fo:block>
										ELENCO ALLEGATI AL PRESENTE DOCUMENTO
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            -->
                            <fo:table-row height="1.4cm">
                                <fo:table-cell number-columns-spanned="4" font-size="10pt" font-style="normal" font-weight="normal">
                                    <fo:block margin-left="6pt" padding-before="3pt">
                                        <fo:inline text-decoration="underline">Vedi documento/i allegato/i</fo:inline>
                                        <fo:inline> :</fo:inline>
                                        <fo:block>
                                            <xsl:for-each select="DUVRI/DUVRI_02/ALLEGATI_ISPEZIONI/Ispezioni">
                                                <xsl:apply-templates />
                                            </xsl:for-each>
                                        </fo:block>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
            

                </fo:flow>
            </fo:page-sequence>
            <fo:page-sequence master-reference="A4-vertical">
                <fo:static-content flow-name="xsl-region-after-ver" display-align="after" margin-right="15pt">
                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                        <fo:block text-align="center" padding-before="5mm" padding-after="4mm"/>

                        <fo:inline>S2S S.r.l Sistema della sicurezza</fo:inline>
                    </fo:block>
                </fo:static-content>
                <fo:static-content flow-name="xsl-region-end-ver">
                    <fo:block font-family="sans-serif" font-size="8pt" text-align="right" margin-top="740pt">
						Pag.
                        <fo:page-number/>
                    </fo:block>
                </fo:static-content>

        
                <fo:flow flow-name="xsl-region-body">
         			
                    <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="12pt" font-style="normal" font-weight="bold" text-align="left" margin-top="10pt">
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block>

                               <!-- <fo:table width="100%" border-bottom="solid 1.5pt #000000" font-family="sans-serif" font-size="12pt" font-style="normal" font-weight="bold" text-align="left">
                                     <fo:table-column column-width="0%" />
                                <fo:table-body>
                                        <fo:table-row>
                                            <fo:table-cell display-align="center" padding="4pt">
                                                <fo:block>
																INFORMAZIONI SUI RESPONSABILI
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                    </fo:table-body>
                                </fo:table>-->
                                        <fo:table width="100%" border-bottom="solid 1.5pt #000000" font-family="sans-serif" font-size="12pt" font-style="normal" font-weight="bold" text-align="left">
                                            <fo:table-column column-width="100%" />
                                            <fo:table-body>
                                                <fo:table-row>
                                                    <fo:table-cell display-align="center" padding="4pt">
                                                        <fo:block>
																INFORMAZIONI SUI RESPONSABILI
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                            </fo:table-body>
                                        </fo:table>
                                        <fo:table width="100%" border-top="solid 1.5pt #000000" border-bottom="solid 1.5pt #000000" font-family="sans-serif" font-size="8pt" font-style="italic" font-weight="normal" text-align="left" margin-top="0cm" margin-bottom="0cm">
                                            <fo:table-column column-width="0%" />
                                            <fo:table-column column-width="50%" />
                                            <fo:table-column column-width="25%" />
                                            <fo:table-column column-width="25%" />
                                            <fo:table-column column-width="0%" />
                                            <fo:table-body>
                                                <fo:table-row>
                                                    <fo:table-cell number-columns-spanned="5" border-bottom="solid 1.5pt #000000" display-align="center" font-size="10pt" font-weight="bold" padding="4pt">
                                                        <fo:block>
                                                            <fo:inline font-size="8pt" font-style="italic">PARTE A</fo:inline>
                                                            <fo:inline font-size="8pt" font-style="italic" padding-left="5pt">-</fo:inline>
                                                            <fo:inline font-style="normal" padding-left="10pt">
                                                                <xsl:value-of select="DUVRI/DUVRI_02/COMMITTENTE_02"/>
                                                            </fo:inline>
                                                            <fo:inline font-size="8pt" font-style="italic" padding-left="15pt">(COMMITTENTE)</fo:inline>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <fo:table-row height="20pt">
                                                    <fo:table-cell number-columns-spanned="5" border="solid 0.25pt #000000" padding="4pt" padding-before="12pt">
                                                        <fo:block>
                                                            <fo:inline>COGNOME E NOME DEL RESPONSABILE</fo:inline>
                                                            <fo:inline> : </fo:inline>
                                                            <fo:inline font-size="10pt" font-style="normal" font-weight="bold" padding-left="8pt">
                                                                <xsl:value-of select="DUVRI/DUVRI_02/RESPONSABILI_CMT/COG_DPD_RSP"/>
                                                            </fo:inline>
                                                            <fo:inline> </fo:inline>
                                                            <fo:inline font-size="10pt" font-style="normal" font-weight="bold" padding-left="5pt">
                                                                <xsl:value-of select="DUVRI/DUVRI_02/RESPONSABILI_CMT/NOM_DPD_RSP"/>
                                                            </fo:inline>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <fo:table-row height="20pt">
                                                    <fo:table-cell number-columns-spanned="5" border="solid 0.25pt #000000" padding="4pt" padding-before="12pt">
                                                        <fo:block>
                                                            <fo:inline>QUALIFICA DEL RESPONSABILE</fo:inline>
                                                            <fo:inline> : </fo:inline>
                                                            <fo:inline font-size="10pt" font-style="normal" font-weight="bold" padding-left="8pt">
                                                                <xsl:value-of select="DUVRI/DUVRI_02/RESPONSABILI_CMT/NOM_FUZ_AZL_RSP"/>
                                                            </fo:inline>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <fo:table-row height="20pt">
                                                    <fo:table-cell number-columns-spanned="5" border="solid 0.25pt #000000" padding="4pt" padding-before="12pt">
                                                        <fo:block>
                                                            <fo:inline>NUMERO TELEFONICO DEL RESPONSABILE</fo:inline>
                                                            <fo:inline> : </fo:inline>
                                                            <fo:inline font-size="10pt" font-style="normal" font-weight="bold" padding-left="8pt">
                                                                <xsl:value-of select="DUVRI/DUVRI_02/RESPONSABILI_CMT/COM_RES_TEL"/>
                                                            </fo:inline>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <fo:table-row height="12pt">
                                                    <fo:table-cell number-columns-spanned="2" display-align="center" border="solid 0.5pt #000000" font-size="8pt" font-style="normal" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
																	NOME DEI REFERENTI IN LOCO
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell display-align="center" border="solid 0.5pt #000000" font-size="8pt" font-style="normal" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
																	QUALIFICA
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell number-columns-spanned="2" display-align="center" border="solid 0.5pt #000000" font-size="8pt" font-style="normal" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
																	N. TELEFONICO
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <xsl:for-each select="DUVRI/DUVRI_02/RESPONSABILI_CMT/Referenti_loco_cmt/Referenti">
                                                    <xsl:apply-templates />
                                                </xsl:for-each>
                                            </fo:table-body>
                                        </fo:table>
												
                                        <fo:table width="100%" border-top="solid 1.5pt #000000" font-family="sans-serif" font-size="8pt" font-style="italic" font-weight="normal" text-align="left" margin-top="1.0cm">
                                            <fo:table-column column-width="0%" />
                                            <fo:table-column column-width="50%" />
                                            <fo:table-column column-width="25%" />
                                            <fo:table-column column-width="25%" />
                                            <fo:table-column column-width="0%" />
                                            <fo:table-body>
                                                <fo:table-row>
                                                    <fo:table-cell number-columns-spanned="5" border-bottom="solid 1.5pt #000000" display-align="center" font-size="10pt" font-weight="bold" padding="4pt">
                                                        <fo:block>
                                                            <fo:inline font-size="8pt" font-style="italic">PARTE B</fo:inline>
                                                            <fo:inline font-size="8pt" font-style="italic" padding-left="5pt">-</fo:inline>
                                                            <fo:inline font-style="normal" padding-left="10pt">
                                                                <xsl:value-of select="DUVRI/DUVRI_02/APPALTATRICE_02"/>
                                                            </fo:inline>
                                                            <fo:inline font-size="8pt" font-style="italic" padding-left="15pt">(IMPRESA APPALTATRICE/AFFIDATARIA)</fo:inline>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <fo:table-row height="20pt">
                                                    <fo:table-cell number-columns-spanned="5" border="solid 0.25pt #000000" padding="4pt" padding-before="12pt">
                                                        <fo:block>
                                                            <fo:inline>COGNOME E NOME DEL RESPONSABILE</fo:inline>
                                                            <fo:inline> : </fo:inline>
                                                            <fo:inline font-size="10pt" font-style="normal" font-weight="bold" padding-left="8pt">
                                                                <xsl:value-of select="DUVRI/DUVRI_02/RESPONSABILI_APP/APP_RES_NOM"/>
                                                            </fo:inline>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <fo:table-row height="20pt">
                                                    <fo:table-cell number-columns-spanned="5" border="solid 0.25pt #000000" padding="4pt" padding-before="12pt">
                                                        <fo:block>
                                                            <fo:inline>QUALIFICA DEL RESPONSABILE</fo:inline>
                                                            <fo:inline> : </fo:inline>
                                                            <fo:inline font-size="10pt" font-style="normal" font-weight="bold" padding-left="8pt">
                                                                <xsl:value-of select="DUVRI/DUVRI_02/RESPONSABILI_APP/APP_RES_QUA"/>
                                                            </fo:inline>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <fo:table-row height="20pt">
                                                    <fo:table-cell number-columns-spanned="5" border="solid 0.25pt #000000" padding="4pt" padding-before="12pt">
                                                        <fo:block>
                                                            <fo:inline>NUMERO TELEFONICO DEL RESPONSABILE</fo:inline>
                                                            <fo:inline> : </fo:inline>
                                                            <fo:inline font-size="10pt" font-style="normal" font-weight="bold" padding-left="8pt">
                                                                <xsl:value-of select="DUVRI/DUVRI_02/RESPONSABILI_CMT/APP_RES_TEL"/>
                                                            </fo:inline>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <fo:table-row height="12pt">
                                                    <fo:table-cell number-columns-spanned="2" display-align="center" border="solid 0.5pt #000000" font-size="8pt" font-style="normal" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
																	NOME DEI REFERENTI IN LOCO
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell display-align="center" border="solid 0.5pt #000000" font-size="8pt" font-style="normal" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
																	QUALIFICA
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell number-columns-spanned="2" display-align="center" border="solid 0.5pt #000000" font-size="8pt" font-style="normal" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
																	N. TELEFONICO
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <xsl:for-each select="DUVRI/DUVRI_02/RESPONSABILI_APP/Referenti_loco_app/Referenti">
                                                    <xsl:apply-templates />
                                                </xsl:for-each>
														
                                            </fo:table-body>
                                        </fo:table>

                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>

							
							
                </fo:flow>
            </fo:page-sequence>
				<!-- Fine pagina verticale -->
	
	
	<!-- ************************************************************  DUVRI_03 ************************************************************  -->
       <!-- ************************************************************  DUVRI_03 ************************************************************  -->
    <fo:page-sequence master-reference="A4-vertical">

        <fo:static-content flow-name="xsl-region-end-ver">
            <fo:block font-family="sans-serif" font-size="8pt" text-align="right" margin-top="740pt">
						Pag.
                <fo:page-number/>
            </fo:block>
        </fo:static-content>

        <fo:static-content flow-name="xsl-region-after-ver" display-align="after" margin-right="45pt">
            <fo:block font-family="sans-serif" font-size="10pt" text-align="justify">
                <fo:inline font-weight="bold" text-decoration="underline">NOTA GENERALE</fo:inline>
                <fo:inline> - L'Impresa Appaltatrice/Affidataria e le Imprese Subappaltatrici/Esecutrici si impegnano a rispettare i contenuti del documento "Disposizioni Generali di Sicurezza", parte integrante del "contratto".</fo:inline>
            </fo:block>
        </fo:static-content>

        <fo:flow flow-name="xsl-region-body">
            <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="12pt" font-style="normal" font-weight="bold" text-align="left">
                <fo:table-column column-width="0%" />
                <fo:table-column column-width="5%" />
                <fo:table-column column-width="40%" />
                <fo:table-column column-width="55%" />
                <fo:table-column column-width="0%" />
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="5" border="solid 1.5pt #000000" display-align="center" font-size="10pt" font-style="italic" font-weight="bold" padding="4pt">
                            <fo:block>
									PARTE C - IMPRESE SUBAPPALTATRICI / ESECUTRICI
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row height="12pt">
                        <fo:table-cell number-columns-spanned="2" display-align="center" border="solid 0.5pt #000000" font-size="8pt" font-style="normal" font-weight="bold" text-align="center" padding="4pt">
                            <fo:block>
								N°
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell display-align="center" border="solid 0.5pt #000000" font-size="8pt" font-style="normal" font-weight="bold" text-align="center" padding="4pt">
                            <fo:block>
								DENOMINAZIONE IMPRESA
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell number-columns-spanned="2" display-align="center" border="solid 0.5pt #000000" font-size="8pt" font-style="normal" font-weight="bold" text-align="center" padding="4pt">
                            <fo:block>
								DESCRIZIONE SINTETICA DELL'INTERVENTO
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <xsl:for-each select="DUVRI/DUVRI_03/SUBAPPALTATRICI/Imprese_subappaltatrici/Imprese">
                        <xsl:apply-templates />
                    </xsl:for-each>
                    <fo:table-row height="7.5cm">
                        <fo:table-cell number-columns-spanned="5" padding="10pt">
                            <fo:block font-size="10pt" text-align="left">
                                <fo:inline text-decoration="underline">ANNOTAZIONI</fo:inline>
                                <fo:inline> :</fo:inline>
                                <fo:block display-align="center" font-size="10pt" font-style="italic" text-align="center" padding="4pt" margin-bottom="7pt" margin-top="7pt" >
												OGNI SITUAZIONE ANORMALE O PERICOLOSA DEVE ESSERE SEGNALATA AL CENTRO INFORMATIVO DEL COMMITTENTE
                                </fo:block>
                                <!--  <fo:table width="100%" border-right="solid 1.0pt #000000" margin-top="0pt" margin-bottom="0pt">
                                    <fo:table-column column-width="50%" />
                                    <fo:table-column column-width="50%" />
                                    <fo:table-body>
                                        <fo:table-row>
                                            <fo:table-cell number-columns-spanned="2" border="solid 1.0pt #000000" text-align="center" padding="4pt">
                                                <fo:block font-size="9pt" font-weight="bold" text-align="center">
                                                    <fo:inline>LISTA DEL PERSONALE</fo:inline>
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                        <fo:table-row>
                                            <fo:table-cell border="solid 0.5pt #000000" text-align="center" padding="4pt">
                                                <fo:block font-size="8pt" font-weight="normal" text-align="center">
													COGNOME E NOME
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell border="solid 0.5pt #000000" padding="4pt" display-align="center" text-align="center">
                                                <fo:block font-size="8pt" font-weight="normal" text-align="center">
													QUALIFICA
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                              <xsl:for-each select="DUVRI/DUVRI_03/CENTRI_INFORMATIVI_CMT/Centri_informativi/Centri_emergenza">
                                         <xsl:apply-templates />
                                       </xsl:for-each>
                                    </fo:table-body>
                                </fo:table>-->

                              <fo:table width="90%" display-align="center" border="solid 0.5pt #000000" font-family="sans-serif" font-size="12pt" font-style="normal" font-weight="bold" text-align="center" margin="22pt">
                                   <fo:table-column column-width="25%" />
                                    <fo:table-column column-width="30%" />
                                    <fo:table-body>
                                        <fo:table-row height="10pt">
                                            <fo:table-cell number-columns-spanned="2" display-align="center" border="solid 0.5pt #000000" font-size="9pt" font-style="normal" font-weight="bold" padding="4pt" text-align="center">
                                                <fo:block>SOCCORSI ESTERNI</fo:block>
                                            </fo:table-cell>
                                              <fo:table-cell number-columns-spanned="2" display-align="center" border="solid 0.5pt #000000" font-size="9pt" font-style="normal" font-weight="bold" padding="4pt" text-align="center">
                                                <fo:block>RIFERIMENTO</fo:block>
                                            </fo:table-cell>


                                        </fo:table-row>

                                        <xsl:for-each select="DUVRI/DUVRI_03/CENTRI_INFORMATIVI_CMT/Centri_informativi/Centri_emergenza">
                                         <xsl:apply-templates />
                                       </xsl:for-each>


                                    </fo:table-body>
                                </fo:table>

                                <fo:block font-size="10pt" font-style="normal" font-weight="normal" text-align="justify">
                                    <fo:inline text-decoration="no-underline" font-weight="bold">ORGANIZZAZIONE DEI SOCCORSI</fo:inline>
                                    <fo:inline> : </fo:inline>
                                    <fo:inline text-decoration="no-underline" font-weight="normal">
                                        <xsl:value-of select="DUVRI/DUVRI_03/CENTRI_INFORMATIVI_CMT/CEN_EME_DES"/>
                                    </fo:inline>

                                </fo:block>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>

			<!-- ELENCO ALLEGATI -->
            <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="10pt" font-style="normal" text-align="left" margin-top="40pt">
                <fo:table-column column-width="0%" />
                <fo:table-column column-width="20%" />
                <fo:table-column column-width="80%" />
                <fo:table-column column-width="0%" />
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="4" border="solid 1.5pt #000000" font-size="12pt" font-weight="bold" text-align="left" padding="4pt">
                            <fo:block>
										ELENCO ALLEGATI
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                            <fo:block margin-top="2pt" margin-bottom="2pt">
										SCHEDA A
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                            <fo:block margin-top="2pt" margin-bottom="2pt">
										Descrizione lavori/servizi Impresa Appaltatrice / Affidataria
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                            <fo:block margin-top="2pt" margin-bottom="2pt">
										SCHEDA B
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                            <fo:block margin-top="2pt" margin-bottom="2pt">
										Descrizione lavori/servizi Impresa Subappaltatrice / Esecutrice
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                            <fo:block margin-top="2pt" margin-bottom="2pt">
										SCHEDA C
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                            <fo:block margin-top="2pt" margin-bottom="2pt">
										Rischi connessi all'interferenza tra le attività
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                            <fo:block margin-top="2pt" margin-bottom="2pt">
										ALLEGATO 1
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                            <fo:block margin-top="2pt" margin-bottom="2pt">
										Messa a disposizione dei Servizi Sanitari
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                            <fo:block margin-top="2pt" margin-bottom="2pt">
										ALLEGATO 2
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                            <fo:block margin-top="2pt" margin-bottom="2pt">
										Messa a disposizione dei fluidi
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                            <fo:block margin-top="2pt" margin-bottom="2pt">
										ALLEGATO 3
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                            <fo:block margin-top="2pt" margin-bottom="2pt">
										Prestito di materiali
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                            <fo:block margin-top="2pt" margin-bottom="2pt">
										ALLEGATO 4
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                            <fo:block margin-top="2pt" margin-bottom="2pt">
										Costi della sicurezza
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>

                </fo:table-body>
            </fo:table>
        </fo:flow>
    </fo:page-sequence>
	
	<!-- ************************************************************  DUVRI_04 ************************************************************  -->
            <fo:page-sequence master-reference="A4-vertical-notes">
		
                <fo:static-content flow-name="xsl-region-end-ver">
                    <fo:block font-family="sans-serif" font-size="8pt" text-align="right" margin-top="740pt">
						Pag.
                        <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                <fo:static-content flow-name="xsl-region-after-ver" display-align="after" margin-right="15pt">
                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                        <fo:inline font-weight="bold">NOTE GENERALI</fo:inline>
                    </fo:block>
                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                        <fo:inline>- Ogni nuovo elemento relativo alla natura del presente documento, seppure emerso durante i lavori, dovrà essere segnalato al responsabile del committente in tempi brevi.</fo:inline>
                    </fo:block>
                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                        <fo:inline>- Si ritiene che il materiale introdotto dall'impresa appaltatrice durante l'esercizio sia in buono stato, conforme alle normative vigenti e sotto la responsabilità dell'impresa stessa.</fo:inline>
                    </fo:block>
                </fo:static-content>
                
                <fo:flow flow-name="xsl-region-body">
                    <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="12pt" font-style="normal" font-weight="normal" text-align="left">
                        <fo:table-column column-width="0%" />
                        <fo:table-column column-width="43%" />
                        <fo:table-column column-width="23%" />
                        <fo:table-column column-width="34%" />
                        <fo:table-column column-width="0%" />
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell number-columns-spanned="5" border="solid 1.5pt #000000" font-weight="bold" padding="4pt">
                                    <fo:block>
                                        <fo:inline font-size="11pt" font-style="normal" font-weight="bold">SCHEDA A - DESCRIZIONE LAVORI/SERVIZI IMPRESA APPALTATRICE / AFFIDATARIA</fo:inline>
                                    </fo:block>
                                    <fo:block>
                                        <fo:inline font-size="12pt" font-style="normal" font-weight="bold">
                                            <xsl:value-of select="DUVRI/DUVRI_04/DESCRIZIONE_SERVIZI_APP/RAG_SCL_DTE"/>
                                        </fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell number-columns-spanned="5" border="solid 1.5pt #000000" font-size="10pt" font-style="italic" font-weight="bold" padding="3pt">
                                    <fo:block>
									PARTE A - ANAGRAFICA IMPRESA
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row height="12pt">
                                <fo:table-cell number-columns-spanned="2" number-rows-spanned="4" border="solid 0.25pt #000000" font-style="normal" padding="4pt">
                                    <fo:block font-size="9pt">
                                        <fo:inline font-style="italic">NOME O TIMBRO DELL'IMPRESA</fo:inline>
                                        <fo:inline> :</fo:inline>
                                        <fo:block font-size="12pt" font-style="normal" padding-before="4pt">
                                            <xsl:value-of select="DUVRI/DUVRI_04/DESCRIZIONE_SERVIZI_APP/RAG_SCL_DTE"/>
                                        </fo:block>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell number-columns-spanned="3" border="solid 0.25pt #000000" font-style="normal" padding="4pt">
                                    <fo:block font-size="9pt">
                                        <fo:inline font-style="italic">COGNOME E NOME DEL RESPONSABILE IN LOCO</fo:inline>
                                        <fo:inline> :</fo:inline>
                                        <fo:block font-size="12pt" font-style="normal" padding-before="4pt">
                                            <xsl:value-of select="DUVRI/DUVRI_04/DESCRIZIONE_SERVIZI_APP/APP_RES_NOM"/>
                                        </fo:block>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row height="12pt">
                                <fo:table-cell number-columns-spanned="3" border="solid 0.25pt #000000" font-style="normal" padding="4pt">
                                    <fo:block font-size="9pt">
                                        <fo:inline font-style="italic" font-weight="normal">QUALIFICA DEL RESPONSABILE IN LOCO</fo:inline>
                                        <fo:inline> :</fo:inline>
                                        <fo:block font-size="12pt" font-style="normal" padding-before="4pt">
                                            <xsl:value-of select="DUVRI/DUVRI_04/DESCRIZIONE_SERVIZI_APP/APP_RES_QUA"/>
                                        </fo:block>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row height="12pt">
                                <fo:table-cell number-columns-spanned="3" border="solid 0.25pt #000000" font-style="normal" padding="5pt">
                                    <fo:block font-size="9pt">
                                        <fo:inline font-style="italic" font-weight="normal">NUMERO TELEFONICO DEL RESPONSABILE IN LOCO</fo:inline>
                                        <fo:inline> :</fo:inline>
                                        <fo:block font-size="12pt" font-style="normal" padding-before="4pt">
                                            <xsl:value-of select="DUVRI/DUVRI_04/DESCRIZIONE_SERVIZI_APP/APP_RES_TEL"/>
                                        </fo:block>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row height="30pt">
                                <fo:table-cell border="solid 0.25pt #000000" font-style="normal" padding="4pt">
                                    <fo:block font-size="10pt" font-style="italic">
                                        <fo:inline font-style="italic" font-weight="normal">DATA</fo:inline>
                                        <fo:inline> :</fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" font-style="normal" padding="4pt">
                                    <fo:block font-size="10pt" font-style="italic">
                                        <fo:inline font-style="italic" font-weight="normal">FIRMA</fo:inline>
                                        <fo:inline> :</fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row height="110pt">
                                <fo:table-cell number-columns-spanned="5" border="solid 0.25pt #000000" font-style="normal" padding="4pt">
                                    <fo:block font-size="9pt" font-style="italic">
                                        <fo:inline>DESCRIZIONE SINTETICA DELL'INTERVENTO</fo:inline>
                                        <fo:inline> :</fo:inline>
                                        <fo:block font-size="12pt" font-style="normal" padding-before="4pt">
                                            <xsl:value-of select="DUVRI/DUVRI_04/DESCRIZIONE_SERVIZI_APP/APP_INT_ASS_DES"/>
                                        </fo:block>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row height="25pt">
                                <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" font-style="normal" padding="4pt">
                                    <fo:block font-size="9pt" font-style="italic">
                                        <fo:inline>ORARIO DI LAVORO</fo:inline>
                                        <fo:inline> :</fo:inline>
                                        <fo:block font-size="12pt" font-style="normal" padding-before="4pt">
                                            <xsl:value-of select="DUVRI/DUVRI_04/DESCRIZIONE_SERVIZI_APP/APP_INT_ASS_ORA_LAV"/>
                                        </fo:block>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell number-columns-spanned="3" border="solid 0.25pt #000000" font-style="normal" padding="4pt">
                                    <fo:block font-size="9pt" font-style="italic">
                                        <fo:inline>TIPO DI CONSEGNA</fo:inline>
                                        <fo:inline> :</fo:inline>
                                        <fo:block font-size="12pt" font-style="normal" padding-before="4pt">
                                            <fo:inline>
                                                <xsl:value-of select="DUVRI/DUVRI_04/DESCRIZIONE_SERVIZI_APP/APP_INT_ASS_COD_CON"/>
                                            </fo:inline>
                                            <fo:inline padding-left="8pt">
                                                <xsl:value-of select="DUVRI/DUVRI_04/DESCRIZIONE_SERVIZI_APP/APP_INT_ASS_CON_DES"/>
                                            </fo:inline>
                                        </fo:block>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
                </fo:flow >
            </fo:page-sequence>
						<!-- porzione di codice relativo alla tabella "Lista del personale" e "Elenco prodotti/sostanze" -->
						<!-- inizio della tabella esterna (che le conterrà entrambe) -->
            <fo:page-sequence master-reference="A4-vertical-notes">

                <fo:static-content flow-name="xsl-region-end-ver">
                    <fo:block font-family="sans-serif" font-size="8pt" text-align="right" margin-top="740pt">
						Pag.
                        <fo:page-number/>
                    </fo:block>
                </fo:static-content>

                <fo:static-content flow-name="xsl-region-after-ver" display-align="after" margin-right="15pt">
                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                        <fo:inline font-weight="bold">NOTE GENERALI</fo:inline>
                    </fo:block>
                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                        <fo:inline>- Ogni nuovo elemento relativo alla natura del presente documento, seppure emerso durante i lavori, dovrà essere segnalato al responsabile del committente in tempi brevi.</fo:inline>
                    </fo:block>
                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                        <fo:inline>- Si ritiene che il materiale introdotto dall'impresa appaltatrice durante l'esercizio sia in buono stato, conforme alle normative vigenti e sotto la responsabilità dell'impresa stessa.</fo:inline>
                    </fo:block>
                </fo:static-content>
                <fo:static-content flow-name="xsl-region-before-hor">
                    <fo:block font-size="22pt"   text-align="center" display-align="justify" margin-left="6pt" margin-top="-2pt">
                        <fo:table width="100%"   margin-top="0pt" margin-bottom="0pt">
                            <fo:table-column column-width="60%" />
                            <fo:table-column column-width="40%" />
                            <fo:table-body>
                                <fo:table-row>
                                    <fo:table-cell number-rows-spanned="2"><!-- apro la cella che contiene la tabella innestata a sx -->
                                        <fo:block>
                                            <fo:table  width="99%"  margin-top="0pt" margin-bottom="0pt">
                                                <fo:table-column column-width="50%" />
                                                <fo:table-column column-width="50%" />
                                                <fo:table-body>
                                                    <fo:table-row>
                                                        <fo:table-cell number-columns-spanned="2" border="solid 1.0pt #000000" text-align="center" padding="4pt">
                                                            <fo:block font-size="9pt" font-weight="bold" text-align="center">
                                                                <fo:inline>LISTA DEL PERSONALE</fo:inline>
                                                            </fo:block>
                                                        </fo:table-cell>
                                                    </fo:table-row>
                                                    <fo:table-row>
                                                        <fo:table-cell border="solid 0.5pt #000000" text-align="center" padding="4pt">
                                                            <fo:block font-size="8pt" font-weight="normal" text-align="center">
													COGNOME E NOME
                                                            </fo:block>
                                                        </fo:table-cell>
                                                        <fo:table-cell border="solid 0.5pt #000000" padding="4pt" display-align="center" text-align="center">
                                                            <fo:block font-size="8pt" font-weight="normal" text-align="center">
													QUALIFICA
                                                            </fo:block>
                                                        </fo:table-cell>

                                                    </fo:table-row>
                                                </fo:table-body>
                                            </fo:table>
                                                </fo:block>
                                                    </fo:table-cell><!-- chiudo la cella che contiene la tabella innestata a sx -->
                                                    <fo:table-cell><!-- apro la cella che contiene la tabella innestata a dx -->
                                                        <fo:block display-align="justify"  margin-left="-2pt">

									<!-- inizio della tabella innestata a dx (nella prima riga, seconda colonna) -->
                                                            <fo:table width="100%" border="solid 0.0pt #000000"   margin-left="0pt" margin-top="0pt" margin-bottom="0pt">
                                                                <fo:table-column column-width="107.6%" />
                                                                <fo:table-body>
                                                                    <fo:table-row>
                                                                        <fo:table-cell border="solid 1.0pt #000000" text-align="center" padding="4pt">
                                                                            <fo:block font-size="9pt" font-weight="bold" text-align="center">
													ELENCO PRODOTTI/SOSTANZE
                                                                            </fo:block>
                                                                        </fo:table-cell>
                                                                    </fo:table-row>
                                                                   <fo:table-row>
                                                                        <fo:table-cell  text-align="center" padding="4pt">
                                                                            <fo:block font-size="9pt" font-weight="bold" text-align="center">
													
                                                                            </fo:block>
                                                                        </fo:table-cell>
                                                                    </fo:table-row>
                                                                     <fo:table-row>
                                                                        <fo:table-cell text-align="center" padding="4pt">
                                                                            <fo:block font-size="9pt" font-weight="bold" text-align="center">

                                                                            </fo:block>
                                                                        </fo:table-cell>
                                                                    </fo:table-row>
                                                                    <fo:table-row>
                                                                        <fo:table-cell text-align="center" padding="4pt">
                                                                            <fo:block font-size="9pt" font-weight="bold" text-align="center">

                                                                            </fo:block>
                                                                        </fo:table-cell>
                                                                    </fo:table-row>
                                                                </fo:table-body>
                                                            </fo:table>
									<!-- fine della tabella innestata a dx (nella prima riga, seconda colonna) -->

                                                        </fo:block>
                                                    </fo:table-cell><!-- chiudo la cella che contiene la tabella innestata a dx -->
                                                </fo:table-row>
                            </fo:table-body>
                           </fo:table>
                                        </fo:block>

                                    </fo:static-content>

                                    <fo:flow flow-name="xsl-region-body">
                                    <fo:block font-size="22pt" font-weight="bold"   text-align="center" display-align="justify" margin-left="-12pt" margin-top="36pt">

                                        <fo:table width="100%"   margin-top="0pt" margin-bottom="0pt">
                                            <fo:table-column column-width="60%" />
                                            <fo:table-column column-width="40%" />
                                            <fo:table-body>
                                                <fo:table-row>
                                                    <fo:table-cell number-rows-spanned="2"><!-- apro la cella che contiene la tabella innestata a sx -->
                                                        <fo:block margin-left="1pt">
										
									<!-- inizio della tabella innestata a sx (nella prima riga, prima colonna) -->
                                                            <fo:table width="90%" border-right="solid 1.0pt #000000" margin-left="20pt" margin-top="0pt" margin-bottom="0pt">
                                                                <fo:table-column column-width="50%" />
                                                                <fo:table-column column-width="50%" />
                                                                <fo:table-body>
                                        <!--<fo:table-row>
                                            <fo:table-cell number-columns-spanned="2" border="solid 1.0pt #000000" text-align="center" padding="4pt">
                                                <fo:block font-size="9pt" font-weight="bold" text-align="center">
                                                    <fo:inline>LISTA DEL PERSONALE</fo:inline>
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                        <fo:table-row>
                                            <fo:table-cell border="solid 0.5pt #000000" text-align="center" padding="4pt">
                                                <fo:block font-size="8pt" font-weight="normal" text-align="center">
													COGNOME E NOME
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell border="solid 0.5pt #000000" padding="4pt" display-align="center" text-align="center">
                                                <fo:block font-size="8pt" font-weight="normal" text-align="center">
													QUALIFICA
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                        -->
                                                            
                                                                    <xsl:for-each select="DUVRI/DUVRI_04/DESCRIZIONE_SERVIZI_APP/Personale_coinvolto_app/Personale">
                                                                        <xsl:apply-templates />
                                                                    </xsl:for-each>
                                                               
                                                              </fo:table-body>
                                                            </fo:table>
									<!-- fine della tabella innestata a sx (nella prima riga, prima colonna) -->
                                                        </fo:block>
                                                    </fo:table-cell><!-- chiudo la cella che contiene la tabella innestata a sx -->
                                                    <fo:table-cell><!-- apro la cella che contiene la tabella innestata a dx -->
                                                        <fo:block >
										
									<!-- inizio della tabella innestata a dx (nella prima riga, seconda colonna) -->
                                                            <fo:table width="100%" border="solid 0.0pt #000000"   margin-top="0pt" margin-left="15pt" margin-bottom="0pt">
                                                                <fo:table-column column-width="100%" />
                                                                <fo:table-body>
                                                                  <!--  <fo:table-row>
                                                                        <fo:table-cell border="solid 1.0pt #000000" text-align="center" padding="4pt">
                                                                            <fo:block font-size="9pt" font-weight="bold" text-align="center">
													ELENCO PRODOTTI/SOSTANZE
                                                                            </fo:block>
                                                                        </fo:table-cell>
                                                                    </fo:table-row>
                                                                    -->
                                                                      
                                                                    <fo:table-row>
                                                                        <fo:table-cell text-align="right" padding="4pt" padding-left="4pt">
                                                                            <fo:block display-align="center" text-align="right" font-style="normal" font-weight="normal">
                                                                              
                                                                               <xsl:for-each select="DUVRI/DUVRI_04/DESCRIZIONE_SERVIZI_APP/ProdottiSostanze_app/ProdottiSostanze">
                                                                                     <xsl:apply-templates />
                                                                                </xsl:for-each>
                                                                            </fo:block>
                                                                        </fo:table-cell>
                                                                    </fo:table-row>
                                                                </fo:table-body>
                                                            </fo:table>
									<!-- fine della tabella innestata a dx (nella prima riga, seconda colonna) -->
									
                                                        </fo:block>
                                                    </fo:table-cell><!-- chiudo la cella che contiene la tabella innestata a dx -->
                                                </fo:table-row><!-- chiudo la riga che contiene le due tabelle -->
							
                                                <fo:table-row height="10pt">
                                                    <fo:table-cell display-align="after" border="solid 0.0pt #000000" padding-start="8pt" padding-end="8pt" padding-before="5pt" padding-after="3pt" >
                                                        <fo:block font-size="8pt" font-style="normal" font-weight="normal" text-align="justify">
                                                            <xsl:value-of select="DUVRI/DUVRI_04/DESCRIZIONE_SERVIZI_APP/PRO_SOS_DES"/>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
							
                                            </fo:table-body>
                                        </fo:table>
                                     </fo:block>
                                    </fo:flow >

                                </fo:page-sequence>
				<!-- Fine pagina verticalale -->
		
	<!-- Inizio pagina orizzontale -->
	<!-- ************************************************************  DUVRI_05 ************************************************************  -->
                                <fo:page-sequence master-reference="A4-horizontal">
                                    <fo:static-content flow-name="xsl-region-start-hor" display-align="before" margin-right="45pt">
                                        <fo:block font-family="sans-serif" font-size="9pt" text-align="justify">
                                            <fo:inline>S2S S.r.l Sistema della sicurezza</fo:inline>
                                        </fo:block>
                                    </fo:static-content>
        <!--<fo:static-content flow-name="xsl-region-start-hor">
            <fo:block display-align="after" font-family="sans-serif" font-size="8pt" text-align="right" margin-left="350pt">
					Pag.
                <fo:page-number/>
            </fo:block>
        </fo:static-content>-->
                                    <fo:static-content flow-name="xsl-region-after-hor">
                                        <fo:block display-align="after" font-family="sans-serif" font-size="8pt" text-align="right" margin-top="695pt">
					Pag.
                                            <fo:page-number/>
                                        </fo:block>
                                    </fo:static-content>
                                    <fo:static-content flow-name="xsl-region-end-hor">
                                        <fo:block border="solid 1.0pt #000000" font-family="sans-serif" font-size="12pt" font-weight="bold" font-style="normal" text-align="left" margin-right="0.03cm">
                                            <fo:block margin-left="3pt" margin-top="2pt" margin-bottom="1.0pt">
                                                <fo:inline font-size="11pt">SCHEDA A - DESCRIZIONE LAVORI/SERVIZI IMPRESA APPALTATRICE / AFFIDATARIA</fo:inline>
                                            </fo:block>
                                            <fo:block margin-left="3pt" margin-top="1.0pt" margin-bottom="2pt">
                                                <fo:inline>
                                                    <xsl:value-of select="DUVRI/DUVRI_05/ANALISI_RISCHI_APP/APPALTATRICE_05"/>
                                                </fo:inline>
                                            </fo:block>
                                        </fo:block>
                                        <fo:block border-left="solid 1.0pt #000000" border-bottom="solid 1.0pt #000000" border-right="solid 1.0pt #000000" font-size="10pt" font-weight="bold" font-style="italic" text-align="left" margin-right="0.03cm">
                                            <fo:block margin-left="2pt" margin-top="2pt" margin-bottom="2pt">
					PARTE B - ANALISI DEI RISCHI
                                            </fo:block>
                                        </fo:block>
                                    </fo:static-content>
     <!--<fo:static-content flow-name="xsl-region-before-hor">
	   <fo:block margin-left="2pt" margin-top="2pt" margin-bottom="2pt">
					PARTE B - TITOLO
                </fo:block>
        </fo:static-content>-->
                                    <fo:static-content flow-name="xsl-region-before-hor">
              
                                        <fo:block display-align="justify" margin-left="14pt" margin-top="-30pt">

								<!-- TABELLA DEI RISCHI -->
                                            <fo:table width="95%" border="solid 0.0pt #000000" font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left">
                                                <fo:table-column column-width="15%" />
                                                <fo:table-column column-width="20%" />
                                                <fo:table-column column-width="20%" />
                                                <fo:table-column column-width="15%" />
                                                <fo:table-column column-width="30%" />
                                                <fo:table-body>
                                                    <fo:table-row>
                                                        <fo:table-cell display-align="left" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                            <fo:block text-align="left">
													FASE DI LAVORO
                                                            </fo:block>
                                                        </fo:table-cell>
                                                        <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                            <fo:block>
													MODALITÀ OPERATIVE
                                                            </fo:block>
                                                        </fo:table-cell>
                                                        <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                            <fo:block>
													MATERIALI/PRODOTTI IMPIEGATI
                                                            </fo:block>
                                                        </fo:table-cell>
                                                        <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                            <fo:block>
													RISCHI
                                                            </fo:block>
                                                        </fo:table-cell>
                                                        <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                            <fo:block>
													MISURE DI PREVENZIONE E PROTEZIONE ADOTTATE
                                                            </fo:block>
                                                        </fo:table-cell>
                                                    </fo:table-row>
                                                </fo:table-body>
                                            </fo:table>

                                        </fo:block>
                          
                                    </fo:static-content>

                                    <fo:flow flow-name="xsl-region-body">
                                        <fo:table display-align="before" width="95%" border="solid 1.0pt #000000" font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left">
                                            <fo:table-column column-width="100%" />
                                            <fo:table-column column-width="0%" />
                                            <fo:table-body>
                                                <fo:table-row height="16.2cm">
                                                    <fo:table-cell number-rows-spanned="2">
                                                        <fo:block margin-bottom="40pt">
								
								<!-- TABELLA DEI RISCHI -->
                                                            <fo:table display-align="before" width="100%" border="solid 0.0pt #000000" font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left">
                               
                                                                <fo:table-column column-width="15%" />
                                                                <fo:table-column column-width="20%" />
                                                                <fo:table-column column-width="20%" />
                                                                <fo:table-column column-width="15%" />
                                                                <fo:table-column column-width="30%" />
                                                                <fo:table-body >
                                                                    <xsl:for-each select="DUVRI/DUVRI_05/ANALISI_RISCHI_APP/Analisi_rischi/Rischi">

                                                                        <xsl:apply-templates />
                                                                    </xsl:for-each>
                                                                </fo:table-body>
                              
                                                            </fo:table>
								
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell>
                                                        <fo:block ></fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <fo:table-row height="0.001cm">
                                                    <fo:table-cell>
                                                        <fo:block>
                                                            <fo:inline> </fo:inline>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                            </fo:table-body>
                                        </fo:table>
							
                                    </fo:flow>
                                </fo:page-sequence>
		<!-- Fine pagina orizzontale -->
		
	<!-- *************************************************  DUVRI_06 *********  DUVRI_07 *********************************************  -->
                                <xsl:for-each select="DUVRI/DUVRI_06/DESCRIZIONE_SERVIZI_SUB_APP/Subappaltatrici">
                                    <xsl:apply-templates />
                                </xsl:for-each>
			
	<!-- Inizio pagina orizzontale -->
	<!-- *************************************************************  DUVRI_09 ********************************************************  -->
                                <fo:page-sequence master-reference="A4-horizontal">
                                    <fo:static-content flow-name="xsl-region-start-hor" display-align="before" margin-right="45pt">
                                        <fo:block font-family="sans-serif" font-size="9pt" text-align="justify">
                                            <fo:inline font-size="9pt" font-weight="bold">NOTA 1</fo:inline>
                                            <fo:inline> - Derivanti dall'interferenza tra le attività svolte dal Committente e dall'Impresa Appaltarice (comprese eventuali Subappaltatrici).</fo:inline>
                                        </fo:block>
                                    </fo:static-content>
			
                                    <fo:static-content flow-name="xsl-region-after-hor">
                                        <fo:block display-align="after" font-family="sans-serif" font-size="8pt" text-align="right" margin-top="695pt">
					Pag.
                                            <fo:page-number/>
                                        </fo:block>
                                    </fo:static-content>
			
                                    <fo:static-content flow-name="xsl-region-end-hor">
                                        <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="12pt" font-style="normal" font-weight="bold" text-align="left">
                                            <fo:table-column column-width="100%" />
                                            <fo:table-body>
                                                <fo:table-row>
                                                    <fo:table-cell padding="4pt">
                                                        <fo:block>
                                                            <fo:inline>SCHEDA C - RISCHI CONNESSI ALL'INTERFERENZA</fo:inline>
                                                            <fo:inline font-size="7pt" font-weight="normal">  (NOTA 1)</fo:inline>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                            </fo:table-body>
                                        </fo:table>
                                    </fo:static-content>
                                    <fo:static-content flow-name="xsl-region-before-hor">

                                        <fo:block display-align="justify" margin-left="14pt" margin-top="-20pt">

								<!-- TABELLA DEI RISCHI -->
                                            <fo:table width="100%" border="solid 0.0pt #000000" font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left">
                                                <fo:table-column column-width="15%" />
                                                <fo:table-column column-width="20%" />
                                                <fo:table-column column-width="20%" />
                                                <fo:table-column column-width="15%" />
                                                <fo:table-column column-width="30%" />
                                                <fo:table-body>
                                                    <fo:table-row height="20pt">
                                                        <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                            <fo:block>
													FASE DI LAVORO
                                                            </fo:block>
                                                        </fo:table-cell>
                                                        <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                            <fo:block>
													TIPO DI INTERFERENZA
                                                            </fo:block>
                                                        </fo:table-cell>
                                                        <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                            <fo:block>
													IMPRESE INTERESSATE
                                                            </fo:block>
                                                        </fo:table-cell>
                                                        <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                            <fo:block>
													RISCHI
                                                            </fo:block>
                                                        </fo:table-cell>
                                                        <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                            <fo:block>
													MISURE DI PREVENZIONE
                                                            </fo:block>
                                                        </fo:table-cell>
                                                    </fo:table-row>
                                                </fo:table-body>
                                            </fo:table>

                                        </fo:block>

                                    </fo:static-content>
                                    <fo:flow flow-name="xsl-region-body">
                                        <fo:table display-align="before" width="100%" border="solid 1.0pt #000000" font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left">
                                            <fo:table-column column-width="100%" />
                                            <fo:table-body>
                                                <fo:table-row height="16.2cm">
                                                    <fo:table-cell number-rows-spanned="2">
                                                        <fo:block>
								
											<!-- TABELLA DEI RISCHI CONNESSI ALL'INTERFERENZA -->
                                                            <fo:table display-align="before" width="100%" border="solid 0.0pt #000000" font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left">
                                                                <fo:table-column column-width="15%" />
                                                                <fo:table-column column-width="20%" />
                                                                <fo:table-column column-width="20%" />
                                                                <fo:table-column column-width="15%" />
                                                                <fo:table-column column-width="30%" />
                                                                <fo:table-body>
                                          <!--
                                        <fo:table-row height="20pt">
                                        
                                          <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                <fo:block>
													FASE DI LAVORO
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                <fo:block>
													TIPO DI INTERFERENZA
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                <fo:block>
													IMPRESE INTERESSATE
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                <fo:block>
													RISCHI
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                <fo:block>
													MISURE DI PREVENZIONE
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                        -->
                                                                    <xsl:for-each select="DUVRI/DUVRI_09/RISCHI_CONNESSI_INTERFERENZA/Rischi_interferenza">
                                                                        <xsl:apply-templates />
                                                                    </xsl:for-each>
                                                                </fo:table-body>
                                                            </fo:table>
								
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell>
                                                        <fo:block></fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <fo:table-row height="0.001cm">
                                                    <fo:table-cell>
                                                        <fo:block>
                                                            <fo:inline> </fo:inline>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                            </fo:table-body>
                                        </fo:table>
							
                                    </fo:flow>
                                </fo:page-sequence>
		<!-- Fine pagina orizzontale -->
		
<!-- Inizio pagina verticale -->
<!-- ************************************************************  DUVRI_10 ************************************************************  -->
                                <fo:page-sequence master-reference="A4-vertical">
                                    <fo:static-content flow-name="xsl-region-after-ver" display-align="after" margin-right="15pt">
                                        <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                                            <fo:block text-align="center" padding-before="5mm" padding-after="4mm"/>

                                            <fo:inline>S2S S.r.l Sistema della sicurezza</fo:inline>
                                        </fo:block>
                                    </fo:static-content>

                                    <fo:static-content flow-name="xsl-region-end-ver">
                                        <fo:block font-family="sans-serif" font-size="8pt" text-align="right" margin-top="740pt">
						Pag.
                                            <fo:page-number/>
                                        </fo:block>
                                    </fo:static-content>
                
                                    <fo:flow flow-name="xsl-region-body">
                                        <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="12pt" font-style="normal" font-weight="bold" text-align="left">
                                            <fo:table-column column-width="100%" />
                                            <fo:table-body>
                                                <fo:table-row>
                                                    <fo:table-cell padding="4pt">
                                                        <fo:block>
										ALLEGATO 1 - MESSA A DISPOSIZIONE DEI SERVIZI SANITARI
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                            </fo:table-body>
                                        </fo:table>
                
                                        <fo:table width="100%" border-left="solid 1.5pt #000000" border-top="solid 1.5pt #000000" border-right="solid 1.5pt #000000" font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left" margin-top="10pt">
                                            <fo:table-column column-width="46%" />
                                            <fo:table-column column-width="18%" />
                                            <fo:table-column column-width="18%" />
                                            <fo:table-column column-width="18%" />
                                            <fo:table-body>
                                                <fo:table-row height="2.4cm">
                                                    <fo:table-cell number-columns-spanned="4" border="solid 1.0pt #000000" padding="5pt" text-align="justify">
                                                        <fo:block margin-top="5pt" margin-bottom="10pt">
                                                            <xsl:value-of select="DUVRI/DUVRI_10/DISPOSIZIONE_SERVIZI_SANITARI/SER_SAN_DES_1"/>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <fo:table-row>
                                                    <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
									DESIGNAZIONE DEI SERVIZI VITA
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
									DATA DI INIZIO IMPIEGO
                                                        </fo:block>
                                                    </fo:table-cell >
                                                    <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
									DATA DI FINE IMPIEGO
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
									ORARIO IMPIEGO
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <xsl:for-each select="DUVRI/DUVRI_10/DISPOSIZIONE_SERVIZI_SANITARI/Servizi_sanitari">
                                                    <xsl:apply-templates />
                                                </xsl:for-each>
                                                <fo:table-row height="4.0cm">
                                                    <fo:table-cell number-columns-spanned="4" border-top="solid 1.0pt #000000" border-bottom="solid 1.0pt #000000" padding="5pt" text-align="left">
                                                        <fo:block font-style="italic" margin-top="4pt" margin-bottom="15pt">
                                                            <fo:inline font-size="8pt" text-decoration="underline">ANNOTAZIONI</fo:inline>
                                                            <fo:inline font-size="8pt" text-decoration="no-underline"> : </fo:inline>
                                                            <fo:block font-size="9pt" padding="5pt" text-align="justify">
                                                                <xsl:value-of select="DUVRI/DUVRI_10/DISPOSIZIONE_SERVIZI_SANITARI/SER_SAN_DES_2"/>
                                                            </fo:block>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                            </fo:table-body>
                                        </fo:table>
			<!--
            <fo:table width="100%" border-left="solid 1.5pt #000000" border-bottom="solid 1.5pt #000000" border-right="solid 1.5pt #000000" font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left">
                <fo:table-column column-width="100%" />
                <fo:table-body>
                    <fo:table-row height="3.5cm">
                        <fo:table-cell padding="15pt">
                            <fo:block font-size="11pt" font-weight="bold" text-align="justify" white-space-collapse="false">
                                <xsl:value-of select="DUVRI/DUVRI_10/DISPOSIZIONE_SERVIZI_SANITARI/SER_SAN_DES_3"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>-->
                                    </fo:flow>
                                </fo:page-sequence>
            <!-- Fine pagina verticale -->
            
<!-- Inizio pagina verticale -->
<!-- ************************************************************  DUVRI_11 ************************************************************  -->
                                <fo:page-sequence master-reference="A4-vertical">
                                    <fo:static-content flow-name="xsl-region-after-ver" display-align="after">
                                        <fo:block font-family="sans-serif" font-size="9pt" text-align="justify">
                                            <fo:inline font-size="9pt" font-weight="bold">NOTA 1</fo:inline>
                                            <fo:inline> - La posizione dei </fo:inline>
                                            <fo:inline text-decoration="underline">luoghi di collegamento</fo:inline>
                                            <fo:inline> è stata indicata in sede di </fo:inline>
                                            <fo:inline font-style="italic">visita preliminare</fo:inline>
                                            <fo:inline>.</fo:inline>
                                            <fo:block text-align="center" padding-before="1mm" padding-after="4mm"/>

                                            <fo:inline>S2S S.r.l Sistema della sicurezza</fo:inline>
                                        </fo:block>
                                    </fo:static-content>
                
              

                                    <fo:static-content flow-name="xsl-region-end-ver">
                                        <fo:block font-family="sans-serif" font-size="8pt" text-align="right" margin-top="740pt">
						Pag.
                                            <fo:page-number/>
                                        </fo:block>
                                    </fo:static-content>
                
                                    <fo:flow flow-name="xsl-region-body">
                                        <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="12pt" font-style="normal" font-weight="bold" text-align="left">
                                            <fo:table-column column-width="100%" />
                                            <fo:table-body>
                                                <fo:table-row>
                                                    <fo:table-cell padding="4pt">
                                                        <fo:block>
										ALLEGATO 2 - MESSA A DISPOSIZIONE DEI FLUIDI
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                            </fo:table-body>
                                        </fo:table>

                                        <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left" margin-top="10pt">
                                            <fo:table-column column-width="32%" />
                                            <fo:table-column column-width="32%" />
                                            <fo:table-column column-width="18%" />
                                            <fo:table-column column-width="18%" />
                                            <fo:table-body>
                                                <fo:table-row height="2.4cm">
                                                    <fo:table-cell number-columns-spanned="4" border="solid 1.0pt #000000" padding="5pt" text-align="justify">
                                                        <fo:block margin-top="5pt" margin-bottom="10pt">
                                                            <xsl:value-of select="DUVRI/DUVRI_11/DISPOSIZIONE_FLUIDI/FLU_DES_1"/>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <fo:table-row>
                                                    <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
									TIPO DI FLUIDO A DISPOSIZIONE
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
									LUOGO DI COLLEGAMENTO
                                                            <fo:block font-size="7pt">
											(NOTA 1)
                                                            </fo:block>
                                                        </fo:block>
                                                    </fo:table-cell >
                                                    <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
									DATA DI INIZIO CONSUMO
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
									DATA DI FINE CONSUMO
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <xsl:for-each select="DUVRI/DUVRI_11/DISPOSIZIONE_FLUIDI/Fluidi">
                                                    <xsl:apply-templates />
                                                </xsl:for-each>
                                                <fo:table-row height="4.0cm">
                                                    <fo:table-cell number-columns-spanned="4" border-top="solid 1.0pt #000000" padding="5pt" text-align="left">
                                                        <fo:block font-style="italic" margin-top="4pt" margin-bottom="15pt">
                                                            <fo:inline font-size="8pt" text-decoration="underline">EVENTUALI OSSERVAZIONI ALL'ATTO DELLA RESTITUZIONE</fo:inline>
                                                            <fo:inline font-size="8pt" text-decoration="no-underline"> : </fo:inline>
                                                            <fo:block font-size="9pt" padding="5pt" text-align="justify">
                                                                <xsl:value-of select="DUVRI/DUVRI_11/DISPOSIZIONE_FLUIDI/FLU_DES_2"/>
                                                            </fo:block>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                            </fo:table-body>
                                        </fo:table>
        <!--
            <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left" margin-top="10pt">
                <fo:table-column column-width="50%" />
                <fo:table-column column-width="50%" />
                <fo:table-body>
                    <fo:table-row height="15pt">
                        <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="10pt" font-weight="bold" text-align="center" padding="4pt">
                            <fo:block>
									PER IL COMMITTENTE
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="10pt" font-weight="bold" text-align="center" padding="4pt">
                            <fo:block>
									PER L'IMPRESA APPALTATRICE
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row height="35">
                        <fo:table-cell border="solid 1.0pt #000000" font-size="8pt" font-style="italic" font-weight="normal" padding="4pt">
                            <fo:block>
									NOME E COGNOME:
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid 1.0pt #000000" font-size="8pt" font-style="italic" font-weight="normal" padding="4pt">
                            <fo:block>
									NOME E COGNOME:
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row height="35">
                        <fo:table-cell border="solid 1.0pt #000000" font-size="8pt" font-style="italic" font-weight="normal" padding="4pt">
                            <fo:block>
									QUALIFICA:
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid 1.0pt #000000" font-size="8pt" font-style="italic" font-weight="normal" padding="4pt">
                            <fo:block>
									QUALIFICA:
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row height="35">
                        <fo:table-cell border="solid 1.0pt #000000" font-size="8pt" font-style="italic" font-weight="normal" padding="4pt">
                            <fo:block>
									FIRMA:
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid 1.0pt #000000" font-size="8pt" font-style="italic" font-weight="normal" padding="4pt">
                            <fo:block>
									FIRMA:
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>-->
                                    </fo:flow>
                                </fo:page-sequence>
            <!-- Fine pagina verticale -->
		
<!-- Inizio pagina verticale -->
<!-- ************************************************************  DUVRI_12 ************************************************************  -->
                                <fo:page-sequence master-reference="A4-vertical">
                                    <fo:static-content flow-name="xsl-region-after-ver" display-align="after" margin-right="45pt">
                                        <fo:block font-family="sans-serif" font-size="9pt" text-align="justify">
                                            <fo:inline font-size="9pt" font-weight="bold">NOTA 1</fo:inline>
                                            <fo:inline> - La posizione dei </fo:inline>
                                            <fo:inline text-decoration="underline">luoghi di messa a disposizione</fo:inline>
                                            <fo:inline> è stata indicata in sede di </fo:inline>
                                            <fo:inline font-style="italic">visita preliminare</fo:inline>
                                            <fo:inline>.</fo:inline>
                                            <fo:block text-align="center" padding-before="1mm" padding-after="4mm"/>

                                            <fo:inline>S2S S.r.l Sistema della sicurezza</fo:inline>
                                        </fo:block>
                                    </fo:static-content>



                                    <fo:static-content flow-name="xsl-region-end-ver">
                                        <fo:block font-family="sans-serif" font-size="8pt" text-align="right" margin-top="740pt">
						Pag.
                                            <fo:page-number/>
                                        </fo:block>
                                    </fo:static-content>
                
                                    <fo:flow flow-name="xsl-region-body">
                                        <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="12pt" font-style="normal" font-weight="bold" text-align="left">
                                            <fo:table-column column-width="100%" />
                                            <fo:table-body>
                                                <fo:table-row>
                                                    <fo:table-cell padding="4pt">
                                                        <fo:block>
										ALLEGATO 3 - PRESTITO MATERIALI
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                            </fo:table-body>
                                        </fo:table>
				
                                        <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left" margin-top="10pt">
                                            <fo:table-column column-width="30%" />
                                            <fo:table-column column-width="20%" />
                                            <fo:table-column column-width="14%" />
                                            <fo:table-column column-width="18%" />
                                            <fo:table-column column-width="18%" />
                                            <fo:table-body>
                                                <fo:table-row height="2.4cm">
                                                    <fo:table-cell number-columns-spanned="5" border="solid 1.0pt #000000" padding="5pt" text-align="justify">
                                                        <fo:block margin-top="5pt" margin-bottom="10pt">
                                                            <xsl:value-of select="DUVRI/DUVRI_12/PRESTITO_MATERIALI/PRE_MAT_DES_1"/>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <fo:table-row>
                                                    <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
											TIPO DI MATERIALE
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell display-align="center" number-columns-spanned="2" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
											LUOGO DI MESSA A DISPOSIZIONE
                                                            <fo:block font-size="7pt">
													(NOTA 1)
                                                            </fo:block>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
											DATA DI INIZIO PRESTITO
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
											DATA DI FINE PRESTITO
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <xsl:for-each select="DUVRI/DUVRI_12/PRESTITO_MATERIALI/Materiali">
                                                    <xsl:apply-templates />
                                                </xsl:for-each>
                                                <fo:table-row>
                                                    <fo:table-cell number-columns-spanned="2" border="solid 1.0pt #000000" font-size="8pt" padding="4pt" font-weight="bold" text-align="center">
                                                        <fo:block margin-top="4pt" margin-bottom="2pt">
											ASSEGNAZIONE APPARATO RADIO
                                                            <fo:block font-size="10pt" font-weight="normal" margin-top="2pt" margin-bottom="4pt">
                                                                <xsl:value-of select="DUVRI/DUVRI_12/PRESTITO_MATERIALI/PRE_MAT_ASS_APP_RAD"/>
                                                            </fo:block>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell number-columns-spanned="3" border="solid 1.0pt #000000" font-size="8pt" padding="4pt" font-weight="bold" text-align="center">
                                                        <fo:block margin-top="4pt" margin-bottom="2pt">
											ASSEGNAZIONE TELEFONO CELLULARE
                                                            <fo:block font-size="10pt" font-weight="normal" margin-top="2pt" margin-bottom="4pt">
                                                                <xsl:value-of select="DUVRI/DUVRI_12/PRESTITO_MATERIALI/PRE_MAT_ASS_TEL_CEL"/>
                                                            </fo:block>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <fo:table-row height="4.0cm">
                                                    <fo:table-cell number-columns-spanned="5" padding="5pt" text-align="left">
                                                        <fo:block font-style="italic" margin-top="4pt" margin-bottom="15pt">
                                                            <fo:inline font-size="8pt" text-decoration="underline">EVENTUALI OSSERVAZIONI ALL'ATTO DELLA RESTITUZIONE</fo:inline>
                                                            <fo:inline font-size="8pt" text-decoration="no-underline"> : </fo:inline>
                                                            <fo:block font-size="9pt" padding="5pt" text-align="justify">
                                                                <xsl:value-of select="DUVRI/DUVRI_12/PRESTITO_MATERIALI/PRE_MAT_DES_2"/>
                                                            </fo:block>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                            </fo:table-body>
                                        </fo:table>
           <!-- <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left" margin-top="10pt">
                <fo:table-column column-width="50%" />
                <fo:table-column column-width="50%" />
                <fo:table-body>
                    <fo:table-row height="15pt">
                        <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="10pt" font-weight="bold" text-align="center" padding="4pt">
                            <fo:block>
											PER IL COMMITTENTE
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="10pt" font-weight="bold" text-align="center" padding="4pt">
                            <fo:block>
											PER L'IMPRESA APPALTATRICE
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row height="35">
                        <fo:table-cell border="solid 1.0pt #000000" font-size="8pt" font-style="italic" font-weight="normal" padding="4pt">
                            <fo:block>
											NOME E COGNOME:
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid 1.0pt #000000" font-size="8pt" font-style="italic" font-weight="normal" padding="4pt">
                            <fo:block>
											NOME E COGNOME:
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row height="35">
                        <fo:table-cell border="solid 1.0pt #000000" font-size="8pt" font-style="italic" font-weight="normal" padding="4pt">
                            <fo:block>
											QUALIFICA:
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid 1.0pt #000000" font-size="8pt" font-style="italic" font-weight="normal" padding="4pt">
                            <fo:block>
											QUALIFICA:
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row height="35">
                        <fo:table-cell border="solid 1.0pt #000000" font-size="8pt" font-style="italic" font-weight="normal" padding="4pt">
                            <fo:block>
											FIRMA:
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid 1.0pt #000000" font-size="8pt" font-style="italic" font-weight="normal" padding="4pt">
                            <fo:block>
											FIRMA:
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>-->
                                    </fo:flow>
                                </fo:page-sequence>
            <!-- Fine pagina verticale -->

<!-- Inizio pagina verticale -->
<!-- ************************************************************  DUVRI_13 ************************************************************  -->
                                <fo:page-sequence master-reference="A4-vertical">
                                    <fo:static-content flow-name="xsl-region-after-ver" display-align="after" margin-right="15pt">
                                        <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                                            <fo:block text-align="center" padding-before="5mm" padding-after="4mm"/>

                                            <fo:inline>S2S S.r.l Sistema della sicurezza</fo:inline>
                                        </fo:block>
                                    </fo:static-content>

                                    <fo:static-content flow-name="xsl-region-end-ver">
                                        <fo:block font-family="sans-serif" font-size="8pt" text-align="right" margin-top="740pt">
						Pag.
                                            <fo:page-number/>
                                        </fo:block>
                                    </fo:static-content>
                
                                    <fo:flow flow-name="xsl-region-body">
                                        <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="12pt" font-style="normal" font-weight="bold" text-align="left">
                                            <fo:table-column column-width="100%" />
                                            <fo:table-body>
                                                <fo:table-row>
                                                    <fo:table-cell padding="4pt">
                                                        <fo:block>
									ACCORDO TRA LE DIVERSE PARTI
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                            </fo:table-body>
                                        </fo:table>
                                        <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="8pt" font-style="italic" font-weight="normal" text-align="left" margin-top="10pt">
                                            <fo:table-column column-width="40%" />
                                            <fo:table-column column-width="26%" />
                                            <fo:table-column column-width="34%" />
                                            <fo:table-body>
                                                <fo:table-row height="70pt">
                                                    <fo:table-cell border="solid 1pt #000000" padding="4pt">
                                                        <fo:block >
											COMMITTENTE:
                                                            <fo:block font-size="10pt" font-style="normal" font-weight="bold" padding="15pt">
                                                                <xsl:value-of select="DUVRI/DUVRI_13/ACCORDO_TRA_PARTI/RAG_SCL_AZL"/>
                                                            </fo:block>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell border="solid 1pt #000000" padding="4pt">
                                                        <fo:block >
											LUOGO E DATA:
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell border="solid 1pt #000000" padding="4pt">
                                                        <fo:block>
											FIRMA E TIMBRO:
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <fo:table-row height="70pt">
                                                    <fo:table-cell border="solid 1pt #000000" padding="4pt">
                                                        <fo:block>
											APPALTATRICE:
                                                            <fo:block font-size="10pt" font-style="normal" font-weight="bold" padding="15pt">
                                                                <xsl:value-of select="DUVRI/DUVRI_13/ACCORDO_TRA_PARTI/RAG_SCL_DTE_app"/>
                                                            </fo:block>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell border="solid 1pt #000000" padding="4pt">
                                                        <fo:block>
											LUOGO E DATA:
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell border="solid 1pt #000000" padding="4pt">
                                                        <fo:block>
											FIRMA E TIMBRO:
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <xsl:for-each select="DUVRI/DUVRI_13/ACCORDO_TRA_PARTI/Subappaltatrici">
                                                    <xsl:apply-templates />
                                                </xsl:for-each>
                                            </fo:table-body>
                                        </fo:table>
                                        <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left">
                                            <fo:table-column column-width="100%" />
                                            <fo:table-body>
                                                <fo:table-row>
                                                    <fo:table-cell padding="4pt">
                                                        <fo:block font-size="11pt" font-weight="bold" padding="10pt" text-align="justify">
											Tutti i firmatari si impegnano ad informare i propri lavoratori del contenuto del presente DOCUMENTO UNICO DI VALUTAZIONE DEI RISCHI DA INTERFERENZA e di ogni misura di sicurezza adottata per eliminare le interferenze tra le attività durante lo svolgimento dei lavori.
                                                        </fo:block>
                                                        <fo:block font-size="11pt" font-weight="bold" padding="10pt">
                                                            <fo:inline text-decoration="underline">DESTINATARI DEL DOCUMENTO</fo:inline>
                                                            <fo:inline text-decoration="no-underline"> : </fo:inline>
                                                            <fo:block font-size="10pt" font-weight="normal" padding="3pt">
                                                                <fo:inline>    -  </fo:inline>
                                                                <fo:inline>
                                                                    <xsl:value-of select="DUVRI/DUVRI_13/ACCORDO_TRA_PARTI/RAG_SCL_AZL_nota"/>
                                                                </fo:inline>
                                                            </fo:block>
                                                            <fo:block font-size="10pt" font-weight="normal" padding="3pt">
                                                                <fo:inline>    -  </fo:inline>
                                                                <fo:inline>
                                                                    <xsl:value-of select="DUVRI/DUVRI_13/ACCORDO_TRA_PARTI/RAG_SCL_DTE_app_nota"/>
                                                                </fo:inline>
                                                            </fo:block>
                                                            <xsl:for-each select="DUVRI/DUVRI_13/ACCORDO_TRA_PARTI/Subappaltatrici_nota">
                                                                <xsl:apply-templates />
                                                            </xsl:for-each>
                                                        </fo:block>
                                                        <fo:block font-size="11pt" font-weight="bold" padding="10pt">
                                                            <fo:inline text-decoration="underline">MESSO A DISPOSIZIONE</fo:inline>
                                                            <fo:inline text-decoration="no-underline"> : </fo:inline>
                                                            <fo:inline  font-size="10pt" font-weight="normal" text-decoration="no-underline" text-align="justify">Ispettorati Provinciali del Lavoro, Dipartimenti ASL Uffici Pre.S.A.L., S.P.P. Servizio Prevenzione e Protezione dai rischi del Committente e delle Imprese intervenenti, R.L.S. Rappresentanti dei Lavoratori per la Sicurezza.</fo:inline>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                            </fo:table-body>
                                        </fo:table>
                                    </fo:flow>
                                </fo:page-sequence>
            <!-- Fine pagina verticale -->
		
                            </fo:root>
                        </xsl:template>

<!-- *********************************************************************************************************************************************  -->
<!-- ********************************************  DEFINIZIONE DELLE REGOLE (templates)  ********************************************  -->
<!-- *********************************************************************************************************************************************  -->
<!-- DUVRI_01 -->
                        <xsl:template match="DUVRI/DUVRI_01/COMMITTENTE/Contatti_fissi/Numeri_telefono/Numero_telefono">
                            <fo:block font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left" padding-before="3pt">
                                <xsl:value-of select="NUM_TEL"/>
                            </fo:block>
                        </xsl:template>
    
                        <xsl:template match="DUVRI/DUVRI_01/COMMITTENTE/Contatti_mobili/Numeri_cellulare/Numero_cellulare">
                            <fo:block font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left" padding-before="3pt">
                                <xsl:value-of select="CELLULARE"/>
                            </fo:block>
                        </xsl:template>
    
                        <xsl:template match="DUVRI/DUVRI_01/COMMITTENTE/Contatti_fax/Numeri_fax/Numero_fax">
                            <fo:block font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left" padding-before="3pt">
                                <xsl:value-of select="FAX"/>
                            </fo:block>
                        </xsl:template>

<!-- Tabella "Luoghi di esecuzione - Descrizione ; Appaltatrice" -->
                        <xsl:template match="DUVRI/DUVRI_01/APPALTATRICE/Luoghi_esecuzione/Luoghi_fisici/Luogo_fisico">
                            <fo:table-row>
                                <fo:table-cell border="solid 0.25pt #000000" font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="NOM_LUO_FSC"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="DES_SER"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:template>

<!-- DUVRI_02 -->
<!-- Tabella "Ispezione comune dei luoghi di lavoro (Visita preliminare)" -->
                        <xsl:template match="DUVRI/DUVRI_02/ALLEGATI_ISPEZIONI/Ispezioni/Ispezione">
                            <fo:block font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left" margin-left="10pt" margin-top="5pt" padding-after="3pt">
                                <xsl:value-of select="FILE_NAME"/>
                            </fo:block>
                        </xsl:template>

<!-- Tabella "Referenti in loco ; Committente" -->
                        <xsl:template match="DUVRI/DUVRI_02/RESPONSABILI_CMT/Referenti_loco_cmt/Referenti/Referente">
                            <fo:table-row height="15pt">
                                <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block font-size="10pt" font-style="normal" font-weight="normal" margin-top="4pt" margin-bottom="4pt">
                                        <fo:inline>
                                            <xsl:value-of select="COG_DPD_REF_CMT"/>
                                        </fo:inline>
                                        <fo:inline> </fo:inline>
                                        <fo:inline padding-left="5pt">
                                            <xsl:value-of select="NOM_DPD_REF_CMT"/>
                                        </fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block font-size="10pt" font-style="normal" font-weight="normal" margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="NOM_FUZ_AZL_REF_CMT"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block font-size="10pt" font-style="normal" font-weight="normal" margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="TEL_REF_CMT"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:template>

<!-- Tabella "Referenti in loco ; Appaltatrice" -->
                        <xsl:template match="DUVRI/DUVRI_02/RESPONSABILI_APP/Referenti_loco_app/Referenti/Referente">
                            <fo:table-row height="15pt">
                                <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block font-size="10pt" font-style="normal" font-weight="normal" margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="NOM"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block font-size="10pt" font-style="normal" font-weight="normal" margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="QUA"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block font-size="10pt" font-style="normal" font-weight="normal" margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="TEL"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:template>

<!-- DUVRI_03 -->
<!-- Tabella "Imprese subappaltatrici" -->
                        <xsl:template match="DUVRI/DUVRI_03/SUBAPPALTATRICI/Imprese_subappaltatrici/Imprese/Impresa">
                            <fo:table-row height="15pt">
                                <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block font-size="10pt" font-style="normal" font-weight="normal" text-align="center" margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="SUB_APP_num"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block font-size="10pt" font-style="normal" font-weight="normal" margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="RAG_SCL_DTE"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block font-size="10pt" font-style="normal" font-weight="normal" margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="INT_ASS_DES"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:template>

<!-- Tabella "CENTRI INFORMATIVI COMMITTENTE" -->
                        <xsl:template match="DUVRI/DUVRI_03/CENTRI_INFORMATIVI_CMT/Centri_informativi/Centri_emergenza/Centro_emergenza">
                            <fo:table-row height="7pt">
        
                                <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt" display-align="center">
                                    <fo:block font-size="8pt" font-style="normal" font-weight="normal" margin-top="3pt" margin-bottom="3pt">
                                        <xsl:value-of select="DES"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" number-columns-spanned="2" padding="4pt" display-align="center">
            <!--
            <fo:block font-size="10pt" font-style="normal" font-weight="normal" margin-top="4pt" margin-bottom="4pt">
		-->
        <!--xsl:value-of select="RAG_SCL_DTE"/-->
            
                                    <fo:block font-size="10pt" font-style="normal" font-weight="normal" margin-top="3pt" margin-bottom="3pt">
                                        <xsl:value-of select="RIF"/>
                                    </fo:block>

                                </fo:table-cell>
       <!-- <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt" display-align="center">
            <fo:block font-size="10pt" font-style="normal" font-weight="normal" margin-top="4pt" margin-bottom="4pt">
		
            </fo:block>
        </fo:table-cell>
        -->
                            </fo:table-row>
                        </xsl:template>

<!-- DUVRI_04 -->
<!-- Tabella "LISTA DEL PERSONALE" -->
                        <xsl:template match="DUVRI/DUVRI_04/DESCRIZIONE_SERVIZI_APP/Personale_coinvolto_app/Personale/Persona">
                            <fo:table-row height="15pt">
                                <fo:table-cell border="solid 0.25pt #000000" text-align="left" padding="4pt">
                                    <fo:block font-size="12pt" font-style="normal" font-weight="normal" margin-top="4pt" margin-bottom="4pt">
                                        <fo:inline font-size="10pt">
                                            <xsl:value-of select="NOM_num"/>
                                        </fo:inline>
                                        <fo:inline padding-left="5pt">
                                            <xsl:value-of select="NOM"/>
                                        </fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" text-align="left" padding="4pt">
                                    <fo:block font-size="12pt" font-style="normal" font-weight="normal" margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="QUA"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:template>

<!-- Tabella "ELENCO PRODOTTI/SOSTANZE" -->
                        <xsl:template match="DUVRI/DUVRI_04/DESCRIZIONE_SERVIZI_APP/ProdottiSostanze_app/ProdottiSostanze/ProdottoSostanza">
                            <fo:block font-family="sans-serif" font-size="11pt" font-style="normal" font-weight="normal" text-align="left" padding-before="4pt" padding-after="4pt">
                                <fo:inline>
                                    <xsl:value-of select="DES"/>
                                </fo:inline>
                            </fo:block>
                        </xsl:template>

<!-- DUVRI_05 -->
<!-- Tabella "ANALISI DEI RISCHI APPALTATRICE" -->
                        <xsl:template match="DUVRI/DUVRI_05/ANALISI_RISCHI_APP/Analisi_rischi/Rischi/Rischio">
                            <fo:table-row height="20pt">
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="FAS_LAV"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="MOD_OPE"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="MAT_PRO_IMP"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="RIS"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="MIS_PRE_PRO"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:template>

<!-- *************************************************************************************************************************************************** -->
<!-- DUVRI_06 -->
<!-- Tabella "DESCRIZIONE LAVORI/SERVIZI IMPRESA SUBAPPALTATRICE" -->
                        <xsl:template match="DUVRI/DUVRI_06/DESCRIZIONE_SERVIZI_SUB_APP/Subappaltatrici/Subappaltatrice">
    <!--/xsl:template-->
                            <fo:page-sequence master-reference="A4-vertical-notes">
		
                                <fo:static-content flow-name="xsl-region-end-ver">
                                    <fo:block font-family="sans-serif" font-size="8pt" text-align="right" margin-top="740pt">
					Pag.
                                        <fo:page-number/>
                                    </fo:block>
                                </fo:static-content>
                
                                <fo:static-content flow-name="xsl-region-after-ver" display-align="after" margin-right="15pt">
                                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                                        <fo:inline font-weight="bold" text-decoration="no-underline">NOTE GENERALI</fo:inline>
                                    </fo:block>
                                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                                        <fo:inline> - Ogni nuovo elemento relativo alla natura del presente documento, seppure emerso durante i lavori, dovrà essere segnalato al responsabile del Committente in tempi brevi.</fo:inline>
                                    </fo:block>
                                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                                        <fo:inline> - Si ritiene che il materiale introdotto dall'impresa appaltatrice/affidataria durante l'esercizio sia in buono stato, conforme alle normative vigenti e sotto la responsabilità dell'impresa stessa.</fo:inline>
                                    </fo:block>
                                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                                        <fo:inline font-weight="bold" text-decoration="no-underline">NOTA 1</fo:inline>
                                        <fo:inline> - Compilare una scheda per ogni Impresa Subappaltatrice.</fo:inline>
                                    </fo:block>
                                </fo:static-content>
                
                                <fo:flow flow-name="xsl-region-body">
                                    <fo:table width="100%" border="solid 1.5pt #000000" font-family="sans-serif" font-size="12pt" font-style="normal" font-weight="normal" text-align="left">
                                        <fo:table-column column-width="0%" />
                                        <fo:table-column column-width="33%" />
                                        <fo:table-column column-width="10%" />
                                        <fo:table-column column-width="23%" />
                                        <fo:table-column column-width="34%" />
                                        <fo:table-column column-width="0%" />
                                        <fo:table-body>
                                            <fo:table-row>
                                                <fo:table-cell number-columns-spanned="6" border="solid 1.5pt #000000" font-weight="bold" padding="4pt">
                                                    <fo:block>
                                                        <fo:inline font-size="11pt">SCHEDA B - DESCRIZIONE LAVORI/SERVIZI IMPRESA SUBAPPALTATRICE / ESECUTRICE</fo:inline>
                                                        <fo:inline font-size="11pt" padding-left="5pt">
                                                            <xsl:value-of select="SUB_APP_num"/>
                                                        </fo:inline>
                                                        <fo:inline font-size="7pt" padding-left="3pt" font-weight="normal">(NOTA 1)</fo:inline>
                                                    </fo:block>
                                                    <fo:block padding-before="4pt">
                                                        <fo:inline font-size="12pt" font-style="normal" font-weight="bold">
                                                            <xsl:value-of select="SUBAPPALTATRICE_06"/>
                                                        </fo:inline>
                                                    </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                            <fo:table-row>
                                                <fo:table-cell number-columns-spanned="6" border="solid 1.5pt #000000" font-size="10pt" font-style="italic" font-weight="bold" padding="3pt">
                                                    <fo:block>
								PARTE A - ANAGRAFICA IMPRESA
                                                    </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
					
                                            <fo:table-row height="12pt">
                                                <fo:table-cell number-rows-spanned="5" number-columns-spanned="3" border="solid 0.25pt #000000" font-style="normal" padding="4pt">
                                                    <fo:block font-size="9pt">
                                                        <fo:inline font-style="italic">NOME O TIMBRO DELL'IMPRESA</fo:inline>
                                                        <fo:inline> :</fo:inline>
                                                        <fo:block font-size="12pt" font-style="normal" padding-before="4pt">
                                                            <xsl:value-of select="RAG_SCL_DTE"/>
                                                        </fo:block>
                                                    </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell number-columns-spanned="3" border="solid 0.25pt #000000" font-style="normal" padding="5pt">
                                                    <fo:block font-size="9pt">
                                                        <fo:inline font-style="italic">TELEFONO</fo:inline>
                                                        <fo:inline> :</fo:inline>
                                                        <fo:inline font-size="12pt" font-style="normal" padding-left="8pt">
                                                            <xsl:value-of select="TEL"/>
                                                        </fo:inline>
                                                    </fo:block>
                                                    <fo:block font-size="9pt" padding-before="5pt">
                                                        <fo:inline font-style="italic">FAX</fo:inline>
                                                        <fo:inline> :</fo:inline>
                                                        <fo:inline font-size="12pt" font-style="normal" padding-left="8pt">
                                                            <xsl:value-of select="FAX"/>
                                                        </fo:inline>
                                                    </fo:block>
                                                    <fo:block font-size="9pt" padding-before="5pt">
                                                        <fo:inline font-style="italic">EMAIL</fo:inline>
                                                        <fo:inline> :</fo:inline>
                                                        <fo:inline font-size="12pt" font-style="normal" padding-left="8pt">
                                                            <xsl:value-of select="EMAIL"/>
                                                        </fo:inline>
                                                    </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                            <fo:table-row>
                                                <fo:table-cell number-columns-spanned="3" border="solid 0.25pt #000000" font-style="normal" padding="4pt">
                                                    <fo:block font-size="9pt">
                                                        <fo:inline font-style="italic">COGNOME E NOME DEL RESPONSABILE IN LOCO</fo:inline>
                                                        <fo:inline> :</fo:inline>
                                                        <fo:block font-size="12pt" font-style="normal" padding-before="4pt">
                                                            <xsl:value-of select="RES_LOC_NOM"/>
                                                        </fo:block>
                                                    </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                            <fo:table-row height="12pt">
                                                <fo:table-cell number-columns-spanned="3" border="solid 0.25pt #000000" font-style="normal" padding="4pt">
                                                    <fo:block font-size="9pt">
                                                        <fo:inline font-style="italic" font-weight="normal">QUALIFICA DEL RESPONSABILE IN LOCO</fo:inline>
                                                        <fo:inline> :</fo:inline>
                                                        <fo:block font-size="12pt" font-style="normal" padding-before="4pt">
                                                            <xsl:value-of select="RES_LOC_QUA"/>
                                                        </fo:block>
                                                    </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                            <fo:table-row height="12pt">
                                                <fo:table-cell number-columns-spanned="3" border="solid 0.25pt #000000" font-style="normal" padding="5pt">
                                                    <fo:block font-size="9pt">
                                                        <fo:inline font-style="italic" font-weight="normal">NUMERO TELEFONICO DEL RESPONSABILE IN LOCO</fo:inline>
                                                        <fo:inline> :</fo:inline>
                                                        <fo:block font-size="12pt" font-style="normal" padding-before="4pt">
                                                            <xsl:value-of select="RES_LOC_TEL"/>
                                                        </fo:block>
                                                    </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                            <fo:table-row height="30pt">
                                                <fo:table-cell border="solid 0.25pt #000000" font-style="normal" padding="4pt">
                                                    <fo:block font-size="10pt" font-style="italic">
                                                        <fo:inline font-style="italic" font-weight="normal">DATA</fo:inline>
                                                        <fo:inline> :</fo:inline>
                                                    </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" font-style="normal" padding="4pt">
                                                    <fo:block font-size="10pt" font-style="italic">
                                                        <fo:inline font-style="italic" font-weight="normal">FIRMA</fo:inline>
                                                        <fo:inline> :</fo:inline>
                                                    </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                            <fo:table-row height="90pt">
                                                <fo:table-cell number-columns-spanned="6" border="solid 0.25pt #000000" font-style="normal" padding="4pt">
                                                    <fo:block font-size="9pt" font-style="italic">
                                                        <fo:inline>DESCRIZIONE SINTETICA DELL'INTERVENTO</fo:inline>
                                                        <fo:inline> :</fo:inline>
                                                        <fo:block font-size="12pt" font-style="normal" padding-before="4pt">
                                                            <xsl:value-of select="INT_ASS_DES"/>
                                                        </fo:block>
                                                    </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
					
                                            <fo:table-row height="20pt">
                                                <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" font-style="normal" padding="4pt">
                                                    <fo:block font-size="9pt" font-style="italic">
                                                        <fo:inline>DATA DI INIZIO INTERVENTO</fo:inline>
                                                        <fo:inline> :</fo:inline>
                                                        <fo:block font-size="12pt" font-style="normal" padding-before="4pt">
                                                            <xsl:value-of select="DAT_INI_LAV"/>
                                                        </fo:block>
                                                    </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" font-style="normal" padding="4pt">
                                                    <fo:block font-size="9pt" font-style="italic">
                                                        <fo:inline>DATA DI FINE INTERVENTO</fo:inline>
                                                        <fo:inline> :</fo:inline>
                                                        <fo:block font-size="12pt" font-style="normal" padding-before="4pt">
                                                            <xsl:value-of select="DAT_FIN_LAV"/>
                                                        </fo:block>
                                                    </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" font-style="normal" padding="4pt">
                                                    <fo:block font-size="9pt" font-style="italic">
                                                        <fo:inline>LAVORO NOTTURNO</fo:inline>
                                                        <fo:inline> :</fo:inline>
                                                        <fo:block font-size="12pt" font-style="normal" padding-before="4pt">
                                                            <xsl:value-of select="LAV_NOT"/>
                                                        </fo:block>
                                                    </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                            <fo:table-row height="25pt">
                                                <fo:table-cell number-columns-spanned="3" border="solid 0.25pt #000000" font-style="normal" padding="4pt">
                                                    <fo:block font-size="9pt" font-style="italic">
                                                        <fo:inline>ORARIO DI LAVORO</fo:inline>
                                                        <fo:inline> :</fo:inline>
                                                        <fo:block font-size="12pt" font-style="normal" padding-before="4pt">
                                                            <xsl:value-of select="ORA_LAV"/>
                                                        </fo:block>
                                                    </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell number-columns-spanned="3" border="solid 0.25pt #000000" font-style="normal" padding="4pt">
                                                    <fo:block font-size="9pt" font-style="italic">
                                                        <fo:inline>TIPO DI CONSEGNA</fo:inline>
                                                        <fo:inline> :</fo:inline>
                                                        <fo:block font-size="12pt" font-style="normal" padding-before="4pt">
                                                            <fo:inline>
                                                                <xsl:value-of select="COD_CON"/>
                                                            </fo:inline>
                                                            <fo:inline padding-left="8pt">
                                                                <xsl:value-of select="CON_DES"/>
                                                            </fo:inline>
                                                        </fo:block>
                                                    </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                        </fo:table-body>
                                    </fo:table>
		   <!--       </fo:table-body>
                                    </fo:table>
                                    -->
                                </fo:flow >
                            </fo:page-sequence>

					<!-- porzione di codice relativo alla tabella "Lista del personale" e "Elenco prodotti/sostanze" -->
					<!-- inizio della tabella esterna (che le conterrà entrambe) -->
                   <!--
                   <fo:page-sequence master-reference="A4-vertical-notes">
		
                                <fo:static-content flow-name="xsl-region-end-ver">
                                    <fo:block font-family="sans-serif" font-size="8pt" text-align="right" margin-top="740pt">
					Pag.
                                        <fo:page-number/>
                                    </fo:block>
                                </fo:static-content>
                
                                <fo:static-content flow-name="xsl-region-after-ver" display-align="after" margin-right="15pt">
                                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                                        <fo:inline font-weight="bold" text-decoration="no-underline">NOTE GENERALI</fo:inline>
                                    </fo:block>
                                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                                        <fo:inline> - Ogni nuovo elemento relativo alla natura del presente documento, seppure emerso durante i lavori, dovrà essere segnalato al responsabile del Committente in tempi brevi.</fo:inline>
                                    </fo:block>
                                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                                        <fo:inline> - Si ritiene che il materiale introdotto dall'impresa appaltatrice/affidataria durante l'esercizio sia in buono stato, conforme alle normative vigenti e sotto la responsabilità dell'impresa stessa.</fo:inline>
                                    </fo:block>
                                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                                        <fo:inline font-weight="bold" text-decoration="no-underline">NOTA 1</fo:inline>
                                        <fo:inline> - Compilare una scheda per ogni Impresa Subappaltatrice.</fo:inline>
                                    </fo:block>
                                </fo:static-content>
                
                                <fo:flow flow-name="xsl-region-body">
                            <fo:table width="100%" border-left="solid 1.5pt #000000" border-bottom="solid 1.5pt #000000" border-right="solid 1.5pt #000000" margin-top="0pt" margin-bottom="0pt">
                                        <fo:table-column column-width="60%" />
                                        <fo:table-column column-width="40%" />
                                        <fo:table-body>
                                            <fo:table-row>
                                                <fo:table-cell number-rows-spanned="2">
                                                    <fo:block>
									
							                             <fo:table width="100%" border-right="solid 1.0pt #000000" margin-top="0pt" margin-bottom="0pt">
                                                            <fo:table-column column-width="50%" />
                                                            <fo:table-column column-width="50%" />
                                                            <fo:table-body>
                                                                <fo:table-row>
                                                                    <fo:table-cell number-columns-spanned="2" border="solid 1.0pt #000000" text-align="center" padding="4pt">
                                                                        <fo:block font-size="9pt" font-weight="bold" text-align="center">
                                                                            <fo:inline>LISTA DEL PERSONALE</fo:inline>
                                                                        </fo:block>
                                                                    </fo:table-cell>
                                                                </fo:table-row>
                                                                <fo:table-row>
                                                                    <fo:table-cell border="solid 0.5pt #000000" text-align="center" padding="4pt">
                                                                        <fo:block font-size="8pt" font-weight="normal" text-align="center">
												COGNOME E NOME
                                                                        </fo:block>
                                                                    </fo:table-cell>
                                                                    <fo:table-cell border="solid 0.5pt #000000" padding="4pt" display-align="center" text-align="center">
                                                                        <fo:block font-size="8pt" font-weight="normal" text-align="center">
												QUALIFICA
                                                                        </fo:block>
                                                                    </fo:table-cell>
                                                                </fo:table-row>
                                                                <xsl:for-each select="Personale_coinvolto_sub_app/Personale">
                                                                    <xsl:apply-templates />
                                                                </xsl:for-each>
                                                            </fo:table-body>
                                                        </fo:table>
							                       </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell>
                                                <fo:block>
									
							                           <fo:table width="100%" border="solid 0.0pt #000000" margin-top="0pt" margin-bottom="0pt">
                                                            <fo:table-column column-width="100%" />
                                                            <fo:table-body>
                                                                <fo:table-row>
                                                                    <fo:table-cell border="solid 1.0pt #000000" text-align="center" padding="4pt">
                                                                        <fo:block font-size="9pt" font-weight="bold" text-align="center">
												ELENCO PRODOTTI/SOSTANZE
                                                                        </fo:block>
                                                                    </fo:table-cell>
                                                                </fo:table-row>
                                                                <fo:table-row>
                                                                    <fo:table-cell text-align="left" padding="4pt" padding-left="4pt">
                                                                        <fo:block font-style="normal" font-weight="normal">
                                                                            <xsl:for-each select="ProdottiSostanze_sub_app/ProdottiSostanze">
                                                                                <xsl:apply-templates />
                                                                            </xsl:for-each>
                                                                        </fo:block>
                                                                    </fo:table-cell>
                                                                </fo:table-row>
                                                            </fo:table-body>
                                                        </fo:table>
	
                                                    </fo:block>
                                                </fo:table-cell>
                                                </fo:table-row>
                                            <fo:table-row height="10pt">
                                                <fo:table-cell display-align="after" border="solid 0.0pt #000000" padding-start="8pt" padding-end="8pt" padding-before="5pt" padding-after="3pt">
                                                    <fo:block font-size="8pt" font-style="normal" font-weight="normal" text-align="justify">
                                                        <xsl:value-of select="PRO_SOS_SUB_APP_DES"/>
                                                    </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
						
                                        </fo:table-body>
                                    </fo:table>
                                </fo:flow >
                            </fo:page-sequence>
                            -->
		<!-- Fine pagina verticale -->

            <fo:page-sequence master-reference="A4-vertical-notes">

                   <fo:static-content flow-name="xsl-region-end-ver">
                                    <fo:block font-family="sans-serif" font-size="8pt" text-align="right" margin-top="740pt">
					Pag.
                                        <fo:page-number/>
                                    </fo:block>
                                </fo:static-content>

                                <fo:static-content flow-name="xsl-region-after-ver" display-align="after" margin-right="15pt">
                                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                                        <fo:inline font-weight="bold" text-decoration="no-underline">NOTE GENERALI</fo:inline>
                                    </fo:block>
                                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                                        <fo:inline> - Ogni nuovo elemento relativo alla natura del presente documento, seppure emerso durante i lavori, dovrà essere segnalato al responsabile del Committente in tempi brevi.</fo:inline>
                                    </fo:block>
                                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                                        <fo:inline> - Si ritiene che il materiale introdotto dall'impresa appaltatrice/affidataria durante l'esercizio sia in buono stato, conforme alle normative vigenti e sotto la responsabilità dell'impresa stessa.</fo:inline>
                                    </fo:block>
                                    <fo:block font-family="sans-serif" font-size="8pt" text-align="justify">
                                        <fo:inline font-weight="bold" text-decoration="no-underline">NOTA 1</fo:inline>
                                        <fo:inline> - Compilare una scheda per ogni Impresa Subappaltatrice.</fo:inline>
                                    </fo:block>
                                </fo:static-content>
                
                <fo:static-content flow-name="xsl-region-before-hor">
                    <fo:block font-size="22pt"   text-align="center" display-align="justify" margin-left="6pt" margin-top="-2pt">
                        <fo:table width="100%"   margin-top="0pt" margin-bottom="0pt">
                            <fo:table-column column-width="60%" />
                            <fo:table-column column-width="40%" />
                            <fo:table-body>
                                <fo:table-row>
                                    <fo:table-cell number-rows-spanned="2"><!-- apro la cella che contiene la tabella innestata a sx -->
                                        <fo:block>
                                            <fo:table  width="99%"  margin-top="0pt" margin-bottom="0pt">
                                                <fo:table-column column-width="50%" />
                                                <fo:table-column column-width="50%" />
                                                <fo:table-body>
                                                    <fo:table-row>
                                                        <fo:table-cell number-columns-spanned="2" border="solid 1.0pt #000000" text-align="center" padding="4pt">
                                                            <fo:block font-size="9pt" font-weight="bold" text-align="center">
                                                                <fo:inline>LISTA DEL PERSONALE</fo:inline>
                                                            </fo:block>
                                                        </fo:table-cell>
                                                    </fo:table-row>
                                                    <fo:table-row>
                                                        <fo:table-cell border="solid 0.5pt #000000" text-align="center" padding="4pt">
                                                            <fo:block font-size="8pt" font-weight="normal" text-align="center">
													COGNOME E NOME
                                                            </fo:block>
                                                        </fo:table-cell>
                                                        <fo:table-cell border="solid 0.5pt #000000" padding="4pt" display-align="center" text-align="center">
                                                            <fo:block font-size="8pt" font-weight="normal" text-align="center">
													QUALIFICA
                                                            </fo:block>
                                                        </fo:table-cell>

                                                    </fo:table-row>
                                                </fo:table-body>
                                            </fo:table>
                                                </fo:block>
                                                    </fo:table-cell><!-- chiudo la cella che contiene la tabella innestata a sx -->
                                                    <fo:table-cell><!-- apro la cella che contiene la tabella innestata a dx -->
                                                        <fo:block display-align="justify"  margin-left="-2pt">

									<!-- inizio della tabella innestata a dx (nella prima riga, seconda colonna) -->
                                                            <fo:table width="100%" border="solid 0.0pt #000000"   margin-left="0pt" margin-top="0pt" margin-bottom="0pt">
                                                                <fo:table-column column-width="107.6%" />
                                                                <fo:table-body>
                                                                    <fo:table-row>
                                                                        <fo:table-cell border="solid 1.0pt #000000" text-align="center" padding="4pt">
                                                                            <fo:block font-size="9pt" font-weight="bold" text-align="center">
													ELENCO PRODOTTI/SOSTANZE
                                                                            </fo:block>
                                                                        </fo:table-cell>
                                                                    </fo:table-row>
                                                                   <fo:table-row>
                                                                        <fo:table-cell  text-align="center" padding="4pt">
                                                                            <fo:block font-size="9pt" font-weight="bold" text-align="center">

                                                                            </fo:block>
                                                                        </fo:table-cell>
                                                                    </fo:table-row>
                                                                     <fo:table-row>
                                                                        <fo:table-cell text-align="center" padding="4pt">
                                                                            <fo:block font-size="9pt" font-weight="bold" text-align="center">

                                                                            </fo:block>
                                                                        </fo:table-cell>
                                                                    </fo:table-row>
                                                                    <fo:table-row>
                                                                        <fo:table-cell text-align="center" padding="4pt">
                                                                            <fo:block font-size="9pt" font-weight="bold" text-align="center">

                                                                            </fo:block>
                                                                        </fo:table-cell>
                                                                    </fo:table-row>
                                                                </fo:table-body>
                                                            </fo:table>
									<!-- fine della tabella innestata a dx (nella prima riga, seconda colonna) -->

                                                        </fo:block>
                                                    </fo:table-cell><!-- chiudo la cella che contiene la tabella innestata a dx -->
                                                </fo:table-row>
                            </fo:table-body>
                           </fo:table>
                                        </fo:block>

                                    </fo:static-content>

                                    <fo:flow flow-name="xsl-region-body">
                                    <fo:block font-size="22pt" font-weight="bold"   text-align="center" display-align="justify" margin-left="-12pt" margin-top="36pt">

                                        <fo:table width="100%"   margin-top="0pt" margin-bottom="0pt">
                                            <fo:table-column column-width="60%" />
                                            <fo:table-column column-width="40%" />
                                            <fo:table-body>
                                                <fo:table-row>
                                                    <fo:table-cell number-rows-spanned="2"><!-- apro la cella che contiene la tabella innestata a sx -->
                                                        <fo:block margin-left="1pt">

									<!-- inizio della tabella innestata a sx (nella prima riga, prima colonna) -->
                                                            <fo:table width="90%" border-right="solid 1.0pt #000000" margin-left="20pt" margin-top="0pt" margin-bottom="0pt">
                                                                <fo:table-column column-width="50%" />
                                                                <fo:table-column column-width="50%" />
                                                                <fo:table-body>
                                        <!--<fo:table-row>
                                            <fo:table-cell number-columns-spanned="2" border="solid 1.0pt #000000" text-align="center" padding="4pt">
                                                <fo:block font-size="9pt" font-weight="bold" text-align="center">
                                                    <fo:inline>LISTA DEL PERSONALE</fo:inline>
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                        <fo:table-row>
                                            <fo:table-cell border="solid 0.5pt #000000" text-align="center" padding="4pt">
                                                <fo:block font-size="8pt" font-weight="normal" text-align="center">
													COGNOME E NOME
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell border="solid 0.5pt #000000" padding="4pt" display-align="center" text-align="center">
                                                <fo:block font-size="8pt" font-weight="normal" text-align="center">
													QUALIFICA
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                        -->

                                                                    <xsl:for-each select="Personale_coinvolto_sub_app/Personale">
                                                                    <xsl:apply-templates />
                                                                </xsl:for-each>

                                                              </fo:table-body>
                                                            </fo:table>
									<!-- fine della tabella innestata a sx (nella prima riga, prima colonna) -->
                                                        </fo:block>
                                                    </fo:table-cell><!-- chiudo la cella che contiene la tabella innestata a sx -->
                                                    <fo:table-cell><!-- apro la cella che contiene la tabella innestata a dx -->
                                                        <fo:block >

									<!-- inizio della tabella innestata a dx (nella prima riga, seconda colonna) -->
                                                            <fo:table width="100%" border="solid 0.0pt #000000"   margin-top="0pt"  margin-left="15pt" margin-bottom="0pt">
                                                                <fo:table-column column-width="100%" />
                                                                <fo:table-body>
                                                                  <!--  <fo:table-row>
                                                                        <fo:table-cell border="solid 1.0pt #000000" text-align="center" padding="4pt">
                                                                            <fo:block font-size="9pt" font-weight="bold" text-align="center">
													ELENCO PRODOTTI/SOSTANZE
                                                                            </fo:block>
                                                                        </fo:table-cell>
                                                                    </fo:table-row>
                                                                    -->
                                                                    <fo:table-row>
                                                                         <fo:table-cell text-align="left" padding="4pt" padding-left="4pt">
                                                                        <fo:block font-style="normal" font-weight="normal">
                                                                            <xsl:for-each select="ProdottiSostanze_sub_app/ProdottiSostanze">
                                                                                <xsl:apply-templates />
                                                                            </xsl:for-each>
                                                                        </fo:block>
                                                                    </fo:table-cell>
                                                                    </fo:table-row>
                                                                </fo:table-body>
                                                            </fo:table>
									<!-- fine della tabella innestata a dx (nella prima riga, seconda colonna) -->

                                                        </fo:block>
                                                    </fo:table-cell><!-- chiudo la cella che contiene la tabella innestata a dx -->
                                                </fo:table-row><!-- chiudo la riga che contiene le due tabelle -->

                                                <fo:table-row height="10pt">
                                                    <fo:table-cell display-align="after" border="solid 0.0pt #000000" padding-start="8pt" padding-end="8pt" padding-before="5pt" padding-after="3pt">
                                                    <fo:block font-size="8pt" font-style="normal" font-weight="normal" text-align="justify">
                                                        <xsl:value-of select="PRO_SOS_SUB_APP_DES"/>
                                                    </fo:block>
                                                </fo:table-cell>
                                                </fo:table-row>

                                            </fo:table-body>
                                        </fo:table>
                                     </fo:block>
                                    </fo:flow >

                                </fo:page-sequence>

		<!-- Inizio pagina orizzontale -->
		<!-- ************************************************************  DUVRI_07 ************************************************************  -->
                            <fo:page-sequence master-reference="A4-horizontal">
                
        <!--<fo:static-content flow-name="xsl-region-start-hor">
            <fo:block display-align="after" font-family="sans-serif" font-size="8pt" text-align="right" margin-left="16.0cm">
					Pag.
                <fo:page-number/>
            </fo:block>
        </fo:static-content>-->
			
                                <fo:static-content flow-name="xsl-region-start-hor" display-align="before" margin-right="45pt">
                                    <fo:block font-family="sans-serif" font-size="9pt" text-align="justify">
                                        <fo:inline>S2S S.r.l Sistema della sicurezza</fo:inline>
                                    </fo:block>
                                </fo:static-content>

                                <fo:static-content flow-name="xsl-region-after-hor">
                                    <fo:block display-align="after" font-family="sans-serif" font-size="8pt" text-align="right" margin-top="695pt">
					Pag.
                                        <fo:page-number/>
                                    </fo:block>
                                </fo:static-content>
                                <fo:static-content flow-name="xsl-region-end-hor">
                                    <fo:block border="solid 1.0pt #000000" font-family="sans-serif" font-size="12pt" font-weight="bold" font-style="normal" text-align="left" margin-right="0.03cm">
                                        <fo:block margin-left="3pt" margin-top="2pt" margin-bottom="1.2pt">
                                            <fo:inline font-size="11pt">SCHEDA B - DESCRIZIONE LAVORI/SERVIZI IMPRESA SUBAPPALTATRICE / ESECUTRICE</fo:inline>
                                            <fo:inline font-size="11pt" padding-left="5pt">
                                                <xsl:value-of select="SUB_APP_numero"/>
                                            </fo:inline>
                                        </fo:block>
                                        <fo:block margin-left="3pt" margin-top="1.2pt" margin-bottom="2pt">
                                            <fo:inline>
                                                <xsl:value-of select="SUBAPPALTATRICE_07"/>
                                            </fo:inline>
                                        </fo:block>
                                    </fo:block>
                                    <fo:block border-left="solid 1.0pt #000000" border-bottom="solid 1.0pt #000000" border-right="solid 1.0pt #000000" font-size="10pt" font-weight="bold" font-style="italic" text-align="left" margin-right="0.03cm">
                                        <fo:block margin-left="2pt" margin-top="2pt" margin-bottom="2pt">
					PARTE B - ANALISI DEI RISCHI
                                        </fo:block>
                                    </fo:block>
                                </fo:static-content>
                                <fo:static-content flow-name="xsl-region-before-hor">

                                    <fo:block display-align="justify" margin-left="14pt" margin-top="-30pt">

								<!-- TABELLA DEI RISCHI -->
                                        <fo:table width="95%" border="solid 0.0pt #000000" font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left">
                                            <fo:table-column column-width="15%" />
                                            <fo:table-column column-width="20%" />
                                            <fo:table-column column-width="20%" />
                                            <fo:table-column column-width="15%" />
                                            <fo:table-column column-width="30%" />
                                            <fo:table-body>
                                                <fo:table-row>
                                                    <fo:table-cell display-align="left" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block text-align="left">
													FASE DI LAVORO
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
													MODALITÀ OPERATIVE
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
													MATERIALI/PRODOTTI IMPIEGATI
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
													RISCHI
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell display-align="center" border="solid 1.0pt #000000" font-size="8pt" font-weight="bold" text-align="center" padding="4pt">
                                                        <fo:block>
													MISURE DI PREVENZIONE E PROTEZIONE ADOTTATE
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                            </fo:table-body>
                                        </fo:table>

                                    </fo:block>

                                </fo:static-content>
 
                                <fo:flow flow-name="xsl-region-body">
                                    <fo:table display-align="before" width="95%" border="solid 1.0pt #000000" font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left">
                                        <fo:table-column column-width="100%" />
                                        <fo:table-column column-width="0%" />
                                        <fo:table-body>
                                            <fo:table-row height="16.2cm">
                                                <fo:table-cell number-rows-spanned="2">
                                                    <fo:block margin-bottom="40pt">

								<!-- TABELLA DEI RISCHI -->
                                                        <fo:table display-align="before" width="100%" border="solid 0.0pt #000000" font-family="sans-serif" font-size="10pt" font-style="normal" font-weight="normal" text-align="left">

                                                            <fo:table-column column-width="15%" />
                                                            <fo:table-column column-width="20%" />
                                                            <fo:table-column column-width="20%" />
                                                            <fo:table-column column-width="15%" />
                                                            <fo:table-column column-width="30%" />
                                                            <fo:table-body top="100pt">
                                                                <xsl:for-each select="Analisi_rischi/Rischi">
                                                                    <xsl:apply-templates />
                                                                </xsl:for-each>
                                                            </fo:table-body>
                                                        </fo:table>
									
                                                    </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell>
                                                    <fo:block></fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                 
              
                                            <fo:table-row height="0.001cm">
                                                <fo:table-cell>
                           
                  
                                                    <fo:block>
                                                        <fo:inline> </fo:inline>
                                                    </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                        </fo:table-body>
                                    </fo:table>
							
                                </fo:flow>
                            </fo:page-sequence>
		<!-- Fine pagina orizzontale -->
                        </xsl:template>
	
<!-- DUVRI_06 -->
<!-- Tabella "LISTA DEL PERSONALE" SUBAPPALTATRICE -->
                        <xsl:template match="DUVRI/DUVRI_06/DESCRIZIONE_SERVIZI_SUB_APP/Subappaltatrici/Subappaltatrice/Personale_coinvolto_sub_app/Personale/Persona">
                            <fo:table-row height="15pt">
                                <fo:table-cell border="solid 0.25pt #000000" text-align="left" padding="4pt">
                                    <fo:block font-size="12pt" font-style="normal" font-weight="normal" margin-top="4pt" margin-bottom="4pt">
                                        <fo:inline font-size="10pt">
                                            <xsl:value-of select="NOM_num"/>
                                        </fo:inline>
                                        <fo:inline padding-left="5pt">
                                            <xsl:value-of select="NOM"/>
                                        </fo:inline>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" text-align="left" padding="4pt">
                                    <fo:block font-size="12pt" font-style="normal" font-weight="normal" margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="QUA"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:template>

<!-- Tabella "ELENCO PRODOTTI/SOSTANZE" SUBAPPALTATRICE  -->
                        <xsl:template match="DUVRI/DUVRI_06/DESCRIZIONE_SERVIZI_SUB_APP/Subappaltatrici/Subappaltatrice/ProdottiSostanze_sub_app/ProdottiSostanze/ProdottoSostanza">
                            <fo:block font-family="sans-serif" font-size="11pt" font-style="normal" font-weight="normal" text-align="left" padding-before="4pt" padding-after="4pt">
                                <fo:inline>
                                    <xsl:value-of select="DES"/>
                                </fo:inline>
                            </fo:block>
                        </xsl:template>

<!-- DUVRI_07 -->
<!-- Tabella "ANALISI DEI RISCHI SUBAPPALTATRICE" -->
                        <xsl:template match="DUVRI/DUVRI_06/DESCRIZIONE_SERVIZI_SUB_APP/Subappaltatrici/Subappaltatrice/Analisi_rischi/Rischi/Rischio">
                            <fo:table-row height="20pt">
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="FAS_LAV"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="MOD_OPE"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="MAT_PRO_IMP"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="RIS"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="MIS_PRE_PRO"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:template>

<!-- DUVRI_09 -->
<!-- Tabella "RISCHI CONNESSI ALL'INTERFERENZA" -->
                        <xsl:template match="DUVRI/DUVRI_09/RISCHI_CONNESSI_INTERFERENZA/Rischi_interferenza/Rischio_interferenza">
                            <fo:table-row height="20pt">
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="FAS_LAV"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="TIP_INT"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="IMP_INT"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="RIS"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="MIS_PRE"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:template>
    
<!-- DUVRI_10 -->
<!-- Tabella "MESSA A DISPOSIZIONE DEI SERVIZI SANITARI" -->
                        <xsl:template match="DUVRI/DUVRI_10/DISPOSIZIONE_SERVIZI_SANITARI/Servizi_sanitari/Servizio_sanitario">
                            <fo:table-row height="20pt">
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="DES_SRV_VIT"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="DAT_INI_IMP"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="DAT_FIN_IMP"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="ORA_IMP"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:template>
    
<!-- DUVRI_11 -->
<!-- Tabella "MESSA A DISPOSIZIONE DEI FLUIDI" -->
                        <xsl:template match="DUVRI/DUVRI_11/DISPOSIZIONE_FLUIDI/Fluidi/Fluido">
                            <fo:table-row height="20pt">
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="TIP_FLU_DIS"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="LUO_CON"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="DAT_INI_CON"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="DAT_FIN_CON"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:template>
    
<!-- DUVRI_12 -->
<!-- Tabella "PRESTITO MATERIALI" -->
                        <xsl:template match="DUVRI/DUVRI_12/PRESTITO_MATERIALI/Materiali/Materiale">
                            <fo:table-row height="20pt">
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="TIP_MAT"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell number-columns-spanned="2" border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="LUO_MES_DIS"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="DAT_INI_PRE"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.25pt #000000" padding="4pt">
                                    <fo:block margin-top="4pt" margin-bottom="4pt">
                                        <xsl:value-of select="DAT_FIN_PRE"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:template>
    
<!-- DUVRI_13 -->
<!-- Tabella "ACCORDO TRA LE PARTI" -->
                        <xsl:template match="DUVRI/DUVRI_13/ACCORDO_TRA_PARTI/Subappaltatrici/Subappaltatrice">
                            <fo:table-row height="70pt">
                                <fo:table-cell border="solid 0.5pt #000000" padding="4pt">
                                    <fo:block>
					SUBAPPALTATRICE n°
                                        <xsl:value-of select="SUB_APP_num"/>
                                        <fo:block font-size="10pt" font-style="normal" font-weight="bold" padding="15pt">
                                            <xsl:value-of select="RAG_SCL_DTE_sub_app"/>
                                        </fo:block>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.5pt #000000" padding="4pt">
                                    <fo:block>
                    LUOGO E DATA:
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid 0.5pt #000000" padding="4pt">
                                    <fo:block>
                    FIRMA E TIMBRO:
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:template>
    
<!-- Tabella "annotazione fondo pagina 13" -->
                        <xsl:template match="DUVRI/DUVRI_13/ACCORDO_TRA_PARTI/Subappaltatrici_nota/Subappaltatrice_nota">
                            <fo:block font-size="10pt" font-weight="normal" padding="3pt">
                                <fo:inline>    -  </fo:inline>
                                <fo:inline>
                                    <xsl:value-of select="RAG_SCL_DTE_sub_app_nota"/>
                                </fo:inline>
                            </fo:block>
                        </xsl:template>
    
                    </xsl:stylesheet>

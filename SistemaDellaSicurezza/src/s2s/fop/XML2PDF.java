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
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* $Id: XML2PDF.java,v 1.1 2015/08/06 09:52:59 agnese.cavola Exp $ */
 
package s2s.fop;

//Java
import java.io.File;
import java.io.OutputStream;

//JAXP
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.Source;
import javax.xml.transform.Result;
import javax.xml.transform.stream.StreamSource;
import javax.xml.transform.sax.SAXResult;

//FOP
import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;

/**
 * This class demonstrates the conversion of an XML file to PDF using 
 * JAXP (XSLT) and FOP (XSL-FO).
 */
public class XML2PDF {

    /**
     * Main method.
     * @param args command-line arguments
     */
    private String xmlFileName;
    private String xslFileName;
    private String pdfFileName;
    private String xslDir;
    private String xmlDir;
    private String outDir;
    private boolean writePDFtoDisk = true;
    
    // xmlFileName
    public String getXmlFileName(){
        return xmlFileName;
    }
    
    public void setXmlFileName(String _xmlFileName){
        xmlFileName = _xmlFileName;
    }
            
    // xslFileName
    public String getXslFileName(){
        return xslFileName;
    }
    
    public void setXslFileName(String _xslFileName){
        xslFileName = _xslFileName;
    }
    
    // pdfFileName
    public String getPdfFileName(){
        return pdfFileName;
    }
    
    public void setPdfFileName(String _pdfFileName){
        pdfFileName = _pdfFileName;
    }

    // xslDir
    public String getXSLDir(){
        return xslDir;
    }
    
    public void setXSLDir(String _xslDir){
        xslDir = _xslDir;
    }

    // xmlDir
    public String getXMLDir(){
        return xmlDir;
    }
    
    public void setXMLDir(String _xmlDir){
        xmlDir = _xmlDir;
    }
    
    // outDir
    public String getOutDir(){
        return outDir;
    }
    
    public void setOutDir(String _outDir){
        outDir = _outDir;
    }
    
    // writePDFtoDisk
    public boolean getWritePDFtoDisk(){
        return writePDFtoDisk;
    }
    
    public void setWritePDFtoDisk(boolean _writePDFtoDisk){
        writePDFtoDisk = _writePDFtoDisk;
    }
    
    public void ConvertXML2PDF() throws Exception{
        try {
            if (    xmlFileName == null ||
                    xslFileName == null ||
                    xslDir == null ||
                    xmlDir == null){
                throw (new Exception("File xml/xsl e/o xslDir/xmlDir non trovati."));
            } else {
                if (writePDFtoDisk && outDir == null){
                    throw (new Exception("Direcory di output e/o nome del PDF non impostati."));
                }
            }
            
            // Setup directories
            new File(outDir).mkdirs();

            // Setup input and output files            
            File xmlfile = new File(xmlDir, xmlFileName);
            File xsltfile = new File(xslDir, xslFileName);
            File pdffile = new File(outDir, pdfFileName);

            // configure fopFactory as desired
            FopFactory fopFactory = FopFactory.newInstance();

            FOUserAgent foUserAgent = fopFactory.newFOUserAgent();
            // configure foUserAgent as desired

            // Setup output
            OutputStream out = new java.io.FileOutputStream(pdffile);
            out = new java.io.BufferedOutputStream(out);
            
            try {
                // Construct fop with desired output format
                Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, foUserAgent, out);
    
                // Setup XSLT
                TransformerFactory factory = TransformerFactory.newInstance();
                Transformer transformer = factory.newTransformer(new StreamSource(xsltfile));
                
                // Set the value of a <param> in the stylesheet
                transformer.setParameter("versionParam", "2.0");
            
                // Setup input for XSLT transformation
                Source src = new StreamSource(xmlfile);
            
                // Resulting SAX events (the generated FO) must be piped through to FOP
                Result res = new SAXResult(fop.getDefaultHandler());
    
                // Start XSLT transformation and FOP processing
                transformer.transform(src, res);
            } finally {
                out.close();
            }
        } catch (Exception e) {
            e.printStackTrace(System.err);
            throw e;
        }
    }
}

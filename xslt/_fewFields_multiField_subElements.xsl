<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:mods="http://www.loc.gov/mods/v3"
    xmlns:fgdc="http://www.fgdc.gov/schemas/metadata/fgdc-std-001-1998.xsd"
    xmlns:etd="http://www.ndltd.org/standards/metadata/etd-ms-v1.1.html"
    xmlns:vra="https://www.loc.gov/standards/vracore/vra.xsd"
    xmlns:dwc="http://rs.tdwg.org/dwc/terms/" xmlns:dwr="http://rs.tdwg.org/dwc/xsd/simpledarwincore/" 
    version="2.0">
    
    
    <xsl:output method="text"/>
    
    <!-- Sets the field separator with a variable; 
        if necessary, it can be reset throughout -->
    <xsl:variable name="separator" select="'&#9;'"/>
    
    <xsl:template match="/">
        <xsl:call-template name="headerRow"/>
        <xsl:apply-templates select="mods:modsCollection/mods:mods"/>
    </xsl:template>
    
    <!-- Begin header row -->
    <!-- 
        Uses the mappings from the CLAW MIG Spring Prep Mapping spreadsheet, at 
        https://docs.google.com/spreadsheets/d/18u2qFJ014IIxlVpM3JXfDEFccwBZcoFsjbBGpvL0jJI/edit#gid=0.
        The mapped XPaths are used to create column headers.
    -->
    <xsl:template name="headerRow">
        <xsl:text>PID</xsl:text>
        <xsl:value-of select="$separator"/>
        <xsl:text>no physicalDescription reformattingQuality</xsl:text>       
        <!-- New line for next record -->
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>
    <!-- End header row -->
    
    <!-- Begin building record rows, one row per <mods> element in source document -->
    <xsl:template match="mods:mods">
        
        <!-- This script will select each parent element, but only show values if the child element is present -->
        
        <xsl:for-each select="mods:subject/mods:format"> 
            
<!--                        <xsl:if test=".!=''">-->
            
<!--                            <xsl:choose>
                                <xsl:when test="mods:titleInfo"/>
                                <xsl:otherwise>-->
            
            <xsl:for-each select="../../mods:identifier[@displayLabel='7.X PID']">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:for-each>
            
            <xsl:value-of select="$separator"/>

            <xsl:for-each select=".">
            <xsl:choose>
                <xsl:when test="position()=last()">
                    <xsl:value-of select="normalize-space(.)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="normalize-space(.)"/>
                    <xsl:text>|</xsl:text>                    
                </xsl:otherwise>
            </xsl:choose>
            </xsl:for-each>
            
            <xsl:value-of select="$separator"/>
            
            <xsl:for-each select="../../mods:physicalDescription/mods:form">
                <xsl:choose>
                    <xsl:when test="position()=last()">
                        <xsl:value-of select="normalize-space(.)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(.)"/>
                        <xsl:text>|</xsl:text>                    
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
            
            <xsl:value-of select="$separator"/>
            
            <xsl:for-each select="mods:languageTerm[@type='code']">
                <xsl:choose>
                    <xsl:when test="position()=last()">
                        <xsl:value-of select="normalize-space(@authority)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(@authority)"/>
                        <xsl:text>|</xsl:text>                    
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
            
            <xsl:value-of select="$separator"/>
            
            <xsl:for-each select="mods:languageTerm[@type='code']">
                <xsl:choose>
                    <xsl:when test="position()=last()">
                        <xsl:value-of select="normalize-space(.)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(.)"/>
                        <xsl:text>|</xsl:text>                    
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
            
            <xsl:value-of select="$separator"/>
            
            <xsl:for-each select="mods:lanugageTerm">
                <xsl:choose>
                    <xsl:when test="position()=last()">
                        <xsl:value-of select="normalize-space(@type)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(@type)"/>
                        <xsl:text>|</xsl:text>                    
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
            
            <xsl:value-of select="$separator"/>
            
            <xsl:for-each select="mods:lanugageTerm">
                <xsl:choose>
                    <xsl:when test="position()=last()">
                        <xsl:value-of select="normalize-space(@authority)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(@authority)"/>
                        <xsl:text>|</xsl:text>                    
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
            
            <xsl:value-of select="$separator"/>
            
            <xsl:for-each select="mods:lanugageTerm">
                <xsl:choose>
                    <xsl:when test="position()=last()">
                        <xsl:value-of select="normalize-space(.)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(.)"/>
                        <xsl:text>|</xsl:text>                    
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>

<!--            <xsl:value-of select="$separator"/>
            
            <xsl:for-each select="mods:languageOfCataloging">
                
                <xsl:choose>
                    <xsl:when test="position()=last()">
                        <xsl:value-of select="normalize-space(.)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(.)"/>
                        <xsl:text>|</xsl:text>                    
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>-->
            
<!--            <xsl:value-of select="$separator"/>
            
            <xsl:for-each select="mods:desciptionStandard">
                
                <xsl:choose>
                    <xsl:when test="position()=last()">
                        <xsl:value-of select="normalize-space(.)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(.)"/>
                        <xsl:text>|</xsl:text>                    
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>-->
            
<!--            <xsl:value-of select="$separator"/>
            
            <xsl:for-each select="mods:dateIssued">
                
                <xsl:choose>
                    <xsl:when test="position()=last()">
                        <xsl:value-of select="normalize-space(.)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(.)"/>
                        <xsl:text>|</xsl:text>                    
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
            
            <xsl:value-of select="$separator"/>
            
            <xsl:for-each select="mods:dateCaptured">
                
                <xsl:choose>
                    <xsl:when test="position()=last()">
                        <xsl:value-of select="normalize-space(.)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(.)"/>
                        <xsl:text>|</xsl:text>                    
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
            
            <xsl:value-of select="$separator"/>
            
            <xsl:for-each select="mods:dateOther">
                
                <xsl:choose>
                    <xsl:when test="position()=last()">
                        <xsl:value-of select="normalize-space(.)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(.)"/>
                        <xsl:text>|</xsl:text>                    
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
            
            <xsl:value-of select="$separator"/>
            
            <xsl:for-each select="mods:publisher">
                
                <xsl:choose>
                    <xsl:when test="position()=last()">
                        <xsl:value-of select="normalize-space(.)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(.)"/>
                        <xsl:text>|</xsl:text>                    
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
            
            <xsl:value-of select="$separator"/>
            
            <xsl:for-each select="mods:issuance">
                
                <xsl:choose>
                    <xsl:when test="position()=last()">
                        <xsl:value-of select="normalize-space(.)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(.)"/>
                        <xsl:text>|</xsl:text>                    
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
            
            <xsl:value-of select="$separator"/>
            
            <xsl:for-each select="mods:frequency">
                
                <xsl:choose>
                    <xsl:when test="position()=last()">
                        <xsl:value-of select="normalize-space(.)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(.)"/>
                        <xsl:text>|</xsl:text>                    
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each> -->
            
        <!-- New line for next record -->            
            <xsl:text>&#xa;</xsl:text>
            
            <!--</xsl:if>-->
            <!--</xsl:otherwise>
                </xsl:choose>-->
        </xsl:for-each>
        
        <!-- THE END -->
        

        
    </xsl:template>
    
</xsl:stylesheet>
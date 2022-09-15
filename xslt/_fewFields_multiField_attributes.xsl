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
        <xsl:text>@type</xsl:text>       
        <xsl:value-of select="$separator"/>
        <xsl:text>identifier</xsl:text>
<!--        <xsl:value-of select="$separator"/>
        <xsl:text>TOPIC</xsl:text> --> 
        <!-- New line for next record -->
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>
    <!-- End header row -->
    
    <!-- Begin building record rows, one row per <mods> element in source document -->
    <xsl:template match="mods:mods">
        
        <!-- This script tests for a top level element. If that element exists it records the element plus one other. A single row will be created for each PID, with multiple values separated by an | -->
        
        <xsl:for-each select="mods:identifier[not(@displayLabel)]">
            
            <xsl:for-each select="../mods:identifier[@displayLabel='7.X PID']">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:for-each>
            
            <xsl:value-of select="$separator"/>

               
                <xsl:for-each select="@type">
                    <xsl:value-of select="normalize-space(.)"/>
                </xsl:for-each>
                
                <xsl:value-of select="$separator"/>

<!--                <xsl:for-each select="@valueURI">
                    <xsl:value-of select="normalize-space(.)"/>
                </xsl:for-each>
                
                <xsl:value-of select="$separator"/>-->
                
<!--            <xsl:for-each select="mods:topic">-->
                    <xsl:choose>
                        <xsl:when test="position()=last()">
                            <xsl:value-of select="normalize-space(.)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="normalize-space(.)"/>
                            <xsl:text>|</xsl:text>                    
                        </xsl:otherwise>
                    </xsl:choose>   
                <!--</xsl:for-each>-->

            <xsl:text>&#xa;</xsl:text>         
            
        </xsl:for-each>
        
        <!-- THE END -->
        
        <!-- New line for next record -->
        <xsl:text>&#xa;</xsl:text>
        
    </xsl:template>
    
</xsl:stylesheet>
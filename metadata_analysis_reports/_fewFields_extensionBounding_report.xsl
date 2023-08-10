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
        <xsl:apply-templates select="modsCollection/mods"/>
    </xsl:template>
    
    <!-- Begin header row -->

    <xsl:template name="headerRow">
        <xsl:text>PID</xsl:text>
        <xsl:value-of select="$separator"/>
        <xsl:text>FGDC SPDOM Bounding / West Bounding Coordinate</xsl:text>
        <xsl:value-of select="$separator"/>
        <xsl:text>FGDC SPDOM Bounding / East Bounding Coordinate</xsl:text>      
        <xsl:value-of select="$separator"/>
        <xsl:text>FGDC SPDOM Bounding / North Bounding Coordinate</xsl:text>      
        <xsl:value-of select="$separator"/>        
        <xsl:text>FGDC SPDOM Bounding / South Bounding Coordinate</xsl:text>
        <!-- New line for next record -->
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>
    <!-- End header row -->
    
    <!-- Begin building record rows, one row per <mods> element in source document -->
    <xsl:template match="mods">
        
        <!-- Will export a row for every PID with an extension element, but only include Identifier if there is a child element -->
        <!-- Cell value for Extension/FGDC SPDOM Bounding ; this is an example of an extension with numerous parent elements before the child with a value -->
        
        <xsl:for-each select="extension">
            <xsl:for-each select="*[local-name() = 'metadata']">
                <xsl:for-each select="*[local-name() = 'idinfo']">
                    <xsl:for-each select="*[local-name() = 'spdom']">
                        <xsl:for-each select="*[local-name() = 'bounding']">
            
                            <xsl:for-each select="../../../../../identifier[@displayLabel='7.X PID']">
                                <xsl:value-of select="normalize-space(.)"/>
                            </xsl:for-each>
            
                            <xsl:value-of select="$separator"/>
            
                            <xsl:for-each select="*[local-name() = 'westbc']">
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
            
                            <xsl:for-each select="*[local-name() = 'eastbc']">
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
            
                            <xsl:for-each select="*[local-name() = 'northbc']">
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
            
                            <xsl:for-each select="*[local-name() = 'southbc']">
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
                            
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:for-each>

        </xsl:for-each>
        
        <!-- THE END -->
        
        <!-- New line for next record -->
        <xsl:text>&#xa;</xsl:text>
        
    </xsl:template>
    
</xsl:stylesheet>
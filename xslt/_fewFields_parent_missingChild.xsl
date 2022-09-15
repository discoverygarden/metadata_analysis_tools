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
        <xsl:text>@authority</xsl:text>
        <xsl:value-of select="$separator"/>
        <xsl:text>mods:languageTerm</xsl:text>
        <xsl:value-of select="$separator"/>
        <xsl:text>no mods:languageTerm</xsl:text>
       <xsl:value-of select="$separator"/>
        <xsl:text>mods:languageTerm @type</xsl:text>
        <xsl:value-of select="$separator"/>
        <xsl:text>mods:languageTerm @authority</xsl:text>
        <!--        <xsl:value-of select="$separator"/>
        <xsl:text>cartographics</xsl:text>
        <xsl:value-of select="$separator"/>
        <xsl:text>name</xsl:text>
        <xsl:value-of select="$separator"/>
        <xsl:text>name[@type=personal] pages</xsl:text>
        <xsl:value-of select="$separator"/>
        <xsl:text>name[@type='conference']</xsl:text>
        <xsl:value-of select="$separator"/>
        <xsl:text>name[@type='local']</xsl:text>
        <xsl:value-of select="$separator"/>
        <xsl:text>name[not(@type)]</xsl:text>
        <xsl:value-of select="$separator"/>
        <xsl:text>titleInfo/title</xsl:text>
        <xsl:value-of select="$separator"/>
        <xsl:text>temporal</xsl:text>
        <xsl:value-of select="$separator"/>
        <xsl:text>topic</xsl:text>
        <xsl:value-of select="$separator"/>
        <xsl:text>topical</xsl:text>
        <xsl:value-of select="$separator"/>
        <xsl:text>cartographics</xsl:text>
        <xsl:value-of select="$separator"/>
        <xsl:text>geographic</xsl:text>
        <xsl:value-of select="$separator"/>
        <xsl:text>geographicCode</xsl:text>
        <xsl:value-of select="$separator"/>
        <xsl:text>hierarchicalGeographic</xsl:text>-->
        <!-- New line for next record -->
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>
    <!-- End header row -->
    
    <!-- Begin building record rows, one row per <mods> element in source document -->
    <xsl:template match="mods:mods">
        
        <!-- This script will select each parent element, but only show values if the child element is present -->
        <xsl:for-each select="mods:originInfo/mods:place"> 
            
<!--            <xsl:choose>
                <xsl:when test="coordinates"/>
                <xsl:otherwise>-->
            
            <xsl:for-each select="../../mods:identifier[@displayLabel='7.X PID']">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:for-each>
            
<!--            <xsl:value-of select="$separator"/>
                        
            <xsl:for-each select="[@usage]">
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
            
            <xsl:for-each select="[@authority]">
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
            
            <xsl:value-of select="$separator"/>
            
            <xsl:choose>
                <xsl:when test="mods:placeTerm"/>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="position()=last()">
                            <xsl:value-of select="normalize-space(.)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="normalize-space(.)"/>
                            <xsl:text>|</xsl:text>                    
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="$separator"/>
            
            <xsl:choose>
                <xsl:when test="mods:placeTerm">
                    <xsl:for-each select="mods:placeTerm">
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
                </xsl:when>
            </xsl:choose>
            <xsl:value-of select="$separator"/>
            

           
            <xsl:for-each select="mods:placeTerm">
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

<!--            <xsl:value-of select="$separator"/>
            
            <xsl:for-each select="mods:role/mods:roleTerm">
                <xsl:choose>
                    <xsl:when test="position()=last()">
                        <xsl:value-of select="normalize-space(@marcrelator)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(@marcrelator)"/>
                        <xsl:text>|</xsl:text>                    
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
            
            <xsl:value-of select="$separator"/>
            
            <xsl:for-each select="country[@authority]">
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

            <xsl:for-each select="country">
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
            
            <xsl:for-each select="region[@authority]">
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
            
            <xsl:for-each select="region">
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
            
            <xsl:for-each select="state[@authority]">
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
            
            <xsl:for-each select="state">
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
            
            <xsl:for-each select="province[@authority]">
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
            
            <xsl:for-each select="province">
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
            
            <xsl:for-each select="county[@authority]">
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
            
            <xsl:for-each select="county">
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
            
            <xsl:for-each select="city[@authority]">
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
            
            <xsl:for-each select="city">
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
            
            <xsl:for-each select="citySection[@authority]">
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
            
            <xsl:for-each select="citySection">
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
            
            <xsl:for-each select="geographic">
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
            
            <xsl:for-each select="geographicCode">
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
            
            <xsl:for-each select="hierarchicalGeographic">
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
            
            <xsl:for-each select="part[not(@type)]/extent/total">
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
            
            <xsl:for-each select="part[not(@type)]/text">
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
                    
                <!--</xsl:otherwise>
            </xsl:choose>-->
            
            <xsl:text>&#xa;</xsl:text>
            
        </xsl:for-each>

        
        
        <!-- THE END -->
        
        <!-- New line for next record -->
        
        
    </xsl:template>
    
</xsl:stylesheet>
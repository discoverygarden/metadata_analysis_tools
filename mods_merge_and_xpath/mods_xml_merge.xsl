<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:mods="http://www.loc.gov/mods/v3"
    xmlns="http://www.loc.gov/mods/v3"
    xpath-default-namespace="http://www.loc.gov/mods/v3"
    version="2.0">

    <!--   
    This stylesheet merges a directory of MODS XML files into a single XML file 
    with a modsCollection root element. Source document namespaces are omitted.
    -->

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

    <!-- USER: update the value with the path to the directory where the MODS XML files are located;
            Note that the trailing slash must be present. -->
    <xsl:param name="directoryName">
        <xsl:text>mods/</xsl:text>
    </xsl:param>
    
    <!-- Creates the root modsCollection element and calls XML documents in the named directory -->
    <xsl:template match="/">
        <modsCollection xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
            xmlns:xs="http://www.w3.org/2001/XMLSchema"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:mods="http://www.loc.gov/mods/v3"
            xmlns="http://www.loc.gov/mods/v3">
            <xsl:apply-templates select="collection('mods?select=*.xml')//mods"/>
        </modsCollection>
    </xsl:template>

    <!-- Identity transform to copy the contents of each MODS XML file;
        Removes empty elements and attributes. -->
    <xsl:template match="@* | node()">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="@*[normalize-space()] | node()[normalize-space()]"/>
        </xsl:copy>
    </xsl:template>

    <!-- Specifically for MODS extracted with Islandora Datastream CRUD;
        Extracts and formats the item PID using the filename of each MODS XML file;
        Adds the PID as an identifier as the first element of the outputted MODS record.
         -->
    <xsl:template match="mods/*[1]">
        <xsl:if test="contains(base-uri(.), '.xml')">
            <identifier type="PID" displayLabel="7.X PID">
                <xsl:value-of
                    select="replace(replace(substring-after(base-uri(.), $directoryName), '.xml', ''), '_', ':')"
                />
            </identifier>
        </xsl:if>
        <xsl:copy-of select="." copy-namespaces="no"/>
    </xsl:template>

</xsl:stylesheet>

# mods merge and xpath analysis
This repository includes two scripts for creating a single xml file merging a large number of individual mods xml files and then exporting a list of the xpaths found in that collection of xml. It is based on scripts from the [xml2csv](https://github.com/carakey/xml2csv) repository which were originally developed to create a spreadsheet featuring all the mods data found in a large collection of xml. This adaptation takes uses only the first two steps and has slightly tweaked the scripts.

##Process
###1. Prepare a single source MODS XML document
Discovery Garden has methods to do a mods datastream export that have been used in the past. Those are not recorded here. An alternative is using [Islandora Datastream CRUD](https://github.com/SFULibrary/islandora_datastream_crud). This utility will produce one MODS XML file per PID.
Place the downloaded MODS XML files into a single folder titled "mods" within the folder you are keeping the scripts. If you want to place them elsewhere, or name the folder differently, update lines 19-21 in **mods_xml_merge.xsl** with the new folder location:
	```
    <xsl:param name="directoryName">
        <xsl:text>mods/</xsl:text>
    </xsl:param>
    ```
Merge the multiple MODS XML files into a single "MODS Collection" XML file with a `<modsCollection>` root element using **mods_xml_merge.xsl**. This stylesheet will remove empty elements and attributes from the source data. Save the file in your main folder and name it something like client_mods_merged.xml
This script will also add an `<identifier>` element to each MODS record, with the item's PID as its value, derived from the MODS XML filename.
```
      <identifier type="local" displayLabel="7.X PID">islandora:10096-MODS</identifier>
```
###2. Create a list of all XPaths in the metadata
The **xpath_list.xsl** stylesheet reads a source XML file and outputs an arbitrary XML file listing each XPath in the source as a string. In the resulting document, the distinct-values() function may be used to identify unique XPaths.
Save the resulting xml with a name like client_xpaths_raw.xml so that you have a back-up, because the data will need to be manipulated before you will have a clean list of xpaths.
```
<?xml version="1.0" encoding="UTF-8"?>
<xpathList>
   <xpath>/modsCollection/mods/identifier[@type="PID"][@displayLabel="7.X PID"]</xpath>
   <xpath>/modsCollection/mods/titleInfo/title</xpath>
   <xpath>/modsCollection/mods/name[@type="personal"]/role/roleTerm[@authority="marcrelator"][@type="text"]</xpath>
   <xpath>/modsCollection/mods/name[@type="personal"]/role/roleTerm[@authority="marcrelator"][@type="text"]</xpath>
   <xpath>/modsCollection/mods/name[@type="corporate"]/namePart</xpath>
   <xpath>/modsCollection/mods/name[@type="corporate"]/role/roleTerm[@authority="marcrelator"][@type="text"]</xpath>
   <xpath>/modsCollection/mods/name[@type="corporate"]/role/roleTerm[@authority="marcrelator"][@type="text"]</xpath>
   <xpath>/modsCollection/mods/typeOfResource</xpath>
```
###3. Clean xpaths list
The initial xpaths list will include numerous duplicates or xpaths that are the same but with different attribute arrangement. I recommend taking the following steps to create a clean list:
1. Make a copy of the xml as a working document and open it in a text editor. I recommend BBEdit, as it has free tools that meet most of my needs, but you just need the ability to remove duplicates, find/replace, and sort the text.
2. Remove the ```<xpath>``` and ```</xpath>``` tags from the text of the document. Also remove the opening and closing xml tags, leaving the content of each element as plain text.
3. Remove the ```/modsCollection/``` from the beginning of each line.
4. Sort the data into alphabetical order and then run an action to remove duplicates. Process duplicate lines in BBEdit
5. Remove variants of **mods** from the xpaths. When the original xpaths were created they were given prefixes based on the version of mods in the documents header. Because of this you will need to find and replace things like:
- mods[@version="3.4"] OR mods[@version="3.5"] > mods
- mods: > remove from all elements
6. Keep finding/replacing these variant prefixes, deduplicating and sorting between each find/replace. Eventually you will have a simple list where all lines are formatted like ```mods/name[@type="corporate"]/namePart```
7. Final step would be removing variants that are duplicates. For our purposes ```mods/name[@type="corporate"]/role/roleTerm[@authority="marcrelator"][@type="text"]```
and ```mods/name[@type="corporate"]/role/roleTerm[@type="text"][@authority="marcrelator"]``` are the same XPath, as the order of the attributes will not matter in migration. You can remove one of these for clarities sake.


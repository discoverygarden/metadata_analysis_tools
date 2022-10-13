# metadata_analysis_tools / xslt
A collection of scripts for reporting on xpaths of a large group of mods xml data and running reports on individual elements, or groups of elements, and their attributes.

##mods_merge_and_xpath
In this folder are two xsl scripts to, first, merge a large group of MODS xml files and then produce a report analyzing the xpaths from that merged file. It is based on scripts from the [xml2csv](https://github.com/lsulibraries/xml2csv) repository, slightly adjusted and only using the first two steps. For adapted instructions see the README in that folder.
##metadata_analysis_reports
A collection of xslt to create tsv reports derived from the merged mods xml document created in mods_merge_and_xpath. Several variants are included, templates to export a single element and its attributes, a selection of children elements under a single parent, and to deal with cases of non-mods extensions. All should include the structure needed for specific use cases.

